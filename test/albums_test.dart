import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

// ignore_for_file: deprecated_member_use_from_same_package

Future main() async {
  var spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Albums', () {
    test('get', () async {
      var album = await spotify.albums.get('4aawyAB9vmqN3uQ7FjRGTy');

      expect(album.albumType, AlbumType.album);
      expect(album.id, '4aawyAB9vmqN3uQ7FjRGTy');
      expect(album.images!.length, 3);
      expect(album.releaseDatePrecision, DatePrecision.day);
      expect(album.releaseDate, '2012-11-13');
    });

    test('album tracks', () async {
      var tracksPage = spotify.albums.tracks('4aawyAB9vmqN3uQ7FjRGTy');
      var firstPage = await tracksPage.first();

      var trackOne = firstPage.items!.first;
      expect(trackOne.discNumber, 1);
      expect(trackOne.durationMs, 85400);
      expect(trackOne.id, '6OmhkSOpvYBokMKQxpIGx2');
      expect(trackOne.isPlayable, isNull);
      expect(trackOne.type, 'track');
      expect(trackOne.uri, 'spotify:track:6OmhkSOpvYBokMKQxpIGx2');
      expect(trackOne.explicit, true);
      expect(trackOne.href,
          'https://api.spotify.com/v1/tracks/6OmhkSOpvYBokMKQxpIGx2');
      expect(trackOne.previewUrl,
          'https://p.scdn.co/mp3-preview/81b57845f672fa5a0af749489e311ffb9fd552fe?cid=0b297fa8a249464ba34f5861d4140e58');
      expect(trackOne.name, 'Global Warming (feat. Sensato)');

      expect(trackOne.externalUrls != null, true);
      expect(trackOne.externalUrls!.spotify,
          'https://open.spotify.com/track/6OmhkSOpvYBokMKQxpIGx2');
      expect(trackOne.availableMarkets, isNotNull);
      expect(trackOne.availableMarkets?.first, Market.AT);

      var artists = trackOne.artists;
      expect(artists!.length, 2);
      expect(artists[0].name, 'Pitbull');
      expect(artists[1].name, 'Sensato');
    });

    test('list', () async {
      var albums = await spotify.albums
          .list(['4aawyAB9vmqN3uQ7FjRGTy', '4aawyAB9vmqN3uQ7FjRGTy']);

      expect(albums.length, 2);
    });
  });
}
