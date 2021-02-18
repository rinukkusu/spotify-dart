// Copyright (c) 2020, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class CursorPaging<T> extends Paging<T> {
  CursorPaging();

  factory CursorPaging.fromJson(Map<String, dynamic> json) =>
      _$CursorPagingFromJson(json);

  Cursor cursors;
}

@JsonSerializable(createToJson: false)
class Cursor extends Object {
  factory Cursor.fromJson(Map<String, dynamic> json) => _$CursorFromJson(json);

  Cursor();
  String after;
}
