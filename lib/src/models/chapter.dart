// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of a chapter
@JsonSerializable()
class Chapter extends Object implements ChapterSimple {
  Chapter();

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChapterToJson(this);

  /// The audiobook for which the chapter belongs
  AudiobookSimple? audiobook;

  /// A URL to a 30 second preview (MP3 format) of the chapter
  @JsonKey(name: 'audio_preview_url')
  @override
  String? audioPreviewUrl;

  /// A list of the countries in which the chapter can be played
  @JsonKey(name: 'available_markets')
  @override
  List<Market>? availableMarkets;

  /// The number of the chapter
  @JsonKey(name: 'chapter_number', fromJson: convertToIntIfDoubleValue)
  @override
  int? chapterNumber;

  /// A description of the chapter
  @override
  String? description;

  /// A description of the chapter with HTML tags
  @JsonKey(name: 'html_description')
  @override
  String? htmlDescription;

  /// The chapter length in milliseconds
  @JsonKey(name: 'duration_ms', fromJson: convertToIntIfDoubleValue)
  @override
  int? durationMs;

  /// The chapter length
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  Duration? get duration => Duration(milliseconds: durationMs ?? 0);

  /// Whether or not the chapter has explicit content
  @override
  bool? explicit;

  /// External URLs for this chapter
  @JsonKey(name: 'external_urls')
  @override
  ExternalUrls? externalUrls;

  /// A link to the Web API endpoint providing full details of the chapter
  @override
  String? href;

  /// The Spotify ID for the chapter
  @override
  String? id;

  /// The cover art for the chapter in various sizes
  @override
  List<Image>? images;

  /// True if the chapter is playable in the given market. Otherwise false
  @JsonKey(name: 'is_playable')
  @override
  bool? isPlayable;

  /// A list of the languages used in the chapter,
  /// identified by their ISO 639-1 code
  @override
  List<String>? languages;

  /// The name of the chapter
  @override
  String? name;

  /// The date the chapter was first released
  @JsonKey(name: 'release_date')
  @override
  String? releaseDate;

  /// The precision with which release_date value is known
  @JsonKey(name: 'release_date_precision')
  @override
  DatePrecision? releaseDatePrecision;

  /// The user's most recent position in the chapter.
  /// Set if the supplied access token is a user token and has the scope
  /// 'user-read-playback-position'
  @JsonKey(name: 'resume_point')
  @override
  ResumePoint? resumePoint;

  /// Included in the response when a content restriction is applied
  @override
  Restrictions? restrictions;

  /// The object type
  @override
  String? type;

  /// The Spotify URI for the chapter
  @override
  String? uri;
}

/// Json representation of a simplified chapter object
@JsonSerializable()
class ChapterSimple extends Object {
  ChapterSimple();

  factory ChapterSimple.fromJson(Map<String, dynamic> json) =>
      _$ChapterSimpleFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterSimpleToJson(this);

  /// A URL to a 30 second preview (MP3 format) of the chapter
  @JsonKey(name: 'audio_preview_url')
  String? audioPreviewUrl;

  /// A list of the countries in which the chapter can be played
  @JsonKey(name: 'available_markets')
  List<Market>? availableMarkets;

  /// The number of the chapter
  @JsonKey(name: 'chapter_number', fromJson: convertToIntIfDoubleValue)
  int? chapterNumber;

  /// A description of the chapter
  String? description;

  /// A description of the chapter with HTML tags
  @JsonKey(name: 'html_description')
  String? htmlDescription;

  /// The chapter length in milliseconds
  @JsonKey(name: 'duration_ms', fromJson: convertToIntIfDoubleValue)
  int? durationMs;

  /// The chapter length
  @JsonKey(includeFromJson: false, includeToJson: false)
  Duration? get duration => Duration(milliseconds: durationMs ?? 0);

  /// Whether or not the chapter has explicit content
  bool? explicit;

  /// External URLs for this chapter
  @JsonKey(name: 'external_urls')
  ExternalUrls? externalUrls;

  /// A link to the Web API endpoint providing full details of the chapter
  String? href;

  /// The Spotify ID for the chapter
  String? id;

  /// The cover art for the chapter in various sizes
  List<Image>? images;

  /// True if the chapter is playable in the given market. Otherwise false
  @JsonKey(name: 'is_playable')
  bool? isPlayable;

  /// A list of the languages used in the chapter,
  /// identified by their ISO 639-1 code
  List<String>? languages;

  /// The name of the chapter
  String? name;

  /// The date the chapter was first released
  @JsonKey(name: 'release_date')
  String? releaseDate;

  /// The precision with which release_date value is known
  @JsonKey(name: 'release_date_precision')
  DatePrecision? releaseDatePrecision;

  /// The user's most recent position in the chapter.
  /// Set if the supplied access token is a user token and has the scope
  /// 'user-read-playback-position'
  @JsonKey(name: 'resume_point')
  ResumePoint? resumePoint;

  /// Included in the response when a content restriction is applied
  Restrictions? restrictions;

  /// The object type
  String? type;

  /// The Spotify URI for the chapter
  String? uri;
}
