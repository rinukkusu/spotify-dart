import 'package:spotify/spotify.dart';
import 'package:test/test.dart';

void main() {
  final trackJson = <String, dynamic>{
    'type': 'track',
    'id': 'track-id',
    'track_number': 3,
    'album': {'name': 'Album'},
  };
  final episodeJson = <String, dynamic>{
    'type': 'episode',
    'id': 'episode-id',
    'description': 'Episode description',
    'show': {'name': 'Show'},
    'resume_point': {'fully_played': false, 'resume_position_ms': 42000},
  };

  final decoders = <String, PlayableContent? Function(Map<String, dynamic>?)>{
    'playback': (json) => PlaybackState.fromJson({'item': json}).item,
    'queue currently playing': (json) => Queue.fromJson({'currently_playing': json}).currentlyPlaying,
    'playlist': (json) => PlaylistItem.fromJson({'item': json}).item,
  };

  for (final entry in decoders.entries) {
    test('${entry.key} preserves track and episode details', () {
      final track = entry.value(trackJson);
      expect(track, isA<Track>());
      expect((track as Track).trackNumber, 3);
      expect(track.album?.name, 'Album');

      final episode = entry.value(episodeJson);
      expect(episode, isA<Episode>());
      expect((episode as Episode).description, 'Episode description');
      expect(episode.show?.name, 'Show');
      expect(episode.resumePoint?.resumePositionMs, 42000);
    });

    test('${entry.key} tolerates unavailable and unknown items', () {
      expect(entry.value(null), isNull);
      expect(entry.value({}), isNull);
      expect(entry.value({'type': 'unknown'}), isNull);
    });
  }

  test('mixed queue preserves order and episode details through encoding', () {
    final queue = Queue.fromJson({
      'currently_playing': episodeJson,
      'queue': [trackJson, episodeJson, trackJson],
    });
    final restored = Queue.fromJson(queue.toJson());
    expect(restored.queue!.map((item) => item.id), ['track-id', 'episode-id', 'track-id']);
    expect(restored.queue!.first, isA<Track>());
    expect((restored.queue![1] as Episode).resumePoint?.resumePositionMs, 42000);
    expect((restored.currentlyPlaying as Episode).show?.name, 'Show');
  });

  test('queue skips unavailable and unknown entries and handles absent lists', () {
    final queue = Queue.fromJson({
      'queue': [
        null,
        trackJson,
        {'type': 'unknown'},
        episodeJson,
      ],
    });
    expect(queue.queue!.map((item) => item.id), ['track-id', 'episode-id']);
    expect(Queue.fromJson({}).queue, isNull);
    expect(Queue.fromJson({'queue': null}).queue, isNull);
    expect(Queue.fromJson({'queue': []}).queue, isEmpty);
  });

  test('playback encoding preserves the full episode', () {
    final playback = PlaybackState.fromJson({'item': episodeJson});
    final restored = PlaybackState.fromJson(playback.toJson());
    final episode = restored.item as Episode;
    expect(episode.description, 'Episode description');
    expect(episode.show?.name, 'Show');
    expect(episode.resumePoint?.resumePositionMs, 42000);
  });
}
