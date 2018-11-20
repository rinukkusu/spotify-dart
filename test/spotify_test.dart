import 'dart:async';
import 'package:test/test.dart';
import 'package:spotify/spotify_io.dart';

Future main() async {
  var credentials = new SpotifyApiCredentials('id', 'secret');
  var spotify = new SpotifyApiMock(credentials);

  group('Albums', () {
    test('get', () async {
      var album = await spotify.albums.get('4aawyAB9vmqN3uQ7FjRGTy');

      expect(album.albumType, 'album');
      expect(album.id, '4aawyAB9vmqN3uQ7FjRGTy');
      expect(album.images.length, 3);
    });

    test('list', () async {
      var albums = await spotify.albums.list(['4aawyAB9vmqN3uQ7FjRGTy', '4aawyAB9vmqN3uQ7FjRGTy']);

      expect(albums.length, 2);
    });
  });

  group('Artists', () {
    test('get', () async {
      var artist = await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');

      expect(artist.type, 'artist');
      expect(artist.id, '0TnOYISbd1XYRBk9myaseg');
      expect(artist.images.length, 3);
    });

    test('list', () async {
      var artists = await spotify.artists.list(['0TnOYISbd1XYRBk9myaseg', '0TnOYISbd1XYRBk9myaseg']);

      expect(artists.length, 2);
    });
  });

  group('Search', () {
    test('get', () async {
      var searchResult = await spotify.search.get('metallica').first();

      expect(searchResult.length, 2);
    });
  });
}