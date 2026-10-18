import 'dart:async';

import '../spotify_mock.dart';
import 'package:test/test.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('me/', () {
    test('get', () async {
      final userMe = await spotify.me.get();
      expect(userMe.accountId, '67676767');
      expect(userMe.displayName, 'asdf');
    });
  });
}
