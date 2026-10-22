// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of a track
@JsonSerializable()
class Track extends TrackSimple {
  Track();

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TrackToJson(this);

  /// The album on which the track appears. The album object includes a link
  /// in [href] to full information about the album.
  AlbumSimple? album;

  /// Known external IDs for this track.
  @JsonKey(name: 'external_ids')
  ExternalIds? externalIds;

  /// A URL to a 30 second preview (MP3 format) of the track. `null` if not
  /// available.
  @JsonKey(name: 'preview_url')
  @override
  @Deprecated(
    'This property has been officially deprecated by Spotify'
    'and may be removed in a future version of this library.',
  )
  String? get previewUrl => super.previewUrl;

  @override
  @Deprecated(
    'This property has been officially deprecated by Spotify'
    'and may be removed in a future version of this library.',
  )
  set previewUrl(String? value) => super.previewUrl = value;
}

/// Json representation of a simplified track.
@JsonSerializable()
class TrackSimple extends PlayableContent {
  TrackSimple();

  factory TrackSimple.fromJson(Map<String, dynamic> json) => _$TrackSimpleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TrackSimpleToJson(this);

  /// The artists who performed the track. Each artist object includes a link
  /// in [href] to more detailed information about the artist.
  List<Artist>? artists;

  /// The disc number
  /// (usually `1` unless the album consists of more than one disc)
  @JsonKey(name: 'disc_number', fromJson: convertToIntIfDoubleValue)
  int? discNumber;

  /// A URL to a 30 second preview (MP3 format) of the track. `null` if not
  /// available.
  @JsonKey(name: 'preview_url')
  String? previewUrl;

  /// The number of the track. If an album has several discs, the track number
  /// is the number on the specified disc.
  @JsonKey(name: 'track_number', fromJson: convertToIntIfDoubleValue)
  int? trackNumber;

  /// Whether the track is a local file.
  @JsonKey(name: 'is_local')
  bool? isLocal;
}

/// A song saved in a Spotify user’s “Your Music” library
@JsonSerializable()
class TrackSaved {
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
class TracksLink {
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
