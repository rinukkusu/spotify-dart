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
  Future<Iterable<Episode>> list(
    String showId, {
    String market = '',
    int offset = 0,
    int limit = 20,
  }) async {
    var queryMap = {'offset': offset.toString(), 'limit': limit.toString()};
    if (market.isNotEmpty) {
      queryMap.addAll({'market': market});
    }
    var query = _buildQuery(queryMap);
    var response = await _api._get('$_path/$showId/episodes?$query');
    var map = json.decode(response);
    var episodesMap = map['items'] as Iterable<dynamic>;

    return episodesMap.map((m) => Episode.fromJson(m));
  }
}
