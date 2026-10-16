// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../../spotify.dart';

/// Base class of all endpoint classes
abstract class EndpointBase {
  // ignore: unused_element
  String get _path;

  final SpotifyApiBase _api;

  EndpointBase(this._api);

  Future<String> _get(String path) => _api._get(path);

  // ignore: unused_element
  Future<String> _post(String path, String body) => _api._post(path, body);

  String _buildQuery(Map<String, dynamic> query) {
    final filteredQuery = {
      for (final MapEntry(:key, :value) in query.entries)
        if (value != null) key: value.toString(),
    };

    return Uri(queryParameters: filteredQuery).query;
  }
}
