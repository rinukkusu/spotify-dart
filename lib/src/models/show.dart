// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class Show {
  Show();

  /// The markets in which the show is available: ISO 3166-1 alpha-2 country
  /// codes. Note that an album is considered available in a market when at least
  /// 1 of its tracks is available in that market.
  @JsonKey(name: 'available_markets')
  List<String>? availableMarkets;

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

  /// A link to the Web API endpoint providing full details of the show.
  String? href;

  /// The Spotify ID for the show.
  String? id;

  /// The cover art for the show in various sizes, widest first.
  List<Image>? images;

  /// True if the show is hosted outside of Spotify’s CDN.
  @JsonKey(name: 'is_externally_hosted')
  bool? isExternallyHosted;

  /// A list of the languages used in the show, identified by their ISO 639 code.
  List<String>? languages;

  /// The media type of the show.
  @JsonKey(name: 'media_type')
  String? mediaType;

  /// The name of the show.
  String? name;

  /// The publisher of the show.
  String? publisher;

  /// The object type: "show"
  String? type;

  /// The Spotify URI for the show.
  String? uri;

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);
}
