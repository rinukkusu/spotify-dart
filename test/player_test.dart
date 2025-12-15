import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Player', () {
    test('player', () async {
      final result = await spotify.player.playbackState();
      expect(result.isShuffling, true);
      expect(result.isPlaying, true);
      expect(result.currentlyPlayingType, CurrentlyPlayingType.track);
      expect(result.repeatState, RepeatState.off);
      expect(result.actions?.resuming, false);
      expect(result.actions?.pausing, true);
    });

    test('startWithContext', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        // checking sincce startWithContext makes a PUT and a GET request
        // to retrieve the current playbackstate
        if (method == 'PUT') {
          expect(method, 'PUT');
          expect(body, isNotNull);
          expect(
            body,
            '{"context_uri":"contextUri","offset":{"uri":"urioffset"}}',
          );
        }
      };
      await spotify.player.startWithContext('contextUri', offset: UriOffset('urioffset'));
    });

    test('startWithUris', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        // checking sincce startWithTracks makes a PUT and a GET request
        // to retrieve the current playbackstate
        if (method == 'PUT') {
          expect(method, 'PUT');
          expect(body, isNotNull);
          expect(body, '{"uris":["track1"],"position_ms":10}');
        }
      };
      await spotify.player.startWithTracks(['track1'], positionMs: 10);
    });
  });
}
