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

  group('Audio Features', () {
    test('get', () async {
      var audioFeatures =
          await spotify.audioFeatures.get('11dFghVXANMlKmJXsNCbNl');

      expect(audioFeatures.id, '11dFghVXANMlKmJXsNCbNl');
    });

    test('list', () async {
      var audioFeatures = await spotify.audioFeatures
          .list(['11dFghVXANMlKmJXsNCbNl', '2cs7JxrZ9DxvsfoVI07ayX']);

      expect(audioFeatures.length, 1);
    });
  });
}
