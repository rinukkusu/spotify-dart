// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

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

  /// Generic method that requests a set of [T]'s with their given [ids].
  Future<Iterable<T>> _listWithIds<T>(
      {required String path,
      required List<String> ids,
      required String jsonKey,
      required T Function(Map<String, dynamic>) fromJson,
      Map<String, dynamic>? optionalParams}) async {
    assert(ids.isNotEmpty, 'No id\'s were provided');

    // filling the params
    var params = <String, dynamic>{'ids': ids.join(',')};
    params.addAll(optionalParams ?? {});

    return _list(
        path: '$path?${_buildQuery(params)}',
        jsonKey: jsonKey,
        fromJson: fromJson);
  }

  /// Generic method that converts requested json arrays into
  /// [T] iterables with the given [toJson] function
  Future<Iterable<T>> _list<T>(
      {required String path,
      required String jsonKey,
      required T Function(Map<String, dynamic>) fromJson}) async {
    var jsonString = await _api._get(path);
    final tJson = jsonDecode(jsonString)[jsonKey] as Iterable<dynamic>;
    return tJson.map((json) => fromJson(json));
  }
}
