// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of a show
@JsonSerializable()
class Show extends SpotifyContent {
  Show();

  /// The copyright statements of the show.
  List<Copyright>? copyrights;

  /// A description of the show.
  String? description;

  /// Whether or not the episode has explicit content
  /// (true = yes it does; false = no it does not OR unknown).
  bool? explicit;

  /// Known external URLs for this show.
  @JsonKey(name: 'external_urls')
  ExternalUrls? externalUrls;

  /// The cover art for the show in various sizes, widest first.
  List<Image>? images;

  /// True if the show is hosted outside of Spotify’s CDN.
  @JsonKey(name: 'is_externally_hosted')
  bool? isExternallyHosted;

  /// A list of the languages used in the show, identified by their ISO 639
  /// code.
  List<String>? languages;

  /// The media type of the show.
  @JsonKey(name: 'media_type')
  String? mediaType;

  /// The name of the show.
  String? name;

  /// The object type: "show"
  // @ove
  // SpotifyContentType? type;

  // /// The Spotify URI for the show.
  // @override
  // String? uri;

  /// The number of total episodes in this show
  @JsonKey(
    name: 'total_episodes',
    defaultValue: 0,
    fromJson: convertToIntIfDoubleValue,
  )
  int? totalEpisodes;

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);

  Map<String, dynamic> toJson() => _$ShowToJson(this);
}
