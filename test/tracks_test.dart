import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';

// ignore_for_file: deprecated_member_use_from_same_package

Future main() async {
  var spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Tracks', () {
    test('containsTracks', () async {
      var result = await spotify.tracks.me.containsTracks(['1', '2', '3']);

      expect(result.length, 3);
      expect(result['1'], isTrue);
      expect(result['2'], isFalse);
      expect(result['3'], isTrue);
    });
  });
}
