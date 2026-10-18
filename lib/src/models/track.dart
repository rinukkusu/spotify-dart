// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of a track
@JsonSerializable()
class Track extends Object implements TrackSimple {
  Track();

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TrackToJson(this);

  /// The album on which the track appears. The album object includes a link
  /// in [href] to full information about the album.
  AlbumSimple? album;

  /// The artists who performed the track. Each artist object includes a link
  /// in [href] to more detailed information about the artist.
  @override
  List<Artist>? artists;

  /// The disc number
  /// (usually `1` unless the album consists of more than one disc)
  @JsonKey(name: 'disc_number', fromJson: convertToIntIfDoubleValue)
  @override
  int? discNumber;

  /// The track length in milliseconds.
  @JsonKey(name: 'duration_ms', fromJson: convertToIntIfDoubleValue)
  @override
  int? durationMs;

  /// The track length
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  Duration? get duration => Duration(milliseconds: durationMs ?? 0);

  /// Whether or not the track has explicit lyrics
  /// (`true` = yes it does; `false` = no it does not OR unknown).
  @override
  bool? explicit;

  /// Known external IDs for this track.
  @JsonKey(name: 'external_ids')
  ExternalIds? externalIds;

  /// Known external URLs for this track.
  @JsonKey(name: 'external_urls')
  @override
  ExternalUrls? externalUrls;

  /// A link to the Web API endpoint providing full details of the track.
  @override
  String? href;

  /// The Spotify ID for the track.
  @override
  String? id;

  /// Part of the response when Track Relinking is applied. If true, the track
  /// is playable in the given market. Otherwise false.
  @JsonKey(name: 'is_playable')
  @override
  bool? isPlayable;

  /// The name of the track.
  @override
  String? name;

  /// A URL to a 30 second preview (MP3 format) of the track. `null` if not
  /// available.
  @JsonKey(name: 'preview_url')
  @override
  @Deprecated(
    'This property has been officially deprecated by Spotify'
    'and may be removed in a future version of this library.',
  )
  String? previewUrl;

  /// The number of the track. If an album has several discs, the track number
  /// is the number on the specified disc.
  @JsonKey(name: 'track_number', fromJson: convertToIntIfDoubleValue)
  @override
  int? trackNumber;

  /// The object type: "track".
  @override
  String? type;

  /// The Spotify URI for the track.
  @override
  String? uri;
}

/// Json representation of a simplified track.
@JsonSerializable()
class TrackSimple extends Object {
  TrackSimple();

  factory TrackSimple.fromJson(Map<String, dynamic> json) => _$TrackSimpleFromJson(json);

  Map<String, dynamic> toJson() => _$TrackSimpleToJson(this);

  /// The artists who performed the track. Each artist object includes a link
  /// in [href] to more detailed information about the artist.
  List<Artist>? artists;

  /// The disc number
  /// (usually `1` unless the album consists of more than one disc)
  @JsonKey(name: 'disc_number', fromJson: convertToIntIfDoubleValue)
  int? discNumber;

  /// The track length in milliseconds.
  @JsonKey(name: 'duration_ms', fromJson: convertToIntIfDoubleValue)
  int? durationMs;

  /// The track length
  @JsonKey(includeFromJson: false, includeToJson: false)
  Duration? get duration => Duration(milliseconds: durationMs ?? 0);

  /// Whether or not the track has explicit lyrics
  /// (`true` = yes it does; `false` = no it does not OR unknown).
  bool? explicit;

  /// Known external URLs for this track.
  @JsonKey(name: 'external_urls')
  ExternalUrls? externalUrls;

  /// A link to the Web API endpoint providing full details of the track.
  String? href;

  /// The Spotify ID for the track.
  String? id;

  /// Part of the response when Track Relinking is applied. If true, the track
  /// is playable in the given market. Otherwise false.
  @JsonKey(name: 'is_playable')
  bool? isPlayable;

  /// The name of the track.
  String? name;

  /// A URL to a 30 second preview (MP3 format) of the track. `null` if not
  /// available.
  @JsonKey(name: 'preview_url')
  String? previewUrl;

  /// The number of the track. If an album has several discs, the track number
  /// is the number on the specified disc.
  @JsonKey(name: 'track_number', fromJson: convertToIntIfDoubleValue)
  int? trackNumber;

  /// The object type: "track".
  String? type;

  /// The Spotify URI for the track.
  String? uri;
}

/// A song saved in a Spotify user’s “Your Music” library
@JsonSerializable()
class TrackSaved extends Object {
  TrackSaved();

  factory TrackSaved.fromJson(Map<String, dynamic> json) => _$TrackSavedFromJson(json);

  Map<String, dynamic> toJson() => _$TrackSavedToJson(this);

  /// The date and time the track was saved.
  @JsonKey(name: 'added_at')
  DateTime? addedAt;

  /// Information about the track.
  Track? track;
}

@JsonSerializable()
class TracksLink extends Object {
  TracksLink();

  factory TracksLink.fromJson(Map<String, dynamic> json) => _$TracksLinkFromJson(json);

  Map<String, dynamic> toJson() => _$TracksLinkToJson(this);

  /// A link to the Web API endpoint where full details of the playlist's
  /// tracks can be retrieved
  String? href;

  /// Total number of tracks in the playlist
  @JsonKey(fromJson: convertToIntIfDoubleValue)
  int? total;
}
