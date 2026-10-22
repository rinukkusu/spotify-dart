import 'dart:async';

import 'package:spotify/spotify.dart';

import '../spotify_mock.dart';
import 'package:test/test.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('me/shows', () {
    test('saved', () async {
      final albumsPage = spotify.me.shows.saved();
      final firstPage = await (albumsPage.first());
      final firstItem = firstPage.items?.first;
      expect(firstItem, isNotNull);
      expect(firstItem!.explicit, false);
      expect(firstItem.id, '4XPl3uEEL9hvqMkoZrzbx5');
      expect(firstItem.name, 'Darknet Diaries');
      expect(firstItem.languages, hasLength(1));
      expect(firstItem.mediaType, 'audio');

      expect(firstItem.uri, ShowUri('4XPl3uEEL9hvqMkoZrzbx5'));
    });
  });
}
