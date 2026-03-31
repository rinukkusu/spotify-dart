import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Search', () {
    test('get', () async {
      final searchResult = await spotify.search.get('metallica').first();
      expect(searchResult.length, 2);
    });

    test('getError', () async {
      spotify.mockHttpErrors = [MockHttpError(statusCode: 401, message: 'Bad Request')].iterator;
      late SpotifyException ex;
      try {
        await spotify.search.get('metallica').first();
      } on SpotifyException catch (e) {
        expect(e, isA<SpotifyException>());
        ex = e;
      }
      expect(ex, isNotNull);
      expect(ex.status, 401);
      expect(ex.message, 'Bad Request');
    });
  });

  test('limit boundaries crossed', () async {
    try {
      await spotify.search.get('metallica').getPage(100);
    } on ArgumentError catch (e) {
      expect(e.name, 'limit');
      expect(e, isNotNull);
    }
  });
}
