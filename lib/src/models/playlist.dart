// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class Playlist extends Object implements PlaylistSimple {
  Playlist();

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);

  /// true if the owner allows other users to modify the playlist.
  @override
  bool collaborative;

  /// The playlist description. Only returned for modified, verified playlists,
  /// otherwise [null].
  String description;

  /// Known external URLs for this playlist.
  @JsonKey(name: 'external_urls')
  @override
  ExternalUrls externalUrls;

  /// Information about the followers of the playlist.
  Followers followers;

  /// A link to the Web API endpoint providing full details of the playlist.
  @override
  String href;

  /// The Spotify ID for the playlist.
  @override
  String id;

  /// Images for the playlist. The array may be empty or contain up to three
  /// images. The images are returned by size in descending order. See Working
  /// with Playlists.
  ///
  /// Note: If returned, the source URL for the image (url) is temporary and
  /// will expire in less than a day.
  @override
  List<Image> images;

  /// The name of the playlist.
  @override
  String name;

  /// The user who owns the playlist
  @override
  User owner;

  /// The playlist's public/private status: [true] the playlist is public,
  /// [false] the playlist is private, null the playlist status is not relevant.
  /// For more about public/private status, see Working with Playlists.
  @override
  bool public;

  /// The version identifier for the current playlist. Can be supplied in other
  /// requests to target a specific playlist version
  @JsonKey(name: 'snapshot_id')
  @override
  String snapshotId;

  /// Use [Playlist.tracks]
  @override
  @JsonKey(ignore: true)
  TracksLink tracksLink;

  /// Information about the tracks of the playlist.
  List<Track> tracks;

  /// The object type: "playlist"
  @override
  String type;

  /// The Spotify URI for the playlist.
  @override
  String uri;
}

@JsonSerializable(createToJson: false)
class PlaylistSimple extends Object {
  PlaylistSimple();
  factory PlaylistSimple.fromJson(Map<String, dynamic> json) =>
      _$PlaylistSimpleFromJson(json);

  /// true if the owner allows other users to modify the playlist.
  bool collaborative;

  /// Known external URLs for this playlist.
  @JsonKey(name: 'external_urls')
  ExternalUrls externalUrls;

  /// A link to the Web API endpoint providing full details of the playlist.
  String href;

  /// The Spotify ID for the playlist.
  String id;

  /// Images for the playlist. The array may be empty or contain up to three
  /// images. The images are returned by size in descending order. See Working
  /// with Playlists.
  ///
  /// Note: If returned, the source URL for the image (url) is temporary and
  /// will expire in less than a day.
  List<Image> images;

  /// The name of the playlist.
  String name;

  /// The user who owns the playlist
  User owner;

  /// The playlist's public/private status: [true] the playlist is public,
  /// [false] the playlist is private, null the playlist status is not relevant.
  /// For more about public/private status, see Working with Playlists.
  bool public;

  /// The version identifier for the current playlist. Can be supplied in other
  /// requests to target a specific playlist version
  @JsonKey(name: 'snapshot_id')
  String snapshotId;

  /// A collection containing a link (href) to the Web API endpoint where full
  /// details of the playlist's tracks can be retrieved, along with the total
  /// number of tracks in the playlist.
  @JsonKey(name: 'tracks')
  TracksLink tracksLink;

  /// The object type: "playlist"
  String type;

  /// The Spotify URI for the playlist.
  String uri;
}

@JsonSerializable(createToJson: false)
class PlaylistsFeatured extends Object {
  PlaylistsFeatured();
  factory PlaylistsFeatured.fromJson(Map<String, dynamic> json) =>
      _$PlaylistsFeaturedFromJson(json);

  /// The message of the day for Spotify's featured playlists
  String message;
}

@JsonSerializable(createToJson: false)
class PlaylistTrack extends Object {
  PlaylistTrack();
  factory PlaylistTrack.fromJson(Map<String, dynamic> json) =>
      _$PlaylistTrackFromJson(json);

  /// The date and time the track was added.
  /// Note that some very old playlists may return [null] in this field.
  @JsonKey(name: 'added_at')
  DateTime addedAt;

  /// The Spotify user who added the track.
  /// Note that some very old playlists may return [null] in this field.
  @JsonKey(name: 'added_by')
  UserPublic addedBy;

  /// Whether this track is a local file or not.
  @JsonKey(name: 'is_local')
  bool isLocal;

  /// Information about the track
  Track track;
}
