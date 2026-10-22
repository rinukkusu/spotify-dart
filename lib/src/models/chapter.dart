// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of a chapter with its audiobook.
@JsonSerializable()
class Chapter extends ChapterSimple {
  Chapter();

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChapterToJson(this);

  /// The audiobook to which this chapter belongs.
  AudiobookSimple? audiobook;
}

/// Json representation of a simplified chapter object.
@JsonSerializable()
class ChapterSimple extends SpokenAudioContent {
  ChapterSimple();

  factory ChapterSimple.fromJson(Map<String, dynamic> json) => _$ChapterSimpleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChapterSimpleToJson(this);

  /// The number of the chapter.
  @JsonKey(name: 'chapter_number', fromJson: convertToIntIfDoubleValue)
  int? chapterNumber;
}
