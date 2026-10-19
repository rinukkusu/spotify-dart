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

/// Common base for audio content such as tracks, episodes, and chapters.
///
/// This does not guarantee availability or eligibility for inclusion in playlists.
abstract class PlayableContent extends SpotifyContent {
  /// The name of the content.
  String? name;

  /// Known external URLs for this content.
  @JsonKey(name: 'external_urls')
  ExternalUrls? externalUrls;

  /// The content length in milliseconds.
  @JsonKey(name: 'duration_ms', fromJson: convertToIntIfDoubleValue)
  int? durationMs;

  /// The content length, defaulting to zero when unknown.
  @JsonKey(includeFromJson: false, includeToJson: false)
  Duration? get duration => Duration(milliseconds: durationMs ?? 0);

  /// Whether the content has explicit lyrics or other explicit material.
  bool? explicit;

  /// Whether the content is playable in the given market.
  @JsonKey(name: 'is_playable')
  bool? isPlayable;
}

abstract class SpotifyContentCollection<T> {
  T? content;
}

abstract class FeaturedContent<T> extends SpotifyContentCollection<T> {
  /// The message of the day for Spotify's featured playlists
  String? message;
}

enum SpotifyContentType { album, track, playlist, episode, show }
