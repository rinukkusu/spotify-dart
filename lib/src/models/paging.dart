// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

typedef T ParserFunction<T>(dynamic object);

Iterable<dynamic> itemsNativeFromJson(List<dynamic> json) => json;
List<Map> itemsNativeToJson(Iterable<dynamic> items) => new List.from(items);

@JsonSerializable(createToJson: false)
class Paging<T> extends Object {
  Paging() {}
  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);

  /// A link to the Web API endpoint returning the full result of the request.
  String href;

  /// The requested data
  ///
  /// Note this is the raw JSON value. Use a [Page]'s [Page.items] to get the
  /// requested data as a deserialized list.
  @JsonKey(
      name: 'items', fromJson: itemsNativeFromJson, toJson: itemsNativeToJson)
  Iterable<dynamic> itemsNative;

  /// The maximum number of items in the response (as set in the query or by
  /// default).
  int limit;

  /// URL to the next page of items. ([null] if none)
  String next;

  /// The offset of the items returned (as set in the query or by default).
  int offset;

  /// URL to the previous page of items. (null if none)
  String previous;

  /// The total number of items available to return.
  int total;
}
