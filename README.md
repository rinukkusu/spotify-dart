# spotify-dart [![Pub](https://img.shields.io/pub/v/spotify.svg)](https://pub.dartlang.org/packages/spotify) ![Dart CI](https://github.com/rinukkusu/spotify-dart/workflows/Dart%20CI/badge.svg)

A Dart library for interfacing with the Spotify API.

## Installation

Add `spotify` to your `pubspec.yaml`:

```yaml
dependencies:
  spotify: ^0.14.0
```

Then run `dart pub get` to install the package.

## Features

This library provides comprehensive access to Spotify's Web API:

### Core Content
- **Artists** - Get artist info, top tracks, related artists, and albums
- **Tracks** - Retrieve track details and metadata
- **Albums** - Access album information and track listings
- **Playlists** - Browse, get, create, and modify playlists
- **Shows & Episodes** - Full podcast support
- **Search** - Search across all content types (artists, tracks, albums, playlists, shows, episodes)
- **Browse** - Discover new releases, featured playlists, and categories
- **Categories** - Browse categories with market and locale support

### User Features (require authentication)
- **User Profile** - Access current user information via `me` endpoint
- **Playback Control** - Control playback, manage queue, get available devices
- **Library Management** - Manage saved tracks, albums, shows, and episodes
- **User History** - Access top items and recently played tracks
- **Following** - Follow/unfollow artists and users

### Additional Capabilities
- **Pagination** - Efficient handling of large result sets with `Pages<T>` and `CursorPages<T>`
- **Market Support** - Country-specific content filtering
- **Multiple Auth Flows** - Client credentials and authorization code grant (with PKCE support)
- **OAuth Scopes** - Comprehensive authorization scope management

**Note:** Audio Features, Audio Analysis, and Recommendations endpoints are deprecated by Spotify but still available in this library.

## Quick Start

### Simple Example (Client Credentials)

```dart
import 'package:spotify/spotify.dart';

void main() async {
  final credentials = SpotifyApiCredentials(clientId, clientSecret);
  final spotify = SpotifyApi(credentials);

  // Get artist info
  final artist = await spotify.artists.get('0OdUWJ0sBjDrqHygGUXeCF');
  print(artist.name); // 'Band of Horses'

  // Search for tracks
  var search = await spotify.search.get('metallica').first(2);
  print(search.first.items); // List of albums, artists, tracks, etc.
}
```

### Working with Pagination

Many endpoints return paginated results:

```dart
// Get all tracks from an album
var tracks = await spotify.albums.getTracks(albumId).all();

// Get first N items
var featured = await spotify.playlists.featured.first(5);

// Stream through pages
await for (var page in spotify.playlists.getUsersPlaylists(userId).stream()) {
  print(page.items);
}
```

## Authorization

This library supports multiple authorization flows:

- **Client Credentials Flow** - For accessing public data (artists, albums, tracks, etc.)
- **Authorization Code Grant** - For accessing user data and controlling playback
- **PKCE Support** - Enhanced security for public clients

For detailed information on authorization flows, OAuth scopes, and advanced usage, see the [wiki](https://github.com/rinukkusu/spotify-dart/wiki).

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

## Contributing

Contributions are welcome! Here's how to work on this project:

### Development Setup

1. Clone the repository
2. Run `dart pub get` to install dependencies

### Generating JSON Serializers

This project uses [json_serializable][] for model serialization:

- Run `dart run build_runner build` to generate serializers
- Run `dart run build_runner watch` to continuously rebuild when files change

### Code Quality

Before committing, ensure your code passes:

- **Formatting**: `dart format .`
- **Analysis**: `dart analyze`

### Running Tests

Run the test suite:
```bash
dart test
```

### Running Examples

To run the basic example:
```bash
dart run example/example.dart
```

You'll need to modify the file to include your Spotify client ID and secret.

For the authenticated example (accessing user data, playback control):
```bash
dart run example/example_auth.dart
```

This example will prompt you for a redirect URL and guide you through the OAuth flow to access features like currently playing tracks and available devices.

[json_serializable]: https://pub.dartlang.org/packages/json_serializable
[spotify_auth]: https://developer.spotify.com/documentation/general/guides/authorization-guide/
[tracker]: https://github.com/rinukkusu/spotify-dart/issues
[uni_links]: https://pub.dev/packages/uni_links
[url_launcher]: https://pub.dev/packages/url_launcher
[webview_flutter]: https://pub.dev/packages/webview_flutter
