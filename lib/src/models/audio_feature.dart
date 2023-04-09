// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

/// Json representation of an audio feature
@JsonSerializable(createToJson: false)
class AudioFeature extends Object {
  AudioFeature();

  factory AudioFeature.fromJson(Map<String, dynamic> json) =>
      _$AudioFeatureFromJson(json);

  /// A confidence measure from `0.0` to `1.0` of whether the track is acoustic.
  /// `1.0` represents high confidence the track is acoustic.
  double? acousticness;

  /// An HTTP URL to access the full audio analysis of this track. An access
  /// token is required to access this data.
  @JsonKey(name: 'analysis_url')
  String? analysisUrl;

  /// Danceability describes how suitable a track is for dancing based on a
  /// combination of musical elements including tempo, rhythm stability, beat
  /// strength, and overall regularity. A value of `0.0` is least danceable and
  /// `1.0` is most danceable.
  double? danceability;

  /// The track length in milliseconds.
  @JsonKey(name: 'duration_ms')
  int? durationMs;

  /// The track length
  @JsonKey(includeFromJson: false)
  Duration? get duration => Duration(milliseconds: durationMs ?? 0);

  /// Energy is a measure from `0.0` to `1.0` and represents a perceptual measure of
  /// intensity and activity. Typically, energetic tracks feel fast, loud, and
  /// noisy. For example, death metal has high energy, while a Bach prelude
  /// scores low on the scale. Perceptual features contributing to this
  /// attribute include dynamic range, perceived loudness, timbre, onset rate,
  /// and general entropy.
  double? energy;

  /// The Spotify ID for the track.
  String? id;

  /// Predicts whether a track contains no vocals. "Ooh" and "aah" sounds are
  /// treated as instrumental in this context. Rap or spoken word tracks are
  /// clearly "vocal". The closer the instrumentalness value is to `1.0`, the
  /// greater likelihood the track contains no vocal content. Values above `0.5`
  /// are intended to represent instrumental tracks, but confidence is higher as
  /// the value approaches `1.0`.
  double? instrumentalness;

  /// The key the track is in. Integers map to pitches using standard Pitch
  /// Class notation. E.g. `0 = C`, `1 = C♯/D♭`, `2 = D`, and so on.
  int? key;

  /// Detects the presence of an audience in the recording. Higher liveness
  /// values represent an increased probability that the track was performed
  /// live. A value above 0.8 provides strong likelihood that the track is live.
  double? liveness;

  /// The overall loudness of a track in decibels (dB). Loudness values are
  /// averaged across the entire track and are useful for comparing relative
  /// loudness of tracks. Loudness is the quality of a sound that is the primary
  /// psychological correlate of physical strength (amplitude). Values typical
  /// range between `-60` and `0 db`.
  double? loudness;

  /// Mode indicates the modality (major or minor) of a track, the type of scale
  /// from which its melodic content is derived. Major is represented by 1 and
  /// minor is `0`.
  int? mode;

  /// Speechiness detects the presence of spoken words in a track. The more
  /// exclusively speech-like the recording (e.g. talk show, audio book, poetry),
  /// the closer to `1.0` the attribute value. Values above 0.66 describe tracks
  /// that are probably made entirely of spoken words. Values between `0.33` and
  /// `0.66` describe tracks that may contain both music and speech, either in
  /// sections or layered, including such cases as rap music. Values below `0.33`
  /// most likely represent music and other non-speech-like tracks.
  double? speechiness;

  /// The overall estimated tempo of a track in beats per minute (BPM). In
  /// musical terminology, tempo is the speed or pace of a given piece and
  /// derives directly from the average beat duration.
  double? tempo;

  /// An estimated overall time signature of a track. The time signature (meter)
  /// is a notational convention to specify how many beats are in each bar (or
  /// measure).
  @JsonKey(name: 'time_signature')
  int? timeSignature;

  /// A link to the Web API endpoint providing full details of the track.
  @JsonKey(name: 'track_href')
  String? trackHref;

  /// The object type: "audio_features"
  String? type;

  /// The Spotify URI for the track.
  String? uri;

  /// A measure from `0.0` to `1.0` describing the musical positiveness conveyed by
  /// a track. Tracks with high valence sound more positive (e.g. happy,
  /// cheerful, euphoric), while tracks with low valence sound more negative
  /// (e.g. sad, depressed, angry).
  double? valence;
}
