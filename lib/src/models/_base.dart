part of '_models.dart';

/// Base class for any spotify model
abstract class SpotifyContentBase {
  /// A link to the Web API endpoint providing full details of the content.
  String? href;

  /// The Spotify ID for this given content.
  String? id;
}

/// Base class for any
abstract class SpotifyContent extends SpotifyContentBase {
  /// The Spotify URI for the show.
  String? uri;

  /// The [SpotifyContentType] of this content. Can be either
  /// * [SpotifyContentType.album]
  /// * [SpotifyContentType.track]
  /// * [SpotifyContentType.playlist]
  /// * [SpotifyContentType.episode] or
  /// * [SpotifyContentType.show]
  SpotifyContentType? type;
}

abstract class SpotifyContentCollection<T> {
  T? content;
}

abstract class FeaturedContent<T> extends SpotifyContentCollection<T> {
  /// The message of the day for Spotify's featured playlists
  String? message;
}

enum SpotifyContentType { album, track, playlist, episode, show }
