// Copyright (c) 2023, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

/// Endpoint of episodes `v1/episodes`
class Episodes extends EndpointBase {
  @override
  String get _path => 'v1/episodes';

  Episodes(SpotifyApiBase api) : super(api);

  Future<EpisodeFull> get(String id, [String? market]) async {
    assert(id.isNotEmpty, 'No episode id was provided');
    var jsonString =
        await _api._get('$_path/$id?' + _buildQuery({'market': market}));
    return EpisodeFull.fromJson(jsonDecode(jsonString));
  }

  Future<Iterable<EpisodeFull>> list(List<String> ids,
      [String? market]) async {
    assert(ids.isNotEmpty, 'No episode id\'s were provided');
    var jsonString = await _api._get(
        '$_path?' + _buildQuery({'ids': ids.join(','), 'market': market}));
    var episodesJson = jsonDecode(jsonString)['episodes'] as Iterable<dynamic>;
    return episodesJson.map((json) => EpisodeFull.fromJson(json));
  }
}
