// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

/// Endpoint for albums `v1/albums`
class Albums extends EndpointPaging {
  @override
  String get _path => 'v1/albums';

  Albums(SpotifyApiBase api) : super(api);

  /// Retrieves an album with its [albumId]
  Future<Album> get(String albumId) async {
    var jsonString = await _get('$_path/$albumId');
    var map = json.decode(jsonString);

    return Album.fromJson(map);
  }

  /// Returns album informations about a list of [albumIds]
  Future<Iterable<Album>> list(List<String> albumIds) async => _listWithIds(
      path: _path, ids: albumIds, jsonKey: 'albums', fromJson: Album.fromJson);

  /// Returns the tracks of a given [albumId]
  Pages<TrackSimple> getTracks(String albumId) {
    return _getPages(
        '$_path/$albumId/tracks', (json) => TrackSimple.fromJson(json));
  }
}
