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

  test('set defaultLimit is in url', () async {
    spotify.interceptor = (String method, String url, Map<String, String>? headers, [String? body]) {
      expect(method, 'GET');
      final uri = Uri.parse(url);
      expect(uri.queryParameters['limit'], '1');
    };
    final search = spotify.search.get('metallica');
    search.defaultLimit = 1;
    await search.first();
  });

  test('override defaultLimit in first()', () async {
    spotify.interceptor = (String method, String url, Map<String, String>? headers, [String? body]) {
      expect(method, 'GET');
      final uri = Uri.parse(url);
      expect(uri.queryParameters['limit'], '2');
    };
    final search = spotify.search.get('metallica');
    search.defaultLimit = 1;
    await search.first(2);
  });

  test('invalid first', () async {
    final search = spotify.search.get('metallica');
    search.defaultLimit = 10;
    search.maxLimit = 11;
    expect(() => search.first(12), throwsArgumentError);
  });

  test('getPage in boundary', () async {
    final search = spotify.search.get('metallica');
    search.maxLimit = 20;
    expect(await search.getPage(20), isA<List<Page>>());
  });

  test('illegal maxLimit set', () async {
    final search = spotify.search.get('metallica');
    expect(() => search.maxLimit = 1, throwsArgumentError);
  });

  test('defaultLimit boundaries exceeded', () async {
    final search = spotify.search.get('metallica');
    search.defaultLimit = 1;
    search.maxLimit = 2;
    expect(() => search.defaultLimit = 3, throwsArgumentError);
  });


  test('limit boundaries exceeded', () async {
    await expectLater(spotify.search.get('metallica').getPage(100), throwsArgumentError);
  });
}
