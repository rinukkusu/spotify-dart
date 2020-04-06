// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class Track extends Object implements TrackSimple {
  Track();

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  /// The album on which the track appears. The album object includes a link
  /// in [href] to full information about the album.
  AlbumSimple album;

  /// The artists who performed the track. Each artist object includes a link
  /// in [href] to more detailed information about the artist.
  @override
  List<Artist> artists;

  /// A list of the countries in which the track can be played, identified by
  /// their ISO 3166-1 alpha-2 code.
  @JsonKey(name: 'available_markets')
  @override
  List<String> availableMarkets;

  /// The disc number
  /// (usually [1] unless the album consists of more than one disc)
  @JsonKey(name: 'disc_number')
  @override
  int discNumber;

  /// The track length in milliseconds.
  @JsonKey(name: 'duration_ms')
  @override
  int durationMs;

  /// The track length
  @JsonKey(ignore: true)
  @override
  Duration get duration => Duration(milliseconds: durationMs);

  /// Whether or not the track has explicit lyrics
  /// ([true] = yes it does; [false] = no it does not OR unknown).
  @override
  bool explicit;

  /// Known external IDs for this track.
  @JsonKey(name: 'external_ids')
  ExternalIds externalIds;

  /// Known external URLs for this track.
  @JsonKey(name: 'external_urls')
  @override
  ExternalUrls externalUrls;

  /// A link to the Web API endpoint providing full details of the track.
  @override
  String href;

  /// The Spotify ID for the track.
  @override
  String id;

  /// Part of the response when Track Relinking is applied. If true, the track
  /// is playable in the given market. Otherwise false.
  @JsonKey(name: 'is_playable')
  @override
  bool isPlayable;

  /// Part of the response when Track Relinking is applied and is only part of
  /// the response if the track linking, in fact, exists. The requested track
  /// has been replaced with a different track. The track in the linked_from
  /// object contains information about the originally requested track.
  @JsonKey(name: 'linked_from')
  @override
  TrackLink linkedFrom;

  /// The name of the track.
  @override
  String name;

  /// The popularity of the track. The value will be between 0 and 100, with 100
  /// being the most popular.
  ///
  /// The popularity of a track is a value between 0 and 100, with 100 being the
  /// most popular. The popularity is calculated by algorithm and is based, in
  /// the most part, on the total number of plays the track has had and how
  /// recent those plays are.
  ///
  /// Generally speaking, songs that are being played a lot now will have a
  /// higher popularity than songs that were played a lot in the past. Duplicate
  /// tracks (e.g. the same track from a single and an album) are rated
  /// independently. Artist and album popularity is derived mathematically from
  /// track popularity. Note that the popularity value may lag actual popularity
  /// by a few days: the value is not updated in real time.
  int popularity;

  /// A URL to a 30 second preview (MP3 format) of the track. [null] if not
  /// available.
  @JsonKey(name: 'preview_url')
  @override
  String previewUrl;

  /// The number of the track. If an album has several discs, the track number
  /// is the number on the specified disc.
  @JsonKey(name: 'track_number')
  @override
  int trackNumber;

  /// The object type: "track".
  @override
  String type;

  /// The Spotify URI for the track.
  @override
  String uri;
}

@JsonSerializable(createToJson: false)
class TrackSimple extends Object {
  TrackSimple();

  factory TrackSimple.fromJson(Map<String, dynamic> json) =>
      _$TrackSimpleFromJson(json);

  /// The artists who performed the track. Each artist object includes a link
  /// in [href] to more detailed information about the artist.
  List<Artist> artists;

  /// A list of the countries in which the track can be played, identified by
  /// their ISO 3166-1 alpha-2 code.
  @JsonKey(name: 'available_markets')
  List<String> availableMarkets;

  /// The disc number
  /// (usually [1] unless the album consists of more than one disc)
  @JsonKey(name: 'disc_number')
  int discNumber;

  /// The track length in milliseconds.
  @JsonKey(name: 'duration_ms')
  int durationMs;

  /// The track length
  @JsonKey(ignore: true)
  Duration get duration => Duration(milliseconds: durationMs);

  /// Whether or not the track has explicit lyrics
  /// ([true] = yes it does; [false] = no it does not OR unknown).
  bool explicit;

  /// Known external URLs for this track.
  @JsonKey(name: 'external_urls')
  ExternalUrls externalUrls;

  /// A link to the Web API endpoint providing full details of the track.
  String href;

  /// The Spotify ID for the track.
  String id;

  /// Part of the response when Track Relinking is applied. If true, the track
  /// is playable in the given market. Otherwise false.
  @JsonKey(name: 'is_playable')
  bool isPlayable;

  /// Part of the response when Track Relinking is applied and is only part of
  /// the response if the track linking, in fact, exists. The requested track
  /// has been replaced with a different track. The track in the linked_from
  /// object contains information about the originally requested track.
  @JsonKey(name: 'linked_from')
  TrackLink linkedFrom;

  /// The name of the track.
  String name;

  /// A URL to a 30 second preview (MP3 format) of the track. [null] if not
  /// available.
  @JsonKey(name: 'preview_url')
  String previewUrl;

  /// The number of the track. If an album has several discs, the track number
  /// is the number on the specified disc.
  @JsonKey(name: 'track_number')
  int trackNumber;

  /// The object type: "track".
  String type;

  /// The Spotify URI for the track.
  String uri;
}

/// A song saved in a Spotify user’s “Your Music” library
@JsonSerializable(createToJson: false)
class TrackSaved extends Object {
  TrackSaved();
  factory TrackSaved.fromJson(Map<String, dynamic> json) =>
      _$TrackSavedFromJson(json);

  /// The date and time the track was saved.
  @JsonKey(name: 'added_at')
  DateTime addedAt;

  /// Information about the track.
  Track track;
}

@JsonSerializable(createToJson: false)
class TrackLink extends Object {
  TrackLink();
  factory TrackLink.fromJson(Map<String, dynamic> json) =>
      _$TrackLinkFromJson(json);

  /// Known external URLs for this track.
  @JsonKey(name: 'external_urls')
  Map<String, String> externalUrls;

  /// A link to the Web API endpoint providing full details of the track.
  String href;

  /// The Spotify ID for the track.
  String id;

  /// The object type: "track".
  String type;

  /// The Spotify URI for the track.
  String uri;
}

@JsonSerializable(createToJson: false)
class TracksLink extends Object {
  TracksLink();
  factory TracksLink.fromJson(Map<String, dynamic> json) =>
      _$TracksLinkFromJson(json);

  /// A link to the Web API endpoint where full details of the playlist's
  /// tracks can be retrieved
  String href;

  /// Total number of tracks in the playlist
  int total;
}
