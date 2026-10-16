// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of an album
@JsonSerializable()
class Album extends AlbumSimple {
  Album();

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  /// The copyright statements of the album.
  List<Copyright>? copyrights;

  /// A list of the genres the artist is associated with.
  /// For example:
  ///     "Prog Rock", "Post-Grunge".
  ///
  /// (If not yet classified, the array is empty.)
  List<String>? genres;
}

@JsonSerializable()
class AlbumSimple extends Object {
  AlbumSimple();

  factory AlbumSimple.fromJson(Map<String, dynamic> json) => _$AlbumSimpleFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumSimpleToJson(this);

  /// Helper function that unwraps the items from the paging object.
  static Iterable<TrackSimple> _extractTracksFromPage(dynamic json) {
    if (json == null) {
      return [];
    }

    if (json is List) {
      return json.map((trackJson) => TrackSimple.fromJson(trackJson));
    }

    final items = Paging.fromJson(json).itemsNative;
    return json.isEmpty || (items == null) ? [] : items.map((trackJson) => TrackSimple.fromJson(trackJson));
  }

  static AlbumType? _convertForAlbumType(String? json) {
    return AlbumType.values.asNameMap()[json?.toLowerCase()];
  }

  /// The type of the album: one of "album", "single", or "compilation".
  @JsonKey(name: 'album_type', fromJson: _convertForAlbumType)
  AlbumType? albumType;

  /// The artists of the album. Each artist object includes a link in href to
  /// more detailed information about the artist.
  List<ArtistSimple>? artists;

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

  /// Known external IDs for this track.
  @JsonKey(name: 'external_ids')
  ExternalIds? externalIds;

  /// The tracks of this album.
  @JsonKey(fromJson: _extractTracksFromPage)
  Iterable<TrackSimple>? tracks = [];
}

enum DatePrecision { day, month, year }

enum AlbumType { album, single, compilation }
