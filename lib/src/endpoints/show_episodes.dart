// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class ShowEpisodes extends EndpointPaging {
  @override
  String get _path => 'v1/shows';

  ShowEpisodes(SpotifyApiBase api) : super(api);

  /// Get a Show's Episodes
  ///
  /// [offset]: Optional. The index of the first episode to return.
  /// Default: 0 (the first object). Use with limit to get the next set of episodes.
  ///
  /// [limit]: Optional. The maximum number of episodes to return.
  /// Default: 20. Minimum: 1. Maximum: 50.
  ///
  /// [market]: An ISO 3166-1 alpha-2 country code or the string 'from_token'.
  /// If a country code is specified, only artists, albums, and tracks with
  /// content that is playable in that market is returned.
  Pages<Episode> list(
    String showId, {
    String market = '',
    int offset = 0,
    int limit = 20,
  }) {
    var queryMap = {
      'market': market,
      'offset': offset.toString(),
      'limit': limit.toString()
    };
    var query = _buildQuery(queryMap);
    var queryString = query.isNotEmpty ? '?$query' : '';

    return _getPages('$_path/$showId/episodes$queryString',
        (json) => Episode.fromJson(json));
  }
}
