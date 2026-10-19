import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Uri', () {
    test('validate_correct', () {
      final uris = [
        AudiobookUri('1'),
        ShowUri('id'),
        TrackUri('id'),
        EpisodeUri('id'),
        AlbumUri('id'),
        UserUri('id'),
      ];
      for (final uri in uris) {
        expect(isValidUri(uri), true);
      }
    });
  });
}
