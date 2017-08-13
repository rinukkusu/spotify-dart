// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Artists extends EndpointBase {
  @override
  String get _path => 'v1/albums';
  
  Artists(SpotifyApiBase api) : super(api);

  Future<Artist> get(String id) async {
    var json = await _api._get('$_path/$id');
    return ArtistMapper.fromJson(json);
  }

  Future<Iterable<Artist>> list(Iterable<String> ids) async {
    var json = await _api._get('$_path?ids=${ids.join(',')}');
    var map = JSON.decode(json);

    var artistsMap = map['artists'] as Iterable<Map>;
    return artistsMap.map((m) => ArtistMapper.parse(m));
  }
}