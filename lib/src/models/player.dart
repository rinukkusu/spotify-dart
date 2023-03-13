// Copyright (c) 2018, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class PlaybackState extends Object {
  PlaybackState();

  factory PlaybackState.fromJson(Map<String, dynamic> json) =>
      _$PlaybackStateFromJson(json);

  /// Unix Millisecond Timestamp when data was fetched
  int? timestamp;

  /// A [PlayerContext] Object. Can be [null].
  PlayerContext? context;

  /// Progress into the currently playing track. Can be [null].
  int? progress_ms;

  /// The currently playing track. Can be [null].
  Track? item;

  /// The object type of the currently playing item. Can be one of [track],
  /// [episode], [ad] or [unknown].
  @JsonKey(name: 'currently_playing_type')
  CurrentlyPlayingType? currentlyPlayingType;

  /// [true] if something is currently playing.
  @JsonKey(name: 'is_playing', defaultValue: false)
  bool? isPlaying;

  /// The shuffle state. [true] if shuffle is turned on, [false] if its turned off
  @JsonKey(name: 'shuffle_state', defaultValue: false)
  bool? isShuffling;

  /// The repeat state. Can be [off], [track] or [context]
  @JsonKey(name: 'repeat_state', defaultValue: RepeatState.off)
  RepeatState? repeatState;
}

@JsonSerializable(createToJson: false)
class PlayerContext extends Object {
  PlayerContext();

  factory PlayerContext.fromJson(Map<String, dynamic> json) =>
      _$PlayerContextFromJson(json);

  /// The external_urls of the context, or [null] if not available.
  ExternalUrls? external_urls;

  /// The href of the context, or [null] if not available.
  String? href;

  /// The object type of the item’s context. Can be one of album, artist or playlist.
  String? type;

  /// The uri of the context.
  String? uri;
}

@JsonSerializable(createFactory: false)
class StartOrResumeOptions extends Object {
  /// Optional. Spotify URI of the context to play. Valid contexts are albums,
  /// artists & playlists.
  /// Example: "spotify:album:1Je1IMUlBXcx1Fz0WE7oPT"
  @JsonKey(name: 'context_uri')
  String? contextUri;

  /// Optional. A JSON array of the Spotify track URIs to play.
  /// Example: [
  ///     "spotify:track:4iV5W9uYEdYUVa79Axb7Rh",
  ///     "spotify:track:1301WleyT98MSxVHPZCA6M"
  /// ]
  List<String>? uris;

  /// Optional. Indicates from where in the context playback should start.
  /// Only available when context_uri corresponds to an album or playlist object
  @JsonKey(toJson: _offsetToJson)
  Offset? offset;

  /// Optional. The position in milliseconds to start playback.
  @JsonKey(name: 'position_ms')
  int? positionMs;

  StartOrResumeOptions(
      {this.contextUri, this.uris, this.offset, this.positionMs});

  Map<String, dynamic> toJson() => _$StartOrResumeOptionsToJson(this);

  static Map<String, dynamic> _offsetToJson(Offset? offset) {
    if (offset is UriOffset) {
      return {'uri': offset.uri};
    } else if (offset is PositionOffset) {
      return {'position': offset.position};
    } else {
      return {};
    }
  }
}

abstract class Offset {}

/// "uri" is a string representing the uri of the item to start at.
/// Example: "spotify:track:1301WleyT98MSxVHPZCA6M"
@JsonSerializable()
class UriOffset extends Offset {
  final String uri;

  UriOffset(this.uri);
}

/// "position" is zero based and can’t be negative.
@JsonSerializable()
class PositionOffset extends Offset {
  final int position;

  PositionOffset(this.position) {
    assert(position >= 0, 'Position must be greater than or equal to 0');
  }
}

enum RepeatState { off, context, track }

enum CurrentlyPlayingType { track, episode, ad, unknown }
