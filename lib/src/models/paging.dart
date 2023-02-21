// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

typedef ParserFunction<T> = T Function(dynamic object);

Iterable<dynamic> itemsNativeFromJson(List<dynamic> json) => json;
List<Map> itemsNativeToJson(Iterable<dynamic>? items) =>
    (items == null) ? [] : List.from(items);

class BasePaging<T> extends Object {
  BasePaging();

  /// A link to the Web API endpoint returning the full result of the request.
  String? href;

  /// The requested data
  ///
  /// Note this is the raw JSON value. Use a [Page]'s [Page.items] to get the
  /// requested data as a deserialized list.
  @JsonKey(
      name: 'items', fromJson: itemsNativeFromJson, toJson: itemsNativeToJson)
  Iterable<dynamic>? itemsNative;

  /// The maximum number of items in the response (as set in the query or by
  /// default).
  int limit = 20;

  /// URL to the next page of items. ([null] if none)
  String? next;


}

@JsonSerializable(createToJson: false)
class Paging<T> extends BasePaging<T> {
  Paging();

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);

  /// The offset of the items returned (as set in the query or by default).
  int? offset;

  /// URL to the previous page of items. (null if none)
  String? previous;

  /// The total number of items available to return.
  int total = 0;
}

@JsonSerializable(createToJson: false)
class CursorPaging<T> extends BasePaging<T> {
  CursorPaging();

  factory CursorPaging.fromJson(Map<String, dynamic> json) =>
      _$CursorPagingFromJson(json);

  Cursor? cursors;
}

@JsonSerializable(createToJson: false)
class Cursor extends Object {
  factory Cursor.fromJson(Map<String, dynamic> json) => _$CursorFromJson(json);

  Cursor();
  String? after;
}