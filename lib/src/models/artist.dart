// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of an artist
@JsonSerializable()
class Artist extends ArtistSimple {
  Artist();

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  /// A list of the genres the artist is associated with.
  /// For example:
  ///    "Prog Rock", "Post-Grunge".
  ///
  /// (If not yet classified, the array is empty.)
  List<String>? genres;

  /// Images of the artist in various sizes, widest first.
  List<Image>? images;
}

/// Json representation of a simplified artist
@JsonSerializable()
class ArtistSimple extends SpotifyContent {
  ArtistSimple();

  factory ArtistSimple.fromJson(Map<String, dynamic> json) => _$ArtistSimpleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ArtistSimpleToJson(this);

  String? name;
}
