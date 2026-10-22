import 'dart:convert';

import 'package:spotify/spotify.dart';
import 'package:test/test.dart';

void main() {
  final factories = <String, SpokenAudioContent Function(Map<String, dynamic>)>{
    'Episode': EpisodeSimple.fromJson,
    'EpisodeFull': Episode.fromJson,
    'ChapterSimple': ChapterSimple.fromJson,
    'Chapter': Chapter.fromJson,
  };

  for (final entry in factories.entries) {
    test('${entry.key} inherits spoken metadata and encodes listening progress', () {
      final input = <String, dynamic>{
        'id': 'audio-id',
        'type': 'episode',
        'uri': 'spotify:episode:audio-id',
        'description': 'A description',
        'html_description': '<p>A description</p>',
        'images': [
          {'url': 'https://example.com/cover.jpg'},
        ],
        'languages': ['en', 'de'],
        'duration_ms': 1250.0,
        'explicit': true,
        'is_playable': false,
        'resume_point': {'fully_played': false, 'resume_position_ms': 750.0},
      };
      final content = entry.value(input);
      expect(content.uri, EpisodeUri('audio-id'));
      expect(content.type, SpotifyContentType.episode);
      expect(content.description, 'A description');
      expect(content.htmlDescription, '<p>A description</p>');
      expect(content.images?.single.url, 'https://example.com/cover.jpg');
      expect(content.languages, ['en', 'de']);
      expect(content.duration, const Duration(milliseconds: 1250));
      expect(content.explicit, isTrue);
      expect(content, isA<Explicitable>());
      expect(content.isPlayable, isFalse);
      expect(content.resumePoint?.fullyPlayed, isFalse);
      expect(content.resumePoint?.resumePosition, const Duration(milliseconds: 750));

      final output = jsonDecode(jsonEncode(content)) as Map<String, dynamic>;
      for (final key in ['description', 'html_description', 'languages', 'resume_point']) {
        expect(output[key], input[key]);
      }
      expect(output, isNot(contains('uri')));
      expect(output, isNot(contains('duration')));
      expect(output['resume_point'], isNot(contains('resumePosition')));
      expect(entry.value(output).resumePoint?.resumePositionMs, 750);
    });

    test('${entry.key} preserves year, month, and day release dates', () {
      final dates = {
        '1981': DatePrecision.year,
        '1981-12': DatePrecision.month,
        '1981-12-15': DatePrecision.day,
      };
      for (final date in dates.entries) {
        final content = entry.value({
          'release_date': date.key,
          'release_date_precision': date.value.name,
        });
        expect(content.releaseDate, date.key);
        expect(content.releaseDatePrecision, date.value);
        final output = jsonDecode(jsonEncode(content)) as Map<String, dynamic>;
        expect(output['release_date'], date.key);
        expect(output['release_date_precision'], date.value.name);
      }
    });

    test('${entry.key} accepts omitted spoken metadata', () {
      final content = entry.value({});
      expect(content.description, isNull);
      expect(content.htmlDescription, isNull);
      expect(content.images, isNull);
      expect(content.languages, isNull);
      expect(content.releaseDate, isNull);
      expect(content.releaseDatePrecision, isNull);
      expect(content.resumePoint, isNull);
      expect(content.uri, isNull);
    });
  }
}
