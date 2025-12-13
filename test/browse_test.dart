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

  group('Browse', () {
    test('Get New Releases', () async {
      var newReleases = spotify.browse.getNewReleases();
      var firstPage = await newReleases.first();
      expect(firstPage.items!.length, 3);

      var firstItem = firstPage.items!.first;
      expect(firstItem.id, '50MeziN5Do8zDtN4wINTTS');
      expect(firstItem.name, '11:11');
      expect(firstItem.releaseDate, '2022-08-11');
    });
  });
}
