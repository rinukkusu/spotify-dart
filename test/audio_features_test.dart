import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';

// ignore_for_file: deprecated_member_use_from_same_package

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Audio Features', () {
    test('get', () async {
      final audioFeatures =
          await spotify.audioFeatures.get('11dFghVXANMlKmJXsNCbNl');

      expect(audioFeatures.id, '11dFghVXANMlKmJXsNCbNl');
    });

    test('list', () async {
      final audioFeatures = await spotify.audioFeatures
          .list(['11dFghVXANMlKmJXsNCbNl', '2cs7JxrZ9DxvsfoVI07ayX']);

      expect(audioFeatures.length, 1);
    });
  });
}
