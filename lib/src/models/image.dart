// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class Image extends Object {
  Image();

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  /// The image height in pixels. If unknown: null or not returned.
  int? height;

  /// The image width in pixels. If unknown: null or not returned.
  int? width;

  /// The source URL of the image.
  String? url;
}
