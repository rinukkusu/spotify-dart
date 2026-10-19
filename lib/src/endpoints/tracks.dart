// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../../spotify.dart';

/// Endpoint of tracks `v1/tracks`
class Tracks extends EndpointBase {
  @override
  String get _path => 'v1/tracks';

  Tracks(super.api);

  Future<Track> get(String trackId) async {
    final jsonString = await _api._get('$_path/$trackId');
    final map = json.decode(jsonString);

    return Track.fromJson(map);
  }
}
