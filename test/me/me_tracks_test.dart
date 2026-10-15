import 'dart:async';

import '../spotify_mock.dart';
import 'package:test/test.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('me/tracks', () {
    test('saved', () async {
      final albumsPage = spotify.me.tracks.saved();
      final firstPage = await (albumsPage.first());
      final firstItem = firstPage.items?.first;
      expect(firstItem, isNotNull);
      expect(firstItem!.track, isNotNull);
      expect(firstItem.track!.id, '4DMKwE2E2iYDKY01C335Uw');
      expect(firstItem.track!.artists, hasLength(1));
      expect(firstItem.track!.artists!.first.id, '2hl0xAkS2AIRAu23TVMBG1');

      expect(firstItem.track!.duration, const Duration(milliseconds: 323000));
      expect(firstItem.track!.popularity, 76);
      expect(firstItem.track!.trackNumber, 1);
      expect(firstItem.track!.isPlayable, true);
      expect(firstItem.track!.explicit, false);
      expect(firstItem.track!.uri, 'spotify:track:4DMKwE2E2iYDKY01C335Uw');
    });
  });
}
