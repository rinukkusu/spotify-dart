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
class AudiobookSimple extends SpotifyContent implements Explicitable {
  AudiobookSimple();

  factory AudiobookSimple.fromJson(Map<String, dynamic> json) => _$AudiobookSimpleFromJson(json);

  @override
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
  @override
  bool? explicit;

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

  /// The number of chapters in this audiobook
  @JsonKey(name: 'total_chapters', fromJson: convertToIntIfDoubleValue)
  int? totalChapters;
}

/// Json representation of an audiobook author
@JsonSerializable()
class Author {
  Author();

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  /// The name of the author
  String? name;
}

/// Json representation of an audiobook narrator
@JsonSerializable()
class Narrator {
  Narrator();

  factory Narrator.fromJson(Map<String, dynamic> json) => _$NarratorFromJson(json);

  Map<String, dynamic> toJson() => _$NarratorToJson(this);

  /// The name of the narrator
  String? name;
}
