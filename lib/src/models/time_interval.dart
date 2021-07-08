// Copyright (c) 2021, grabajuice. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class TimeInterval extends Object {
  TimeInterval();

  factory TimeInterval.fromJson(Map<String, dynamic> json) =>
      _$TimeIntervalFromJson(json);

  /// The confidence, from 0.0 to 1.0, of the reliability of the interval.
  double confidence;

  /// The duration (in seconds) of the time interval.
  double duration;

  /// The starting point (in seconds) of the time interval.
  double start;
}
