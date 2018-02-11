// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

typedef T ParserFunction<T>(Map<String, dynamic> object);

@JsonClass()
class Paging<T> {
  /// A link to the Web API endpoint returning the full result of the request.
  String href;

  /// The requested data
  ///
  /// Note this is the raw JSON value. Use a [Page]'s [Page.items] to get the
  /// requested data as a deserialized list.
  @JsonField(key: 'items', native: true)
  Iterable<Map> itemsNative;

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
