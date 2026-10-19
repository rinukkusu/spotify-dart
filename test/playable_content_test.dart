import 'dart:convert';

import 'package:spotify/spotify.dart';
import 'package:test/test.dart';

Map<String, dynamic> audioJson(String type) => {
      'href': 'https://api.spotify.com/v1/${type}s/audio-id',
      'id': 'audio-id',
      'uri': 'spotify:$type:audio-id',
      'type': type,
      'name': 'Audio title',
      'external_urls': {'spotify': 'https://open.spotify.com/$type/audio-id'},
      'duration_ms': 1234.0,
      'explicit': true,
      'is_playable': false,
    };

Map<String, dynamic> trackJson() => {
      ...audioJson('track'),
      'artists': [
        {'id': 'artist-id', 'name': 'Artist'},
      ],
      'disc_number': 2.0,
      'track_number': 3.0,
      'preview_url': 'https://example.com/preview.mp3',
    };

Map<String, dynamic> episodeJson() => {
      ...audioJson('episode'),
      'audio_preview_url': 'https://example.com/episode.mp3',
      'description': 'Episode description',
      'images': [
        {'url': 'https://example.com/cover.jpg', 'width': 640, 'height': 640},
      ],
      'is_externally_hosted': true,
      'language': 'en',
      'languages': ['en', 'de'],
      'release_date': '2024-01-02T00:00:00.000',
      'release_date_precision': 'day',
    };

// Exercise the public JSON encoder, including nested model serialization.
Map<String, dynamic> encoded(Object model) => jsonDecode(jsonEncode(model)) as Map<String, dynamic>;

void expectAudio(PlayableContent content, SpotifyContentType type) {
  expect(content.href, 'https://api.spotify.com/v1/${type.name}s/audio-id');
  expect(content.id, 'audio-id');
  expect(content.uri, 'spotify:${type.name}:audio-id');
  expect(content.type, type);
  expect(content.name, 'Audio title');
  expect(content.externalUrls?.spotify, 'https://open.spotify.com/${type.name}/audio-id');
  expect(content.durationMs, 1234);
  expect(content.duration, const Duration(milliseconds: 1234));
  expect(content.explicit, isTrue);
  expect(content.isPlayable, isFalse);
}

void expectTrack(TrackSimple track) {
  expectAudio(track, SpotifyContentType.track);
  expect(track.artists?.single.name, 'Artist');
  expect(track.discNumber, 2);
  expect(track.trackNumber, 3);
  expect(track.previewUrl, 'https://example.com/preview.mp3');
}

void expectEpisode(Episode episode) {
  expectAudio(episode, SpotifyContentType.episode);
  expect(episode.audioPreviewUrl, 'https://example.com/episode.mp3');
  expect(episode.description, 'Episode description');
  expect(episode.images?.single.url, 'https://example.com/cover.jpg');
  expect(episode.isExternallyHosted, isTrue);
  expect(episode.language, 'en');
  expect(episode.languages, ['en', 'de']);
  expect(episode.releaseDate, DateTime(2024, 1, 2));
  expect(episode.releaseDatePrecision, 'day');
}

void expectJsonFields(Map<String, dynamic> actual, Map<String, dynamic> expected) {
  for (final entry in expected.entries) {
    final value = entry.value;
    if (value is Map<String, dynamic>) {
      expectJsonFields(actual[entry.key] as Map<String, dynamic>, value);
    } else if (value is List && value.isNotEmpty && value.first is Map<String, dynamic>) {
      final items = actual[entry.key] as List;
      expect(items, hasLength(value.length));
      for (var i = 0; i < value.length; i++) {
        expectJsonFields(items[i] as Map<String, dynamic>, value[i] as Map<String, dynamic>);
      }
    } else {
      expect(actual[entry.key], value, reason: entry.key);
    }
  }
  expect(actual, isNot(contains('duration')));
}

void main() {
  test('TrackSimple inherits audio fields and preserves track JSON', () {
    final input = trackJson();
    final track = TrackSimple.fromJson(input);
    expectTrack(track);
    final output = encoded(track);
    expectJsonFields(output, input);
    expect(output['duration_ms'], isA<int>());
    expect(output['disc_number'], isA<int>());
    expect(output['track_number'], isA<int>());
    expectTrack(TrackSimple.fromJson(output));
  });

  test('Track inherits track fields and preserves album and external IDs', () {
    final input = {
      ...trackJson(),
      'album': {'id': 'album-id', 'name': 'Album', 'album_type': 'album'},
      'external_ids': {'isrc': 'TEST123'},
    };
    final track = Track.fromJson(input);
    expectTrack(track);
    expect(track.album?.id, 'album-id');
    expect(track.externalIds?.isrc, 'TEST123');
    final output = encoded(track);
    expectJsonFields(output, input);
    final roundTrip = Track.fromJson(output);
    expectTrack(roundTrip);
    expect(roundTrip.album?.name, 'Album');
    expect(roundTrip.externalIds?.isrc, 'TEST123');

    // The deprecated full-track accessor must share the inherited storage.
    final TrackSimple simple = track;
    simple.previewUrl = 'https://example.com/changed.mp3';
    expect(encoded(track)['preview_url'], simple.previewUrl);
  });

  test('Episode inherits audio fields and preserves episode JSON', () {
    final input = episodeJson();
    final episode = Episode.fromJson(input);
    expectEpisode(episode);
    final output = encoded(episode);
    expectJsonFields(output, input);
    expectEpisode(Episode.fromJson(output));
  });

  test('EpisodeFull inherits episode fields and preserves the show', () {
    final input = {
      ...episodeJson(),
      'show': {'id': 'show-id', 'name': 'Show', 'type': 'show', 'total_episodes': 12},
    };
    final episode = EpisodeFull.fromJson(input);
    expectEpisode(episode);
    expect(episode.show?.id, 'show-id');
    expect(episode.show?.type, SpotifyContentType.show);
    final output = encoded(episode);
    expectJsonFields(output, input);
    final roundTrip = EpisodeFull.fromJson(output);
    expectEpisode(roundTrip);
    expect(roundTrip.show?.name, 'Show');
    expect(roundTrip.show?.totalEpisodes, 12);
  });

  final factories = <String, PlayableContent Function(Map<String, dynamic>)>{
    'TrackSimple': TrackSimple.fromJson,
    'Track': Track.fromJson,
    'Episode': Episode.fromJson,
    'EpisodeFull': EpisodeFull.fromJson,
  };
  for (final entry in factories.entries) {
    test('${entry.key} preserves nullable audio fields and derives duration', () {
      final content = entry.value({});
      expect(content.href, isNull);
      expect(content.id, isNull);
      expect(content.uri, isNull);
      expect(content.type, isNull);
      expect(content.name, isNull);
      expect(content.externalUrls, isNull);
      expect(content.durationMs, isNull);
      expect(content.duration, Duration.zero);
      expect(content.explicit, isNull);
      expect(content.isPlayable, isNull);
      expect(encoded(content)['type'], isNull);
      expect(encoded(content)['duration_ms'], isNull);
      expect(encoded(content), isNot(contains('duration')));
      content.durationMs = 2500;
      expect(content.duration, const Duration(milliseconds: 2500));
      expect(entry.value(encoded(content)).durationMs, 2500);
    });
  }
}
