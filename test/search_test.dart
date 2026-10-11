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
      expect(searchResult.length, 3);
    });

    test('get audiobooks', () async {
      final searchResult = await spotify.search.get('metallica', types: [SearchType.audiobook]).first();
      final audiobooks = searchResult.firstWhere((page) => page.items?.first is AudiobookSimple);
      final audiobook = audiobooks.items!.first as AudiobookSimple;
      expect(audiobook.id, '7iHfbu1YPACw6oZPAFJtqe');
      expect(audiobook.name, 'Sample Audiobook');
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
}
