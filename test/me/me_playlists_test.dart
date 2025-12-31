import 'dart:async';

import '../spotify_mock.dart';
import 'package:test/test.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('me/shows', () {
    test('saved', () async {
      final albumsPage = spotify.me.playlists.saved();
      final firstPage = await (albumsPage.first());
      final firstItem = firstPage.items?.first;
      expect(firstItem, isNotNull);
      expect(firstItem!.name, 'Playlist#1');
      expect(firstItem.id, 'a123');
      expect(firstItem.public, false);
      expect(firstItem.tracksLink, isNotNull);
      expect(firstItem.tracksLink!.href, 'https://api.spotify.com/v1/playlists/a123/tracks');
      expect(firstItem.uri, 'spotify:playlist:a123');
    });
  });
}
