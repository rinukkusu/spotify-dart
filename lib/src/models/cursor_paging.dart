// Copyright (c) 2020, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

typedef ParserFunction<T> = T Function(dynamic object);

Iterable<dynamic> itemsNativeFromJson(List<dynamic> json) => json;
List<Map> itemsNativeToJson(Iterable<dynamic> items) => List.from(items);

@JsonSerializable(createToJson: false)
class CursorPaging<T> extends Paging<T> {
  CursorPaging();

  factory CursorPaging.fromJson(Map<String, dynamic> json) =>
      _$CursorPagingFromJson(json);

  
  Cursor cursors;
}

class Cursor extends Object {
  Cursor();
  String after;
}
