// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Albums extends EndpointPaging {
  @override
  String get _path => 'v1/albums';

  Albums(SpotifyApiBase api) : super(api);

  Future<Album> get(String albumId) async {
    var json = await _get('$_path/$albumId');
    var map = JSON.decode(json);

    return Album.fromJson(map);
  }

  Future<Iterable<Album>> list(Iterable<String> albumIds) async {
    var json = await _get('$_path?ids=${albumIds.join(',')}');
    var map = JSON.decode(json);

    var artistsMap = map['albums'] as Iterable<dynamic>;
    return artistsMap.map((m) => Album.fromJson(m));
  }

  Pages<TrackSimple> getTracks(String albumId) {
    return _getPages('$_path/$albumId/tracks', (json) => TrackSimple.fromJson(json));
  }
}
