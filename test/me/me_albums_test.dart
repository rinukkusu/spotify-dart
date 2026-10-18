import 'dart:async';

import 'package:spotify/spotify.dart';

import '../spotify_mock.dart';
import 'package:test/test.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('me/albums', () {
    test('saved', () async {
      final albumsPage = spotify.me.albums.saved();
      final firstPage = await (albumsPage.first());
      final firstItem = firstPage.items?.first;
      expect(firstItem, isNotNull);
      expect(firstItem!.id, '5Nwsra93UQYJ6xxcjcE10x');
      expect(firstItem.artists, hasLength(1));
      expect(firstItem.artists!.first.id, '6VuMaDnrHyPL1p4EHjYLi7');
      expect(firstItem.tracks, hasLength(13));
      expect(firstItem.releaseDate, '2016-01-29');
      expect(firstItem.uri, AlbumUri('5Nwsra93UQYJ6xxcjcE10x').toString());
    });
  });
}
