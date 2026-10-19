// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of a resume point for an audiobook chapter
@JsonSerializable()
class ResumePoint extends Object {
  ResumePoint();

  factory ResumePoint.fromJson(Map<String, dynamic> json) => _$ResumePointFromJson(json);

  Map<String, dynamic> toJson() => _$ResumePointToJson(this);

  /// Whether or not the chapter has been fully played by the user
  @JsonKey(name: 'fully_played')
  bool? fullyPlayed;

  /// The user's most recent position in the chapter in milliseconds
  @JsonKey(name: 'resume_position_ms', fromJson: convertToIntIfDoubleValue)
  int? resumePositionMs;
}
