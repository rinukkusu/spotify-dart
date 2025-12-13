import 'dart:async';
import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

// ignore_for_file: deprecated_member_use_from_same_package

Future main() async {
  var spotify = SpotifyApiMock(SpotifyApiCredentials(
    'clientId',
    'clientSecret',
  ));

  tearDown(() {
    spotify.interceptor = null;
    spotify.mockHttpErrors = <MockHttpError>[].iterator;
  });

  group('markets', () {
    test('getAvailableMarkets', () async {
      var result = await spotify.markets.availableMarkets;
      expect(result.isEmpty, false);
      expect(result.first, Market.AD);
      expect(result.elementAt(1), Market.AE);
      expect(result.last, Market.ZW);
    });
  });
}
