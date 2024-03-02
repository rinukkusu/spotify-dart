// Copyright (c) 2021, grabajuice. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// JSON representation of a track's analysis information
@JsonSerializable(createToJson: false)
class AudioAnalysis extends Object {
  AudioAnalysis();

  factory AudioAnalysis.fromJson(Map<String, dynamic> json) =>
      _$AudioAnalysisFromJson(json);

  TrackAudioAnalysis? track;

  List<TimeInterval>? bars;

  List<TimeInterval>? beats;

  List<Section>? sections;

  List<Segment>? segments;

  List<TimeInterval>? tatums;
}

abstract class _Section {
  /// The duration (in seconds) of the section.
  double? duration;

  /// The confidence, from 0.0 to 1.0, of the reliability of the section’s “designation”.
  double? confidence;

  /// The overall loudness of the section in decibels (dB).
  /// Loudness values are useful for comparing relative loudness of sections within tracks.
  double? loudness;

  /// The overall estimated tempo of the section in beats per minute (BPM).
  /// In musical terminology, tempo is the speed or pace of a given piece and derives
  /// directly from the average beat duration.
  double? tempo;

  /// The confidence, from 0.0 to 1.0, of the reliability of the tempo.
  /// Some tracks contain tempo changes or sounds which don’t contain tempo (like pure speech)
  /// which would correspond to a low value in this field.
  @JsonKey(name: 'tempo_confidence')
  double? tempoConfidence;

  /// The estimated overall key of the section. The values in this field
  /// ranging from `0 to `11` mapping to pitches using standard Pitch Class notation
  /// (E.g. `0 = C`, `1 = C♯/D♭`, `2 = D`, and so on). If no key was detected, the value is `-1`.
  @JsonKey(fromJson: convertToIntIfDoubleValue)
  int? key;

  /// The confidence, from 0.0 to 1.0, of the reliability of the key.
  /// Songs with many key changes may correspond to low values in this field.
  @JsonKey(name: 'key_confidence')
  double? keyConfidence;

  ///	Indicates the modality (major or minor) of a track, the type of scale
  /// from which its melodic content is derived. This field will contain
  /// a `0` for “minor”, a `1` for “major”, or a `-1` for no result.
  /// Note that the major key (e.g. C major) could more likely be confused
  /// with the minor key at `3` semitones lower (e.g. A minor) as both
  /// keys carry the same pitches.
  @JsonKey(fromJson: convertToIntIfDoubleValue)
  int? mode;

  /// The confidence, from `0.0` to `1.0`, of the reliability of the mode.
  @JsonKey(name: 'mode_confidence')
  double? modeConfidence;

  ///	An estimated overall time signature of a track.
  /// The time signature (meter) is a notational convention to specify
  /// how many beats are in each bar (or measure).
  /// The time signature ranges from `3` to `7` indicating time signatures
  /// of “3/4”, to “7/4”.
  @JsonKey(name: 'time_signature', fromJson: convertToIntIfDoubleValue)
  int? timeSignature;

  /// The confidence, from `0.0` to `1.0`, of the reliability of the
  /// [timeSignature]. Sections with time signature changes may correspond
  /// to low values in this field.
  @JsonKey(name: 'time_signature_confidence')
  double? timeSignatureConfidence;
}

/// JSON representation of the track analysis summary
@JsonSerializable(createToJson: false)
class TrackAudioAnalysis extends _Section {
  TrackAudioAnalysis();

  factory TrackAudioAnalysis.fromJson(Map<String, dynamic> json) =>
      _$TrackAudioAnalysisFromJson(json);

  /// The exact number of audio samples analyzed from this track.
  /// See also [analysisSampleRate].
  @JsonKey(name: 'num_samples', fromJson: convertToIntIfDoubleValue)
  int? numSamples;

  /// The sample rate used to decode and analyze this track.
  ///
  /// May differ from the actual sample rate of this track available on Spotify.
  @JsonKey(name: 'analysis_sample_rate', fromJson: convertToIntIfDoubleValue)
  int? analysisSampleRate;

  @JsonKey(name: 'analysis_channels', fromJson: convertToIntIfDoubleValue)
  int? analysisChannels;

