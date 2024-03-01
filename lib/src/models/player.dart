// Copyright (c) 2018, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

/// Json representation of the playback state
@JsonSerializable(createToJson: false)
class PlaybackState extends Object {
  PlaybackState();

  factory PlaybackState.fromJson(Map<String, dynamic> json) =>
      _$PlaybackStateFromJson(json);

  /// Unix Millisecond Timestamp when data was fetched
  @JsonKey(fromJson: convertToIntIfDoubleValue)
  int? timestamp;

  /// A [PlayerContext] Object. Can be `null`.
  PlayerContext? context;

  /// Progress into the currently playing track. Can be `null`.
  @JsonKey(name: 'progress_ms', fromJson: convertToIntIfDoubleValue)
  int? progressMs;

  /// The currently playing track. Can be `null`.
  Track? item;

  /// The object type of the currently playing item. Can be one of [CurrentlyPlayingType.track],
  /// [CurrentlyPlayingType.episode], [CurrentlyPlayingType.ad] or [CurrentlyPlayingType.unknown].
  @JsonKey(name: 'currently_playing_type')
  CurrentlyPlayingType? currentlyPlayingType;

  /// Allows to update the user interface based on which playback actions are
  /// available within the current context.
  Actions? actions;

  /// `true` if something is currently playing.
  @JsonKey(name: 'is_playing', defaultValue: false)
  bool? isPlaying;

  /// The shuffle state. `true` if shuffle is turned on, `false` if its turned off
  @JsonKey(name: 'shuffle_state', defaultValue: false)
  bool? isShuffling;

  /// The repeat state. Can be [RepeatState.off], [RepeatState.track] or
  /// [RepeatState.context]
  @JsonKey(name: 'repeat_state', defaultValue: RepeatState.off)
  RepeatState? repeatState;
}

/// Json representation of the context of the playback state
@JsonSerializable(createToJson: false)
class PlayerContext extends Object {
  PlayerContext();

  factory PlayerContext.fromJson(Map<String, dynamic> json) =>
      _$PlayerContextFromJson(json);

  /// The external_urls of the context, or `null` if not available.
  @JsonKey(name: 'external_urls')
  ExternalUrls? externalUrls;

  /// The href of the context, or `null` if not available.
  String? href;

  /// The object type of the item’s context. Can be one of album, artist or playlist.
  String? type;

  /// The uri of the context.
  String? uri;
}

@JsonSerializable(createToJson: false)
class Actions extends Object {
  Actions();

  factory Actions.fromJson(Map<String, dynamic> json) =>
      _$ActionsFromJson(json);

  /// Interrupting playback. Optional field.
  @JsonKey(name: 'interrupting_playback', defaultValue: false)
  bool? interruptingPlayback;

  /// Pausing playback. Optional field.
  @JsonKey(name: 'pausing', defaultValue: false)
  bool? pausing;

  /// Resuming playback. Optional field.
  @JsonKey(name: 'resuming', defaultValue: false)
  bool? resuming;

  /// Seeking playback location. Optional field.
  @JsonKey(name: 'seeking', defaultValue: false)
  bool? seeking;

  /// Skipping to the next context. Optional field.
  @JsonKey(name: 'skipping_next', defaultValue: false)
  bool? skippingNext;

  /// Skipping to the previous context. Optional field.
  @JsonKey(name: 'skipping_prev', defaultValue: false)
  bool? skippingPrev;

  /// Toggling repeat context flag. Optional field.
  @JsonKey(name: 'toggling_repeat_context', defaultValue: false)
  bool? togglingRepeatContext;

  /// Toggling repeat track flag. Optional field.
  @JsonKey(name: 'toggling_repeat_track', defaultValue: false)
  bool? togglingRepeatTrack;

  /// Toggling shuffle flag. Optional field.
  @JsonKey(name: 'toggling_shuffle', defaultValue: false)
  bool? togglingShuffle;

  /// Transfering playback between devices. Optional field.
  @JsonKey(name: 'transferring_playback', defaultValue: false)
  bool? transferringPlayback;
}

abstract class StartOrResumeOptions extends Object {
  Map<String, dynamic> toJson();
}

@JsonSerializable(createFactory: false)
class StartWithContextOptions extends StartOrResumeOptions {
  StartWithContextOptions({this.contextUri, this.offset});

  /// Optional. Spotify URI of the context to play. Valid contexts are albums,
  /// artists & playlists.
  /// Example: "spotify:album:1Je1IMUlBXcx1Fz0WE7oPT"
  @JsonKey(name: 'context_uri')
  String? contextUri;

  /// Optional. Indicates from where in the context playback should start.
  /// Only available when [contextUri] corresponds to an album or playlist object
  @JsonKey(toJson: _offsetToJson)
  Offset? offset;

  @override
  Map<String, dynamic> toJson() => _$StartWithContextOptionsToJson(this);

  static Map<String, dynamic>? _offsetToJson(Offset? offset) =>
      offset?.toJson();
}

@JsonSerializable(createFactory: false)
class StartWithUrisOptions extends StartOrResumeOptions {
  StartWithUrisOptions({this.uris, this.positionMs});

  /// Optional. A JSON array of the Spotify track URIs to play.
  ///
  /// Example:
  /// ```json
  /// [
  ///     "spotify:track:4iV5W9uYEdYUVa79Axb7Rh",
  ///     "spotify:track:1301WleyT98MSxVHPZCA6M"
  /// ]
  /// ```
  List<String>? uris;

  /// Optional. The position in milliseconds to start playback.
  @JsonKey(name: 'position_ms', fromJson: convertToIntIfDoubleValue)
  int? positionMs;

  @override
  Map<String, dynamic> toJson() => _$StartWithUrisOptionsToJson(this);
}

abstract class Offset {
  Map<String, dynamic> toJson();
}

/// "uri" is a string representing the uri of the item to start at.
/// Example: "spotify:track:1301WleyT98MSxVHPZCA6M"
@JsonSerializable(createFactory: false)
class UriOffset extends Offset {
  final String uri;

  UriOffset(this.uri);

  @override
  Map<String, dynamic> toJson() => _$UriOffsetToJson(this);
}

/// "position" is zero based and can’t be negative.
@JsonSerializable(createFactory: false)
class PositionOffset extends Offset {
  @JsonKey(fromJson: convertToIntIfDoubleValueWithoutNull)
  final int position;

  PositionOffset(this.position) {
    assert(position >= 0, 'Position must be greater than or equal to 0');
  }

  @override
  Map<String, dynamic> toJson() => _$PositionOffsetToJson(this);
}

/// Representation of the current repeat state
enum RepeatState { off, context, track }

/// Representation of what is currently playing
enum CurrentlyPlayingType { track, episode, ad, unknown }
