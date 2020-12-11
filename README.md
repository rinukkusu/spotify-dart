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
#### Client Credentials Flow
This flow is recommended when you only need access to public Spotify data. It cannot be used to access or manage a user's private data.

```dart
final credentials = SpotifyApiCredentials(clientId, clientSecret);
final spotify = SpotifyApi(credentials);
```

#### Authorization Code Flow
This flow is suitable for long-running applications when you need to access or manage a user's private data. The Authorization Code Flow is a complex process, so it's highly recommended to read through [Spotify's Authorization Guide][spotify_auth] before attempting. Note that this package simplifies the creation of the authorization URI and the process of requesting tokens after receiving an authorization code.

```dart
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

final authUri = grant.getAuthorizationUrl(
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

final spotify = SpotifyApi.fromAuthCodeGrant(grant, responseUri);
```

<details>
  <summary>Click here to learn how to implement the imaginary functions mentioned above.</summary>
  
  -----
  
  Unfortunately, there's not a universal example for implementing the imaginary functions, `redirect` and `listen`, because different options exist for each platform.
      
  For Flutter apps, there's two popular approaches:
  1. Launch a browser using [url_launcher][] and listen for a redirect using [uni_links][].
      ```dart
      if (await canLaunch(authUri)) {
        await launch(authUri);
      }

      ...
  
      final linksStream = getLinksStream().listen((String link) async {
        if (link.startsWith(redirectUri)) {
          responseUri = link;
        }
      });
      ```

  2. Launch a WebView inside the app and listen for a redirect using [webview_flutter][].
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

#### Saved Credentials Flow
No one wants to redo the Authorization Code Flow for every login or app start. If you save your credentials somewhere while authenticated, you can reconnect to Spotify later by passing those credentials into the constructor. If the access token is expired at this point, the credentials will be automatically refreshed. If the refresh token has been revoked for any reason, an exception will be thrown and you'll need to reauthenticate through another flow.

```dart
// Connect to Spotify using the Authorization Code Flow
final spotify = SpotifyApi(...);

// Save the credentials somewhere (local storage, database etc.)
someService.saveCredentials(spotify.getCredentials());

...

// Retrieve the saved credentials and use them to connect to Spotify
final credentials = someService.retrieveCredentials();

// All of these fields are required for the Saved Credentials Flow
final spotifyCredentials = SpotifyApiCredentials(
    credentials.clientId,
    credentials.clientSecret,
    accessToken: credentials.accessToken,
    refreshToken: credentials.refreshToken,
    scopes: credentials.scopes,
    expiration: credentials.expiration,
  );

final spotify = SpotifyApi(spotifyCredentials);

//The refresh token can be used to obtain just one access token. After token retrieval, a new refresh token is provided.
someService.saveCredentials(spotify.getCredentials());
```

If, for any reason, you are planning to leave the app open in the background for a very long time and access Spotify's API with variable intervals, spotify-dart will automatically refresh the token if it's expired and updates you with the new credentials (in particular you need the new refresh token) by using the following methods.

```dart
SpotifyApi api = SpotifyApi(spotifyCredentials, onCredentialsRefreshed: (SpotifyApiCredentials newCred) async {
          await _saveCredentials(newCred);
          print("Saved from oauth" + newCred.refreshToken);
        });
``` 

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

## Development

### Generating JSON Serializers
Run `pub run build_runner build` to generate JSON serializers via [json_serializable][].
Run `pub run build_runner watch` to continuously rebuild serializers in the background when files are updated.

### Running tests
Run `pub run test` to run all of the tests in `test/spotify_test.dart`.

### Running example code
Run `pub run example/example` to run the example code. You'll need to modify `example/example.dart` to use your Spotify client ID and secret.

If you would like to run the example that accesses your user data (such as currently playing song etc.), run `pub run example/example_auth.dart`. There, you are requested to
enter your redirect url (see the comment above [`redirectUri`](#authorization-code-flow)). After that, you are requested to call a given url (or paste it into your browser). That url will do a redirect in your browser. You should copy and paste this redirected url into your console to see the currently playing song and your available devices.

[json_serializable]: https://pub.dartlang.org/packages/json_serializable
[spotify_auth]: https://developer.spotify.com/documentation/general/guides/authorization-guide/
[tracker]: https://github.com/rinukkusu/spotify-dart/issues
[uni_links]: https://pub.dev/packages/uni_links
[url_launcher]: https://pub.dev/packages/url_launcher
[webview_flutter]: https://pub.dev/packages/webview_flutter
