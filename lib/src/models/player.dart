// Copyright (c) 2018, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

@JsonSerializable()
class Player extends Object {
  Player() {}
  factory Player.fromJson(Map<String, dynamic> json) =>
      _$PlayerFromJson(json);
  int timestamp;

  PlayerContext context;

  int progress_ms;

  Track item;

  String currently_playing_type;
  
  bool is_playing;
}

@JsonSerializable()
class PlayerContext extends Object {
  PlayerContext() {}
  factory PlayerContext.fromJson(Map<String, dynamic> json) =>
      _$PlayerContextFromJson(json);
  ExternalUrls external_urls;
  String href;
  String type;
  String uri;  
}

@JsonSerializable()
class ExternalUrls extends Object {
  ExternalUrls() {}
  factory ExternalUrls.fromJson(Map<String, dynamic> json) =>
      _$ExternalUrlsFromJson(json);

  String spotify;
  
}
