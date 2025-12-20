// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

class PlaylistBase<T> extends SpotifyContent {
  /// `true` if the owner allows other users to modify the playlist.
  bool? collaborative;

  /// The playlist description. Only returned for modified, verified playlists,
  /// otherwise `null`.
  String? description;

  /// Known external URLs for this playlist.
  @JsonKey(name: 'external_urls')
  ExternalUrls? externalUrls;

  /// Information about the followers of the playlist.
  Followers? followers;

  /// Images for the playlist. The array may be empty or contain up to three
  /// images. The images are returned by size in descending order. See Working
  /// with Playlists.
  ///
  /// Note: If returned, the source URL for the image (url) is temporary and
  /// will expire in less than a day.
  List<Image>? images;

  /// The name of the playlist.
  String? name;

  /// The user who owns the playlist
  User? owner;

  /// The playlist's public/private status: `true` the playlist is public,
  /// `false` the playlist is private, null the playlist status is not relevant.
  /// For more about public/private status, see Working with Playlists.
  bool? public;

  /// The version identifier for the current playlist. Can be supplied in other
  /// requests to target a specific playlist version
  @JsonKey(name: 'snapshot_id')
  String? snapshotId;

  /// Information about the tracks of the playlist.
  @JsonKey(name: 'tracks')
  T? tracks;
}

/// Json representation of a simplified playlist
@JsonSerializable()
class PlaylistSimple extends PlaylistBase<TracksLink> {
  PlaylistSimple();

  factory PlaylistSimple.fromJson(Map<String, dynamic> json) => _$PlaylistSimpleFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistSimpleToJson(this);
}

/// Json representation of a playlist
@JsonSerializable()
class Playlist extends PlaylistBase<Paging<Track>> {
  Playlist();

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}

/// Json representation of a featured playlist. Used as a wrapper object.
@JsonSerializable()
class PlaylistsFeatured extends FeaturedContent<Playlist> {
  PlaylistsFeatured();

  factory PlaylistsFeatured.fromJson(Map<String, dynamic> json) => _$PlaylistsFeaturedFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistsFeaturedToJson(this);
}

/// Json representation of a playlist with a single track
@JsonSerializable()
class PlaylistTrack extends Object {
  PlaylistTrack();

  factory PlaylistTrack.fromJson(Map<String, dynamic> json) => _$PlaylistTrackFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistTrackToJson(this);

  /// The date and time the track was added.
  /// Note that some very old playlists may return `null` in this field.
  @JsonKey(name: 'added_at')
  DateTime? addedAt;

  /// The Spotify user who added the track.
  /// Note that some very old playlists may return `null` in this field.
  @JsonKey(name: 'added_by')
  UserPublic? addedBy;

  /// Whether this track is a local file or not.
  @JsonKey(name: 'is_local')
  bool? isLocal;

  /// Information about the track
  Track? track;
}
