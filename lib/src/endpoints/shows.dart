// Copyright (c) 2020, deandreamatias, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Shows extends EndpointPaging {
  @override
  String get _path => 'v1/shows';

  Shows(SpotifyApiBase api) : super(api);

  /// Get a single show
  ///
  /// [market]: An ISO 3166-1 alpha-2 country code or the string 'from_token'.
  /// If a country code is specified, only artists, albums, and tracks with
  /// content that is playable in that market is returned.
  Future<Show> get(String showId, {String market = ''}) async {
    var jsonString;
    if (market.isNotEmpty) {
      var queryMap = {'market': market};
      var query = _buildQuery(queryMap);
      jsonString = await _get('$_path/$showId?$query');
    } else {
      jsonString = await _get('$_path/$showId');
    }

    var map = json.decode(jsonString);

    return Show.fromJson(map);
  }

  /// Get one or several shows
  Future<Iterable<Show>> list(List<String> showsId) async {
    final jsonString = await _get('$_path?ids=${showsId.join(',')}');
    final map = json.decode(jsonString);

    final showsMap = map['shows'] as Iterable<dynamic>;
    return showsMap.map((m) => Show.fromJson(m));
  }

  /// Get a Show's Episodes
  ///
  /// [market]: An ISO 3166-1 alpha-2 country code or the string 'from_token'.
  /// If a country code is specified, only artists, albums, and tracks with
  /// content that is playable in that market is returned.
  Pages<Episode> episodes(String showId, {String? market}) {
    var query = _buildQuery({'market': market});
    var queryString = query.isNotEmpty ? '?$query' : '';

    return _getPages('$_path/$showId/episodes$queryString',
        (json) => Episode.fromJson(json));
  }
}
