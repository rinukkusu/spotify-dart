// Copyright (c) 2018, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class Player extends Object {
  Player() {
    is_playing = false;
  }

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  /// Unix Millisecond Timestamp when data was fetched
  int? timestamp;

  /// A [PlayerContext] Object. Can be [null].
  PlayerContext? context;

  /// Progress into the currently playing track. Can be [null].
  int? progress_ms;

  /// The currently playing track. Can be [null].
  Track? item;

  /// The object type of the currently playing item. Can be one of track,
  /// episode, ad or unknown.
  String? currently_playing_type;

  /// If something is currently playing.
  bool? is_playing;
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
