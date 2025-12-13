import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';


Future main() async {
  var spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Artists', () {
    test('get', () async {
      var artist = await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      expect(artist.type, 'artist');
      expect(artist.id, '0TnOYISbd1XYRBk9myaseg');
      expect(artist.images!.length, 3);
      expect(artist.images![0].height, 640);
      expect(artist.images![0].width, 640);
    });

    test('list', () async {
      var artists = await spotify.artists
          .list(['0TnOYISbd1XYRBk9myaseg', '0TnOYISbd1XYRBk9myaseg']);

      expect(artists.length, 2);
    });

    test('getRelatedArtists', () async {
      var relatedArtists =
          await spotify.artists.relatedArtists('0TnOYISbd1XYRBk9myaseg');
      var first = relatedArtists.first;
      expect(first.id, '0jnsk9HBra6NMjO2oANoPY');
      expect(first.href,
          'https://api.spotify.com/v1/artists/0jnsk9HBra6NMjO2oANoPY');
      expect(first.name, 'Flo Rida');
    });

    test('getError', () async {
      spotify.mockHttpErrors =
          [MockHttpError(statusCode: 401, message: 'Bad Request')].iterator;
      late SpotifyException ex;
      try {
        await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      } on SpotifyException catch (e) {
        expect(e, isA<SpotifyException>());
        ex = e;
      }
      expect(ex, isNotNull);
      expect(ex.status, 401);
      expect(ex.message, 'Bad Request');
    });
  });
}
