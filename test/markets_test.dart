import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('markets', () {
    test('getAvailableMarkets', () async {
      final result = await spotify.markets.availableMarkets;
      expect(result.isEmpty, false);
      expect(result.first, Market.AD);
      expect(result.elementAt(1), Market.AE);
      expect(result.last, Market.ZW);
    });
  });
}
