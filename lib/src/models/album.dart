// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class Album extends AlbumSimple {
  Album();

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  /// The copyright statements of the album.
  List<Copyright>? copyrights;

  /// Known external IDs for the album.
  @JsonKey(name: 'external_ids')
  ExternalIds? externalIds;

  /// A list of the genres the artist is associated with.
  /// For example:
  ///     "Prog Rock", "Post-Grunge".
  ///
  /// (If not yet classified, the array is empty.)
  List<String>? genres;

  /// The label for the album.
  String? label;

  /// The popularity of the artist. The value will be between 0 and 100, with 100
  /// being the most popular. The artist's popularity is calculated from the
  /// popularity of all the artist's tracks.
  int? popularity;
}

@JsonSerializable(createToJson: false)
class AlbumSimple extends Object {
  AlbumSimple();

  factory AlbumSimple.fromJson(Map<String, dynamic> json) =>
      _$AlbumSimpleFromJson(json);

  /// Helper function that unwraps the items from the paging object.
  static Iterable<TrackSimple> _extractTracksFromPage(dynamic? json) {
    if (json == null) {
      return [];
    }

    var items = Paging.fromJson(json).itemsNative;
    return json.isEmpty || (items == null)
        ? []
        : items.map((trackJson) => TrackSimple.fromJson(trackJson));
  }

  /// The type of the album: one of "album", "single", or "compilation".
  @JsonKey(name: 'album_type')
  String? albumType;

  /// The artists of the album. Each artist object includes a link in href to
  /// more detailed information about the artist.
  List<ArtistSimple>? artists;

  /// The markets in which the album is available: ISO 3166-1 alpha-2 country
  /// codes. Note that an album is considered available in a market when at least
  /// 1 of its tracks is available in that market.
  @JsonKey(name: 'available_markets')
  List<String>? availableMarkets;

  /// Known external URLs for this album.
  @JsonKey(name: 'external_urls')
  ExternalUrls? externalUrls;

  /// A link to the Web API endpoint providing full details of the album.
  String? href;

  /// The Spotify ID for the album.
  String? id;

  /// The cover art for the album in various sizes, widest first.
  List<Image>? images;

  /// The name of the album. In case of an album takedown, the value may be an
  /// empty string.
  String? name;

  /// The date the album was first released, for example "1981-12-15".
  /// Depending on the precision, it might be shown as "1981" or "1981-12".
  @JsonKey(name: 'release_date')
  String? releaseDate;

  /// The precision with which release_date value is known:
  /// "year", "month", or "day".
  @JsonKey(name: 'release_date_precision')
  DatePrecision? releaseDatePrecision;

  /// The object type: "album"
  String? type;

  /// The Spotify URI for the album.
  String? uri;

  /// The tracks of this album.
  @JsonKey(fromJson: _extractTracksFromPage)
  Iterable<TrackSimple>? tracks = [];
}

enum DatePrecision { day, month, year }
