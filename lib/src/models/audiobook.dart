// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of an audiobook
@JsonSerializable()
class Audiobook extends AudiobookSimple {
  Audiobook();

  factory Audiobook.fromJson(Map<String, dynamic> json) => _$AudiobookFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AudiobookToJson(this);

  /// The chapters of the audiobook
  @JsonKey(fromJson: AudiobookSimple._extractChaptersFromPage)
  Iterable<ChapterSimple>? chapters;
}

/// Json representation of a simplified audiobook object
@JsonSerializable()
class AudiobookSimple extends Object {
  AudiobookSimple();

  factory AudiobookSimple.fromJson(Map<String, dynamic> json) => _$AudiobookSimpleFromJson(json);

  Map<String, dynamic> toJson() => _$AudiobookSimpleToJson(this);

  /// Helper function that unwraps the items from the paging object
  static Iterable<ChapterSimple> _extractChaptersFromPage(dynamic json) {
    if (json == null) {
      return [];
    }

    if (json is List) {
      return json.map((chapterJson) => ChapterSimple.fromJson(chapterJson));
    }

    final items = Paging.fromJson(json).itemsNative;
    return json.isEmpty || (items == null) ? [] : items.map((chapterJson) => ChapterSimple.fromJson(chapterJson));
  }

  /// The author(s) for the audiobook
  List<Author>? authors;

  /// A list of the countries in which the audiobook can be played
  @JsonKey(name: 'available_markets')
  List<Market>? availableMarkets;

  /// The copyright statements of the audiobook
  List<Copyright>? copyrights;

  /// A description of the audiobook
  String? description;

  /// A description of the audiobook with HTML tags
  @JsonKey(name: 'html_description')
  String? htmlDescription;

  /// The edition of the audiobook
  String? edition;

  /// Whether or not the audiobook has explicit content
  bool? explicit;

  /// Known external URLs for this audiobook
  @JsonKey(name: 'external_urls')
  ExternalUrls? externalUrls;

  /// A link to the Web API endpoint providing full details of the audiobook
  String? href;

  /// The Spotify ID for the audiobook
  String? id;

  /// The cover art for the audiobook in various sizes
  List<Image>? images;

  /// A list of the languages used in the audiobook,
  /// identified by their ISO 639-1 code
  List<String>? languages;

  /// The media type of the audiobook
  @JsonKey(name: 'media_type')
  String? mediaType;

  /// The name of the audiobook
  String? name;

  /// The narrator(s) for the audiobook
  List<Narrator>? narrators;

  /// The publisher of the audiobook
  String? publisher;

  /// The number of chapters in this audiobook
  @JsonKey(name: 'total_chapters', fromJson: convertToIntIfDoubleValue)
  int? totalChapters;

  /// The object type
  String? type;

  /// The Spotify URI for the audiobook
  String? uri;
}

/// Json representation of a saved audiobook
@JsonSerializable()
class AudiobookSaved extends Object {
  AudiobookSaved();

  factory AudiobookSaved.fromJson(Map<String, dynamic> json) => _$AudiobookSavedFromJson(json);

  Map<String, dynamic> toJson() => _$AudiobookSavedToJson(this);

  /// The date and time the audiobook was saved
  @JsonKey(name: 'added_at')
  DateTime? addedAt;

  /// Information about the audiobook
  Audiobook? audiobook;
}
