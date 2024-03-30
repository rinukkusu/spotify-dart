// Copyright (c) 2020, deandreamatias, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../../spotify.dart';

/// Endpoint of shows `v1/shows`
class Shows extends EndpointPaging {
  @override
  String get _path => 'v1/shows';

  Shows(super.api);

  /// Get a single show
  ///
  /// [market]: An ISO 3166-1 alpha-2 country code or the string 'from_token'.
  /// If a country code is specified, only artists, albums, and tracks with
  /// content that is playable in that market is returned.
  Future<Show> get(String showId, {Market? market}) async {
    String jsonString;
    if (market != null) {
      var queryMap = {'market': market.name};
      var query = _buildQuery(queryMap);
      jsonString = await _get('$_path/$showId?$query');
    } else {
      jsonString = await _get('$_path/$showId');
    }

    var map = json.decode(jsonString);

    return Show.fromJson(map);
  }

  /// Get one or several shows
  Future<Iterable<Show>> list(List<String> showsId) async => _listWithIds(
      path: _path, ids: showsId, jsonKey: 'shows', fromJson: Show.fromJson);

  /// Get a Show's Episodes
  ///
  /// [market]: An ISO 3166-1 alpha-2 country code or the string 'from_token'.
  /// If a country code is specified, only artists, albums, and tracks with
  /// content that is playable in that market is returned.
  Pages<Episode> episodes(String showId, [Market? market]) {
    var query = _buildQuery({
      'market': market?.name,
    });
    var queryString = query.isNotEmpty ? '?$query' : '';

    return _getPages('$_path/$showId/episodes$queryString',
        (json) => Episode.fromJson(json));
  }
}
