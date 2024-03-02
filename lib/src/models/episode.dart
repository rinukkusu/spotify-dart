// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of an episode
@JsonSerializable(createToJson: false)
class Episode extends Object {
  Episode();

  /// The episode length in milliseconds.
  /// A URL to a 30 second preview (MP3 format) of the episode.
  /// `null` if not available.
  @JsonKey(name: 'audio_preview_url')
  String? audioPreviewUrl;

  /// A description of the episode.
  String? description;

  /// The episode length in milliseconds.
  @JsonKey(name: 'duration_ms', fromJson: convertToIntIfDoubleValue)
  int? durationMs;

  /// Whether or not the episode has explicit content
  /// (`true` = yes it does; `false` = no it does not OR unknown).
  bool? explicit;

  /// Known external URLs for this episode.
  @JsonKey(name: 'external_urls')
  ExternalUrls? externalUrls;

  /// A link to the Web API endpoint providing full details of the episode.
  String? href;

  /// The Spotify ID for the episode.
  String? id;

  /// The cover art for the episode in various sizes, widest first.
  List<Image>? images;

  /// True if the episode is hosted outside of Spotify’s CDN.
  @JsonKey(name: 'is_externally_hosted')
  bool? isExternallyHosted;

  /// Part of the response when Track Relinking is applied. If true, the track
  /// is playable in the given market. Otherwise false.
  @JsonKey(name: 'is_playable')
  bool? isPlayable;

  /// Note: This field is deprecated and might be removed in the future.
  /// Please use the languages field instead. The language used in the episode, identified by a ISO 639 code.
  String? language;

  /// A list of the languages used in the episode, identified by their ISO 639 code.
  List<String>? languages;

  /// The name of the episode.
  String? name;

  /// The date the episode was first released, for example "1981-12-15".
  /// Depending on the precision, it might be shown as "1981" or "1981-12".
  @JsonKey(name: 'release_date')
  DateTime? releaseDate;

  /// The precision with which release_date value is known:
  ///     "year", "month", or "day".
  @JsonKey(name: 'release_date_precision')
  String? releaseDatePrecision;

  /// The object type: "episode".
  String? type;

  /// The Spotify ID for the episode.
  String? uri;

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}

/// Json representation of an episode with information about its show
@JsonSerializable(createToJson: false)
class EpisodeFull extends Episode {
  EpisodeFull();

  Show? show;

  factory EpisodeFull.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFullFromJson(json);
}
