// Copyright (c) 2023, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../../spotify.dart';

/// Endpoint of episodes `v1/episodes`
class Episodes extends EndpointBase {
  @override
  String get _path => 'v1/episodes';

  Episodes(super.api);

  Future<EpisodeFull> get(String id, [Market? market]) async {
    assert(id.isNotEmpty, 'No episode id was provided');
    var jsonString =
        await _api._get('$_path/$id?${_buildQuery({'market': market?.name})}');
    return EpisodeFull.fromJson(jsonDecode(jsonString));
  }

  Future<Iterable<EpisodeFull>> list(List<String> ids,
          [Market? market]) async =>
      _listWithIds(
          path: _path,
          ids: ids,
          jsonKey: 'episodes',
          fromJson: EpisodeFull.fromJson,
          optionalParams: {'market': market?.name});
}
