# spotify-dart [![Pub](https://img.shields.io/pub/v/spotify.svg)](https://pub.dartlang.org/packages/spotify) ![Dart CI](https://github.com/rinukkusu/spotify-dart/workflows/Dart%20CI/badge.svg)

A dart library for interfacing with the Spotify API.

## Usage

### Simple Example

```dart
final credentials = SpotifyApiCredentials(clientId, clientSecret);
final spotify = SpotifyApi(credentials);
final artist = await spotify.artists.get('0OdUWJ0sBjDrqHygGUXeCF');
```

### Authorization

For detailed information regarding authorization, client credentials flow and more, see the [wiki](https://github.com/rinukkusu/spotify-dart/wiki).

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

## Development

### Generating JSON Serializers
Run `dart run build_runner build` to generate JSON serializers via [json_serializable][].
Run `dart run build_runner watch` to continuously rebuild serializers in the background when files are updated.

### Running tests
Run `dart test` to run all of the tests in `test/spotify_test.dart`.

### Running example code
Run `dart example/example` to run the example code. You'll need to modify `example/example.dart` to use your Spotify client ID and secret.

If you would like to run the example that accesses your user data (such as currently playing song etc.), run `pub run example/example_auth.dart`. There, you are requested to
enter your redirect url (see the comment above [`redirectUri`](#authorization-code-flow)). After that, you are requested to call a given url (or paste it into your browser). That url will do a redirect in your browser. You should copy and paste this redirected url into your console to see the currently playing song and your available devices.

[json_serializable]: https://pub.dartlang.org/packages/json_serializable
[spotify_auth]: https://developer.spotify.com/documentation/general/guides/authorization-guide/
[tracker]: https://github.com/rinukkusu/spotify-dart/issues
[uni_links]: https://pub.dev/packages/uni_links
[url_launcher]: https://pub.dev/packages/url_launcher
[webview_flutter]: https://pub.dev/packages/webview_flutter
