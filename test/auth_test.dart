import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:spotify/spotify_io.dart';

Future main() async {

  group('Authentication', () {
    test('client credentials', () async {
      SpotifyApiCredentials credentials;
      // Try to get the credentails from the .apikeys example file,
      // or from the environment (Travis, etc.)
      try {
        credentials = await loadCredentialsFromFile('example/.apikeys');
      } catch(_) {
        var env = Platform.environment;
        if (env.containsKey('CLIENT_ID') && env.containsKey('CLIENT_SECRET')) {
          credentials = new SpotifyApiCredentials(env['CLIENT_ID'], env['CLIENT_SECRET']);
        } else {
          throw new TestFailure('Could not find client credentials');
        }
      }

      // Try to login and get Spotify's featured playlists
      try {
        var spotify = new SpotifyApi(credentials);
        Page<PlaylistSimple> featuredPlaylists = await spotify.playlists.featured.first();
        expect(featuredPlaylists.items.length > 0, true);
      } on SpotifyException catch(e) {
        throw new TestFailure('Spotify API error: ${e.message}');
      } catch(_) {
        throw new TestFailure('Could not fetch featured playlists');
      }
    }, timeout: new Timeout(new Duration(seconds: 10)));
  });
}

Future<SpotifyApiCredentials> loadCredentialsFromFile(String path) async {
  var keyJson = await new File(path).readAsString();
  var keyMap = JSON.decode(keyJson);

  return new SpotifyApiCredentials(keyMap['id'], keyMap['secret']);
}
