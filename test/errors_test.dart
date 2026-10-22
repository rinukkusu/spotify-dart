import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
    spotify.mockHttpErrors = <MockHttpError>[].iterator;
  });

  group('Errors', () {
    test('missing and null reasons remain null', () {
      expect(SpotifyError.fromJson({'status': 429}).reason, isNull);
      expect(SpotifyError.fromJson({'status': 429, 'reason': null}).reason, isNull);
    });

    test('known and unknown reasons deserialize', () {
      final error = SpotifyError.fromJson({'reason': 'QUOTA_EXCEEDED'});
      expect(error.reason, SpotifyErrorReason.quotaExceeded);
      expect(error.toJson()['reason'], 'QUOTA_EXCEEDED');
      expect(SpotifyError.fromJson({'reason': 'FUTURE_REASON'}).reason, SpotifyErrorReason.unknown);
    });

    test('apiQuotaError', () async {
      var requests = 0;
      spotify.interceptor = (String method, String url, Map<String, String>? headers, [String? body]) {
        requests++;
      };
      spotify.mockHttpErrors = [
        MockHttpError(
          statusCode: 429,
          message: 'Too many requests',
          reason: 'QUOTA_EXCEEDED',
          headers: {'retry-after': '0'},
        ),
      ].iterator;

      await expectLater(
        () => spotify.artists.get('0TnOYISbd1XYRBk9myaseg'),
        throwsA(
          isA<ApiQuotaException>()
              .having((e) => e.status, 'status', 429)
              .having((e) => e.message, 'message', 'Too many requests')
              .having((e) => e.reason, 'reason', SpotifyErrorReason.quotaExceeded),
        ),
      );
      expect(requests, 1);
    });

    test('apiRateErrorWithoutRetryAfter', () async {
      spotify.mockHttpErrors = [
        MockHttpError(statusCode: 429, message: 'Too many requests'),
      ].iterator;

      await expectLater(
        () => spotify.artists.get('0TnOYISbd1XYRBk9myaseg'),
        throwsA(
          isA<SpotifyException>()
              .having((e) => e.runtimeType, 'type', SpotifyException)
              .having((e) => e.status, 'status', 429)
              .having((e) => e.reason, 'reason', isNull),
        ),
      );
    });

    test('apiRateErrorWithInvalidRetryAfter', () async {
      spotify.mockHttpErrors = [
        MockHttpError(statusCode: 429, message: 'Too many requests', headers: {'retry-after': 'invalid'}),
      ].iterator;
      await expectLater(
        () => spotify.artists.get('0TnOYISbd1XYRBk9myaseg'),
        throwsA(
          isA<SpotifyException>().having((e) => e.status, 'status', 429).having((e) => e.reason, 'reason', isNull),
        ),
      );
    });

    test('apiErrorWithUnknownReason', () async {
      spotify.mockHttpErrors = [
        MockHttpError(statusCode: 403, message: 'Forbidden', reason: 'FUTURE_REASON'),
      ].iterator;

      await expectLater(
        () => spotify.artists.get('0TnOYISbd1XYRBk9myaseg'),
        throwsA(
          isA<SpotifyException>()
              .having((ex) => ex.status, 'status', 403)
              .having((ex) => ex.message, 'message', 'Forbidden')
              .having((ex) => ex.reason, 'reason', SpotifyErrorReason.unknown),
        ),
      );
    });

    test('apiRateErrorSuccess', () async {
      spotify.mockHttpErrors = List.generate(
        4,
        (i) => MockHttpError(
          statusCode: 429,
          message: 'API Rate exceeded',
          headers: {'retry-after': '1'},
        ),
      ).iterator;
      await expectLater(
        spotify.artists.get('0TnOYISbd1XYRBk9myaseg'),
        completion(
          isA<Artist>()
              .having((artist) => artist.type, 'type', 'artist')
              .having((artist) => artist.id, 'id', '0TnOYISbd1XYRBk9myaseg')
              .having((artist) => artist.images!.length, 'images length', 3),
        ),
      );
    });
    test('apiRateErrorFail', () async {
      spotify.mockHttpErrors = List.generate(
        10,
        (i) => MockHttpError(
          statusCode: 429,
          message: 'API Rate exceeded',
          headers: {'retry-after': '1'},
        ),
      ).iterator;
      await expectLater(
        () => spotify.artists.get('0TnOYISbd1XYRBk9myaseg'),
        throwsA(isA<ApiRateException>().having((e) => e.status, 'status', 429)),
      );
    });
  });
}
