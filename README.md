# spotify-dart [![Pub](https://img.shields.io/pub/v/spotify.svg)](https://pub.dartlang.org/packages/spotify) [![Build Status](https://travis-ci.org/rinukkusu/spotify-dart.svg?branch=master)](https://travis-ci.org/rinukkusu/spotify-dart)

A dart library for interfacing with the Spotify API.

## Usage

A simple usage example:

```dart
import 'package:spotify/spotify.dart';

void main() async {
  var credentials = SpotifyApiCredentials(clientId, clientSecret);
  var spotify = SpotifyApi(credentials);

  var artist = await spotify.artists.get('0OdUWJ0sBjDrqHygGUXeCF');
}
```

### Client Credentials Flow
```dart
SpotifyApi getSpotifyApi() {
  final credentials = SpotifyApiCredentials(clientId, clientSecret);
  return SpotifyApi(credentials);
}
```

### Authorization Code
```dart
SpotifyApi getSpotifyApi() async {
  final credentials = SpotifyApiCredentials(clientId, clientSecret);
  grant = SpotifyApi.authorizationCodeGrant(credentials);
  // *** from dart-lang/oauth2 package
  // `redirect` is an imaginary function that redirects the resource
  // owner's browser.
  await redirect(grant.getAuthorizationUrl(redirectUrl));
  // Another imaginary function that listens for a request to `redirectUrl`.
  final requestUri = await listen(redirectUrl);
  // ***
  return SpotifyApi.fromAuthCodeGrant(WelcomeScreen.grant, requestUri);
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/rinukkusu/spotify-dart/issues

## Development

### Generating JSON Serializers

Run `pub run build_runner build` to generate JSON serilizers via [json_serializable][json].

[json]: https://pub.dartlang.org/packages/json_serializable
