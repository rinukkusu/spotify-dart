// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

abstract class SpotifyPlaylist extends SpotifyContent {
  /// true if the owner allows other users to modify the playlist.
  bool? collaborative;

  /// The playlist description. Only returned for modified, verified playlists,
  /// otherwise `null`.
  String? description;

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
}

/// Json representation of a simplified playlist
@JsonSerializable()
class PlaylistSimple extends SpotifyPlaylist {
  PlaylistSimple();

  factory PlaylistSimple.fromJson(Map<String, dynamic> json) => _$PlaylistSimpleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlaylistSimpleToJson(this);

  /// A collection containing a link (href) to the Web API endpoint where full
  /// details of the playlist's items can be retrieved, along with the total
  /// number of items in the playlist.
  @JsonKey(name: 'items')
  TracksLink? itemsLink;
}

/// Json representation of a playlist
@JsonSerializable()
class Playlist extends SpotifyPlaylist {
  Playlist();

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  /// The items (tracks, episodes) of the playlist.
  ///
  /// Only returned for playlists the current user owns or collaborates on,
  /// otherwise `null`.
  Paging<PlaylistItem>? items;
}

/// A playlist entry containing a track or podcast episode and its metadata.
@JsonSerializable(createToJson: false)
class PlaylistItem {
  static PlayableContent? _itemFromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }
    return switch (json['type']) {
      'track' => Track.fromJson(json),
      'episode' => Episode.fromJson(json),
      _ => null,
    };
  }

  PlaylistItem();

  factory PlaylistItem.fromJson(Map<String, dynamic> json) => _$PlaylistItemFromJson(json);

  /// The date and time the item was added.
  /// Note that some very old playlists may return `null` in this field.
  @JsonKey(name: 'added_at')
  DateTime? addedAt;

  /// The Spotify user who added the item.
  /// Note that some very old playlists may return `null` in this field.
  @JsonKey(name: 'added_by')
  UserPublic? addedBy;

  /// Whether the item is a local file.
  @JsonKey(name: 'is_local')
  bool? isLocal;

  /// The track or episode in this entry.
  /// Unavailable items and unrecognized item types decode to `null`.
  @JsonKey(fromJson: _itemFromJson, includeToJson: false)
  PlayableContent? item;
}
