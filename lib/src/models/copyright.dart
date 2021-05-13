// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class Copyright extends Object {
  Copyright();

  factory Copyright.fromJson(Map<String, dynamic> json) =>
      _$CopyrightFromJson(json);

  /// The copyright text for this album.
  String? text;

  /// The type of copyright:
  ///     C = the copyright
  ///     P = the sound recording (performance) copyright.
  String? type;
}