  /// The time, in seconds, at which the track's fade-in period ends.
  /// If the track has no fade-in, this will be `0.0`.
  @JsonKey(name: 'end_of_fade_in')
  double? endOfFadeIn;

  @JsonKey(name: 'start_of_fade_out')
  double? startOfFadeOut;

  @JsonKey(name: 'synchstring')
  String? synchString;

  /// A version number for the Synchstring used in the synchstring field.
  @JsonKey(name: 'synch_version')
  double? synchVersion;

  /// A Rhythmstring for this track.
  /// The format of this string is similar to the [synchString].
  @JsonKey(name: 'rhythmstring')
  String? rhythmString;

  /// A version number for the Rhythmstring used in the [rhythmString] field.
  @JsonKey(name: 'rhythm_version')
  double? rhythmVersion;

  /// An Echo Nest [Musical Fingerprint (ENMFP)](https://academiccommons.columbia.edu/doi/10.7916/D8Q248M4)
  /// codestring for this track.
  @JsonKey(name: 'codestring')
  String? codeString;

  /// A version number for the Echo Nest Musical Fingerprint format
  /// used in the [codeString] field.
  @JsonKey(name: 'code_version')
  double? codeVersion;
}

/// JSON representation of track section in the analysis
@JsonSerializable(createToJson: false)
class Section extends _Section {
  Section();

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  /// The starting point (in seconds) of the section.
  double? start;
}

/// JSON representation of track segment in the analysis
@JsonSerializable(createToJson: false)
class Segment extends Object {
  Segment();

  factory Segment.fromJson(Map<String, dynamic> json) =>
      _$SegmentFromJson(json);

  /// The starting point (in seconds) of the segment.
  double? start;

  /// The duration (in seconds) of the segment.
  double? duration;

  /// The confidence, from `0.0` to `1.0`, of the reliability of the segmentation.
  /// Segments of the song which are difficult to logically
  /// segment (e.g: noise) may correspond to low values in this field.
  double? confidence;

  /// The onset loudness of the segment in decibels (dB).
  /// Combined with [loudnessMax] and [loudnessMaxTime], these components
  /// can be used to describe the “attack” of the segment.
  @JsonKey(name: 'loudness_start')
  double? loudnessStart;

  /// The peak loudness of the segment in decibels (dB).
  /// Combined with loudness_start and loudness_max_time, these components
  /// can be used to describe the “attack” of the segment.
  @JsonKey(name: 'loudness_max')
  double? loudnessMax;

  /// The segment-relative offset of the segment peak loudness in seconds.
  /// Combined with [loudnessStart] and [loudnessMax], these components
  /// can be used to describe the “attack” of the segment.
  @JsonKey(name: 'loudness_max_time')
  double? loudnessMaxTime;

  /// The offset loudness of the segment in decibels (dB).
  /// This value should be equivalent to the [loudnessStart] of
  /// the following segment.
  @JsonKey(name: 'loudness_end')
  double? loudnessEnd;

  /// A “chroma” vector representing the pitch content of the segment,
  /// corresponding to the `12` pitch classes `C`, `C#`, `D` to `B`,
  /// with values ranging from `0` to `1` that describe the relative dominance
  /// of every pitch in the chromatic scale.
  ///
  /// More details about how to interpret this vector can be found below.
  List<double>? pitches;

  /// Timbre is the quality of a musical note or sound that distinguishes
  /// different types of musical instruments, or voices.
  /// Timbre vectors are best used in comparison with each other.
  ///
  /// More details about how to interpret this vector can be found on the below.
  List<double>? timbre;
}

/// JSON representation of a time interval inside [AudioAnalysis.bars],
/// [AudioAnalysis.beats] and [AudioAnalysis.tatums],
@JsonSerializable(createToJson: false)
class TimeInterval extends Object {
  TimeInterval();

  factory TimeInterval.fromJson(Map<String, dynamic> json) =>
      _$TimeIntervalFromJson(json);

  /// The confidence, from `0.0` to `1.0`, of the reliability of the interval.
  double? confidence;

  /// The duration (in seconds) of the time interval.
  double? duration;

  /// The starting point (in seconds) of the time interval.
  double? start;
}
