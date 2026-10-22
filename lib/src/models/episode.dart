// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of an episode
@JsonSerializable()
class EpisodeSimple extends SpokenAudioContent {
  EpisodeSimple();

  factory EpisodeSimple.fromJson(Map<String, dynamic> json) => _$EpisodeSimpleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EpisodeSimpleToJson(this);

  /// True if the episode is hosted outside of Spotify’s CDN.
  @JsonKey(name: 'is_externally_hosted')
  bool? isExternallyHosted;

  /// Note: This field is deprecated and might be removed in the future.
  /// Please use the languages field instead. The language used in the episode,
  /// identified by a ISO 639 code.
  String? language;
}

/// Json representation of an episode with information about its show
@JsonSerializable()
class Episode extends EpisodeSimple {
  Episode();

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  Show? show;
}
