// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of an audiobook narrator
@JsonSerializable()
class Narrator extends Object {
  Narrator();

  factory Narrator.fromJson(Map<String, dynamic> json) =>
      _$NarratorFromJson(json);

  Map<String, dynamic> toJson() => _$NarratorToJson(this);

  /// The name of the narrator
  String? name;
}
