// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Tracks extends EndpointBase {
  @override
  String get _path => 'v1/tracks';
  
  Tracks(SpotifyApiBase api) : super(api);

  Future<Track> get(String id) async {
    var json = await _api._get('$_path/$id');
    return TrackMapper.fromJson(json);
  }

  Future<Iterable<Track>> list(Iterable<String> ids) async {
    var json = await _api._get('$_path?ids=${ids.join(',')}');
    var map = JSON.decode(json);

    var artistsMap = map['tracks'] as Iterable<Map>;
    return artistsMap.map((m) => TrackMapper.parse(m));
  }
}