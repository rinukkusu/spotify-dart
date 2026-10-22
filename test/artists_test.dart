import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Artists', () {
    test('get', () async {
      final artist = await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      expect(artist.type, SpotifyContentType.artist);
      expect(artist.id, '0TnOYISbd1XYRBk9myaseg');
      expect(artist.images!.length, 3);
      expect(artist.images![0].height, 640);
      expect(artist.images![0].width, 640);
    });

    test('getError', () async {
      spotify.mockHttpErrors = [MockHttpError(statusCode: 401, message: 'Bad Request')].iterator;
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
