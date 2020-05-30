import 'dart:async';
import 'package:spotify/src/spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  var spotify = SpotifyApiMock(SpotifyApiCredentials(
    'clientId',
    'clientSecret',
  ));

  group('Albums', () {
    test('get', () async {
      var album = await spotify.albums.get('4aawyAB9vmqN3uQ7FjRGTy');

      expect(album.albumType, 'album');
      expect(album.id, '4aawyAB9vmqN3uQ7FjRGTy');
      expect(album.images.length, 3);
    });

    test('list', () async {
      var albums = await spotify.albums
          .list(['4aawyAB9vmqN3uQ7FjRGTy', '4aawyAB9vmqN3uQ7FjRGTy']);

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
      var artists = await spotify.artists
          .list(['0TnOYISbd1XYRBk9myaseg', '0TnOYISbd1XYRBk9myaseg']);

      expect(artists.length, 2);
    });

    test('getError', () async {
      spotify.mockHttpErrors =
          [MockHttpError(statusCode: 401, message: 'Bad Request')].iterator;
      SpotifyException ex;
      try {
        await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      } catch (e) {
        expect(e, isA<SpotifyException>());
        ex = e;
      }
      expect(ex, isNotNull);
      expect(ex.status, 401);
      expect(ex.message, 'Bad Request');
    });
  });

  group('Search', () {
    test('get', () async {
      var searchResult = await spotify.search.get('metallica').first();
      expect(searchResult.length, 2);
    });

    test('getError', () async {
      spotify.mockHttpErrors =
          [MockHttpError(statusCode: 401, message: 'Bad Request')].iterator;
      SpotifyException ex;
      try {
        await spotify.search.get('metallica').first();
      } catch (e) {
        expect(e, isA<SpotifyException>());
        ex = e;
      }
      expect(ex, isNotNull);
      expect(ex.status, 401);
      expect(ex.message, 'Bad Request');
    });
  });

  group('User', () {
    test('currentlyPlaying', () async {
      var result = await spotify.users.currentlyPlaying();

      expect(result.item.name, 'So Voce');
    });

    test('devices', () async {
      var result = await spotify.users.devices();
      expect(result.length, 1);
      expect(result.first.id, '5fbb3ba6aa454b5534c4ba43a8c7e8e45a63ad0e');
      expect(result.first.isActive, true);
      expect(result.first.isRestricted, true);
      expect(result.first.isPrivateSession, true);
      expect(result.first.name, 'My fridge');
      expect(result.first.type, DeviceType.Computer);
      expect(result.first.volumePercent, 100);
    });
  });

  group('Auth', () {
    test('getCredentials', () async {
      var result = await spotify.getCredentials();

      expect(result.clientId, 'clientId');
      expect(result.clientSecret, 'clientSecret');
      expect(result.accessToken, 'accessToken');
      expect(result.refreshToken, 'refreshToken');
      expect(result.tokenEndpoint.path, 'tokenEndpoint.com');
      expect(result.scopes.length, 2);
      expect(result.expiration.millisecondsSinceEpoch, 8000);
      expect(result.canRefresh, true);
      expect(result.isExpired, true);
    });
  });
  group('Errors', (){
    test('apiRateErrorSuccess', () async {
      spotify.mockHttpErrors = List.generate(4,
              (i)=>MockHttpError(
                  statusCode: 429,
                  message: 'API Rate exceeded',
                  headers: {'retry-after': '1'})).iterator;
      ApiRateException ex;
      var artist = await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      expect(artist.type, 'artist');
      expect(artist.id, '0TnOYISbd1XYRBk9myaseg');
      expect(artist.images.length, 3);
    });
  test('apiRateErrorFail', () async {
      spotify.mockHttpErrors = List.generate(10,
              (i)=>MockHttpError(
              statusCode: 429,
              message: 'API Rate exceeded',
              headers: {'retry-after': '1'})).iterator;
      ApiRateException ex;
      try {
        await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      } catch (e) {
        expect(e, isA<ApiRateException>());
        ex = e;
      }
      expect(ex, isNotNull);
      expect(ex.status, 429);
    });
  });
}
