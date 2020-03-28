// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

abstract class EndpointBase {
  // ignore: unused_element
  String get _path;

  final SpotifyApiBase _api;

  EndpointBase(this._api);

  Future<String> _get(String path) => _api._get(path);

  // ignore: unused_element
  Future<String> _post(String path, String body) => _api._post(path, body);

  String _buildQuery(Map<String, dynamic> query) {
    final filteredQuery = Map.fromIterable(
      query.keys.where((key) => query[key] != null),
      value: (key) => query[key],
    );

    return List.generate(
      filteredQuery.keys.length,
      (i) =>
          '${filteredQuery.keys.toList()[i]}=${filteredQuery.values.toList()[i]}',
    ).join('&');
  }
}
