part of '_models.dart';

/// Decodes the [Track] or [Episode] returned by playlist and playback endpoints.
/// Unavailable items and unrecognized types decode to `null`.
PlayableContent? _playableContentFromJson(Map<String, dynamic>? json) {
  if (json == null) return null;

  return switch (json['type']) {
    'track' => Track.fromJson(json),
    'episode' => Episode.fromJson(json),
    _ => null,
  };
}

/// Base class for a Spotify resource with an ID and a Web API link.
abstract class SpotifyResource {
  /// A link to the Web API endpoint providing full details of the resource.
  String? href;

  /// The Spotify ID of this resource.
  String? id;
}

/// Base class for any content to be displayed on spotify ([Artist], [Album], [Audiobook], [Show], ...)
abstract class SpotifyContent extends SpotifyResource {
  Map<String, dynamic> toJson();

  /// The typed Spotify URI for this content.
  @JsonKey(fromJson: SpotifyUri.tryParse, includeToJson: false)
  SpotifyUri? uri;

  /// The [SpotifyContentType] of this content. Can be either
  /// * [SpotifyContentType.album]
  /// * [SpotifyContentType.track]
  /// * [SpotifyContentType.playlist]
  /// * [SpotifyContentType.episode] or
  /// * [SpotifyContentType.show]
  SpotifyContentType? type;

  /// Known external URLs for this content.
  @JsonKey(name: 'external_urls')
  ExternalUrls? externalUrls;
}

/// Common base for audio content such as [Track]s, [EpisodeSimple]s, and [Chapter]s.
abstract class PlayableContent extends SpotifyContent implements Explicitable, Restrictable {
  /// The name of the content.
  String? name;

  @override
  Restrictions? restrictions;

  /// Whether the content has explicit lyrics or other explicit material.
  @override
  bool? explicit;

  /// The content length in milliseconds.
  @JsonKey(name: 'duration_ms', fromJson: convertToIntIfDoubleValue)
  int? durationMs;

  /// The content length, defaulting to zero when unknown.
  @JsonKey(includeFromJson: false, includeToJson: false)
  Duration? get duration => Duration(milliseconds: durationMs ?? 0);

  /// Whether the content is playable in the given market.
  @JsonKey(name: 'is_playable')
  bool? isPlayable;
}

abstract interface class Explicitable {
  /// Whether the content has explicit lyrics or other explicit material.
  bool? explicit;
}

abstract interface class Restrictable {
  Restrictions? get restrictions;
}

/// Shared metadata for podcast episodes and audiobook chapters.
abstract class SpokenAudioContent extends PlayableContent {
  /// A plain-text description of the content.
  String? description;

  /// A description that may contain HTML tags.
  @JsonKey(name: 'html_description')
  String? htmlDescription;

  /// Cover images in various sizes, widest first.
  List<Image>? images;

  /// The languages used in the content, identified by ISO 639 codes.
  List<String>? languages;

  /// The release date, preserving the supplied year, month, or day precision.
  @JsonKey(name: 'release_date')
  String? releaseDate;

  /// The precision of [releaseDate].
  @JsonKey(name: 'release_date_precision')
  DatePrecision? releaseDatePrecision;

  /// Listening progress, when provided for an authorized user with the
  /// `user-read-playback-position` scope.
  @JsonKey(name: 'resume_point')
  ResumePoint? resumePoint;
}

@JsonSerializable()
class ResumePoint {
  ResumePoint();

  factory ResumePoint.fromJson(Map<String, dynamic> json) => _$ResumePointFromJson(json);

  Map<String, dynamic> toJson() => _$ResumePointToJson(this);

  @JsonKey(name: 'fully_played')
  bool? fullyPlayed;

  @JsonKey(name: 'resume_position_ms', fromJson: convertToIntIfDoubleValue)
  int? resumePositionMs;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Duration? get resumePosition => Duration(milliseconds: resumePositionMs ?? 0);
}

enum SpotifyContentType {
  artist,
  album,
  track,
  playlist,
  episode,
  show,
  audiobook,
  user,
}
