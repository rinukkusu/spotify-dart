// Copyright (c) 2021, grabajuice. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class Segment extends Object {
  Segment();

  factory Segment.fromJson(Map<String, dynamic> json) =>
      _$SegmentFromJson(json);

  /// The starting point (in seconds) of the segment.
  double? start;

  /// The duration (in seconds) of the segment.
  double? duration;

  /// The confidence, from `0.0` to `1.0`, of the reliability of the
  /// segmentation. Segments of the song which are difficult to logically segment
  ///  (e.g: noise) may correspond to low values in this field.
  double? confidence;

  /// The onset loudness of the segment in decibels (dB). Combined with
  /// [loudnessMax] and [loudnessMaxTime], these components can
  /// be used to describe the “attack” of the segment.
  @JsonKey(name: 'loudness_start')
  double? loudnessStart;

  /// The peak loudness of the segment in decibels (dB).
  /// Combined with loudness_start and loudness_max_time, these components
  /// can be used to describe the “attack” of the segment.
  @JsonKey(name: 'loudness_max')
  double? loudnessMax;

  /// The segment-relative offset of the segment peak loudness in seconds.
  /// Combined with loudness_start and loudness_max, these components
  /// can be used to describe the “attack” of the segment.
  @JsonKey(name: 'loudness_max_time')
  double? loudnessMaxTime;

  /// The offset loudness of the segment in decibels (dB).
  /// This value should be equivalent to the [loudnessStart] of the following
  /// segment.
  @JsonKey(name: 'loudness_end')
  double? loudnessEnd;

  /// A “chroma” vector representing the pitch content of the segment, corresponding to the 12 pitch classes C, C#, D to B, with values ranging from 0 to 1 that describe the relative dominance of every pitch in the chromatic scale. More details about how to interpret this vector can be found below.
  List<double>? pitches;

  /// Timbre is the quality of a musical note or sound that distinguishes different types of musical instruments, or voices. Timbre vectors are best used in comparison with each other. More details about how to interpret this vector can be found on the below.
  List<double>? timbre;
}
