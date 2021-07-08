// Copyright (c) 2019, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class ExternalUrls extends Object {
  ExternalUrls();

  factory ExternalUrls.fromJson(Map<String, dynamic> json) =>
      _$ExternalUrlsFromJson(json);

  /// The Spotify URL for the object.
  String? spotify;
}

@JsonSerializable(createToJson: false)
class ExternalIds extends Object {
  ExternalIds();

  factory ExternalIds.fromJson(Map<String, dynamic> json) =>
      _$ExternalIdsFromJson(json);

  /// International Standard Recording Code
  String? isrc;

  /// International Article Number
  String? ean;

  /// Universal Product Code
  String? upc;
}
