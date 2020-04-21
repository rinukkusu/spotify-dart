# spotify-dart [![Pub](https://img.shields.io/pub/v/spotify.svg)](https://pub.dartlang.org/packages/spotify) [![Build Status](https://travis-ci.org/rinukkusu/spotify-dart.svg?branch=master)](https://travis-ci.org/rinukkusu/spotify-dart)

A dart library for interfacing with the Spotify API.

## Usage

### Simple Example

```dart
import 'package:spotify/spotify.dart';

void main() async {
  var credentials = SpotifyApiCredentials(clientId, clientSecret);
  var spotify = SpotifyApi(credentials);

  var artist = await spotify.artists.get('0OdUWJ0sBjDrqHygGUXeCF');
}
```

### Authorization
#### Client Credentials Flow
This flow is recommended when you only need access to public Spotify data. It cannot be used to access or manage a user's private data.

```dart
SpotifyApi getSpotifyApi() {
  final credentials = SpotifyApiCredentials(clientId, clientSecret);
  return SpotifyApi(credentials);
}
```

#### Authorization Code Flow
This flow is suitable for long-running applications when you need to access or manage a user's private data. The Authorization Code Flow is a complex process, so it's highly recommended to read through [Spotify's Authorization Guide][spotify_auth] before attempting. Note that this package simplifies the creation of the authorization URI and the process of requesting tokens after receiving an authorization code.

```dart
SpotifyApi getSpotifyApi() async {
  final credentials = SpotifyApiCredentials(clientId, clientSecret);
  final grant = SpotifyApi.authorizationCodeGrant(credentials);

  // The URI to redirect to after the user grants or denies permission. It must
  // be in your Spotify application's Redirect URI whitelist. This URI can
  // either be a web address pointing to an authorization server or a fabricated
  // URI that allows the client device to function as an authorization server.
  final redirectUri = 'https://example.com/auth';

  // See https://developer.spotify.com/documentation/general/guides/scopes/
  // for a complete list of these Spotify authorization permissions. If no
  // scopes are specified, only public Spotify information will be available.
  final scopes = ['user-read-email', 'user-library-read'];

  var authUri = grant.getAuthorizationUrl(
    Uri.parse(redirectUri),
    scopes: scopes, // scopes are optional
  );

  // `redirect` is an imaginary function that redirects the resource owner's
  // browser to the `authUri` on the authorization server. Once the resource
  // owner has authorized, they'll be redirected to the `redirectUri` with an
  // authorization code. The exact implementation varies across platforms.
  await redirect(authUri);

  // `listen` is another imaginary function that listens for a request to
  // `redirectUri` after the user grants or denies permission. Again, the
  // exact implementation varies across platforms.
  final responseUri = await listen(redirectUri);

  return SpotifyApi.fromAuthCodeGrant(grant, responseUri);
}
```

<details>
  <summary>Click here to learn how to implement the imaginary functions mentioned above.</summary>
  
  -----
  
  Unfortunately, there's not a universal example for implementing the imaginary functions, `redirect` and `listen`, because different options exist for each platform.
      
  For Flutter apps, there's two popular approaches:
  1. Launch a browser using [url_launcher][url_launcher] and listen for a redirect using [uni_links][uni_links].
      ```dart
        if (await canLaunch(authUri)) {
          await launch(authUri);
        }

        ...
    
        final linksStream = getLinksStream().listen((String link) async {
          if (link.startsWith(redirectUri) {
            responseUri = link;
          }
        });
      ```

  2. Launch a WebView inside the app and listen for a redirect using [webview_flutter][webview_flutter].
      ```dart
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: authUri,
          navigationDelegate: (navReq) {
            if (navReq.url.startsWith(redirectUri)) {
              responseUri = navReq.url;
              return NavigationDecision.prevent;
            }
            
            return NavigationDecision.navigate;
          },
          ...
        );
      ```
   
  For Dart apps, the best approach depends on the available options for accessing a browser. In general, you'll need to launch the authorization URI through the client's browser and listen for the redirect URI.
</details>

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/rinukkusu/spotify-dart/issues

## Development

### Generating JSON Serializers
Run `pub run build_runner build` to generate JSON serializers via [json_serializable][json_serializable].
Run `pub run build_runner watch` to continuously rebuild serializers in the background when files are updated.

### Running tests
Run `pub run test` to run all of the tests in `test/spotify_test.dart`.

### Running example code
Run `pub run example/example` to run the example code. You'll need to modify `example/example.dart` to use your Spotify client ID and secret.

If you would like to run the example with user data, that is only available if you're authenticated, run `pub run example/example_auth.dart`. There, you are requested to
enter your redirect url (see `redirectUri` above) and call a given url, with which you are _again_ requested to paste the redirected (see `responseUri` above) to access
the user data. The output the available devices and currently playing song.

[json_serializable]: https://pub.dartlang.org/packages/json_serializable
[spotify_auth]: https://developer.spotify.com/documentation/general/guides/authorization-guide/
[webview_flutter]: https://pub.dev/packages/webview_flutter
[uni_links]: https://pub.dev/packages/uni_links
[url_launcher]: https://pub.dev/packages/url_launcher
