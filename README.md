# spotify-dart

A dart library for interfacing with the Spotify API.

## Usage

A simple usage example:

    import 'package:spotify_dart/spotify_dart.dart';

main() {
  var credentials = new SpotifyApiCredentials(clientId, clientSecret);
  var spotify = new SpotifyApi(credentials);

  var artist = await spotify.artists.get('0OdUWJ0sBjDrqHygGUXeCF');
}

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/rinukkusu/spotify-dart/issues
