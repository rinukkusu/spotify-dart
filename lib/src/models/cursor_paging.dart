// Copyright (c) 2020, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable()
class CursorPaging<T> extends Paging<T> {
  CursorPaging();

  factory CursorPaging.fromJson(Map<String, dynamic> json) =>
      _$CursorPagingFromJson(json);

  Map<String, dynamic> toJson() => _$CursorPagingToJson(this);

  Cursor cursors;
}

@JsonSerializable()
class Cursor extends Object {
  factory Cursor.fromJson(Map<String, dynamic> json) => _$CursorFromJson(json);

  Map<String, dynamic> toJson() => _$CursorToJson(this);

  Cursor();
  String after;
}
