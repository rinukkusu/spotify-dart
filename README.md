# spotify-dart [![Pub](https://img.shields.io/pub/v/spotify.svg)](https://pub.dartlang.org/packages/spotify) [![Build Status](https://travis-ci.org/rinukkusu/spotify-dart.svg?branch=master)](https://travis-ci.org/rinukkusu/spotify-dart)

A dart library for interfacing with the Spotify API.

## Usage

A simple usage example:

```dart
import 'package:spotify/spotify_io.dart';

main() async {
  var credentials = new SpotifyApiCredentials(clientId, clientSecret);
  var spotify = await SpotifyApi.fromCredentials(credentials);
  var artist = await spotify.artists.get('0OdUWJ0sBjDrqHygGUXeCF');
}
```

### For usage in the browser use

```dart
import 'package:spotify/spotify_browser.dart';
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/rinukkusu/spotify-dart/issues

## Development

### Generating JSON Serializers

Run `pub run build_runner build` to generate JSON serilizers via [json_serializable][json].

[json]: https://pub.dartlang.org/packages/json_serializable
