// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

@JsonClass()
class Playlist implements PlaylistSimple {
  /// true if the owner allows other users to modify the playlist.
  bool collaborative;

  /// The playlist description. Only returned for modified, verified playlists,
  /// otherwise [null].
  String description;

  // /// Known external URLs for this playlist.
  //@JsonField(key: 'external_urls')
  //Map<String, String> externalUrls;

  /// Information about the followers of the playlist.
  Followers followers;

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
  @JsonField(key: 'snapshot_id')
  String snapshotId;

  /// Use [Playlist.tracks]
  @override
  @Transient()
  TracksLink tracksLink;

  /// Information about the tracks of the playlist.
  List<Track> tracks;

  /// The object type: "playlist"
  String type;

  /// The Spotify URI for the playlist.
  String uri;
}

@JsonClass()
class PlaylistSimple {
  /// true if the owner allows other users to modify the playlist.
  bool collaborative;

  // /// Known external URLs for this playlist.
  //@JsonField(key: 'external_urls')
  //Map<String, String> externalUrls;

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
  @JsonField(key: 'snapshot_id')
  String snapshotId;

  /// A collection containing a link (href) to the Web API endpoint where full
  /// details of the playlist's tracks can be retrieved, along with the total
  /// number of tracks in the playlist.
  @JsonField(key: 'tracks')
  TracksLink tracksLink;

  /// The object type: "playlist"
  String type;

  /// The Spotify URI for the playlist.
  String uri;
}

@JsonClass()
class PlaylistTrack {

  /// The date and time the track was added.
  /// Note that some very old playlists may return [null] in this field.
  @JsonField(key: 'added_at')
  DateTime addedAt;

  /// The Spotify user who added the track.
  /// Note that some very old playlists may return [null] in this field.
  @JsonField(key: 'added_by')
  UserPublic addedBy;

  /// Whether this track is a local file or not.
  @JsonField(key: 'is_local')
  bool isLocal;

  /// Information about the track
  Track track;
}
