import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';


Future main() async {
  var spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Auth', () {
    test('getCredentials', () async {
      var result = await spotify.getCredentials();

      expect(result.clientId, 'clientId');
      expect(result.clientSecret, 'clientSecret');
      expect(result.accessToken, 'accessToken');
      expect(result.refreshToken, 'refreshToken');
      expect(result.tokenEndpoint!.path, 'tokenEndpoint.com');
      expect(result.scopes!.length, 2);
      expect(result.expiration!.millisecondsSinceEpoch, 8000);
      expect(result.canRefresh, true);
      expect(result.isExpired, true);
    });
  });
}
