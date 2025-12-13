import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  var spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Errors', () {
    test('apiRateErrorSuccess', () async {
      spotify.mockHttpErrors = List.generate(
          4,
          (i) => MockHttpError(
              statusCode: 429,
              message: 'API Rate exceeded',
              headers: {'retry-after': '1'})).iterator;
      var artist = await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      expect(artist.type, 'artist');
      expect(artist.id, '0TnOYISbd1XYRBk9myaseg');
      expect(artist.images!.length, 3);
    });
    test('apiRateErrorFail', () async {
      spotify.mockHttpErrors = List.generate(
          10,
          (i) => MockHttpError(
              statusCode: 429,
              message: 'API Rate exceeded',
              headers: {'retry-after': '1'})).iterator;
      late ApiRateException ex;
      try {
        await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      } on ApiRateException catch (e) {
        expect(e, isA<ApiRateException>());
        ex = e;
      }
      expect(ex, isNotNull);
      expect(ex.status, 429);
    });
  });
}
