// Copyright (c) 2021, grabajuice. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class Section extends Object {
  Section();

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  /// The starting point (in seconds) of the section.
  double start;

  /// The duration (in seconds) of the section.
  double duration;

  /// The confidence, from 0.0 to 1.0, of the reliability of the section’s “designation”.
  double confidence;

  /// The overall loudness of the section in decibels (dB). Loudness values are useful for comparing relative loudness of sections within tracks.
  double loudness;

  /// The overall estimated tempo of the section in beats per minute (BPM). In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration.
  double tempo;

  /// The confidence, from 0.0 to 1.0, of the reliability of the tempo. Some tracks contain tempo changes or sounds which don’t contain tempo (like pure speech) which would correspond to a low value in this field.
  double tempo_confidence;

  ///The estimated overall key of the section. The values in this field ranging from 0 to 11 mapping to pitches using standard Pitch Class notation (E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on). If no key was detected, the value is -1.
  int key;

  /// The confidence, from 0.0 to 1.0, of the reliability of the key. Songs with many key changes may correspond to low values in this field.
  double key_confidence;

  ///	Indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived. This field will contain a 0 for “minor”, a 1 for “major”, or a -1 for no result. Note that the major key (e.g. C major) could more likely be confused with the minor key at 3 semitones lower (e.g. A minor) as both keys carry the same pitches.
  int mode;

  /// The confidence, from 0.0 to 1.0, of the reliability of the mode.
  double mode_confidence;

  ///	An estimated overall time signature of a track. The time signature (meter) is a notational convention to specify how many beats are in each bar (or measure). The time signature ranges from 3 to 7 indicating time signatures of “3/4”, to “7/4”.
  int time_signature;

  /// The confidence, from 0.0 to 1.0, of the reliability of the time_signature. Sections with time signature changes may correspond to low values in this field.
  double time_signature_confidence;
}
