// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Albums extends EndpointBase{
  @override
  String get _path => 'v1/albums';
  
  Albums(SpotifyApiBase api) : super(api);

  Future<Album> get(String id) async {
    var json = await _get('$_path/$id');
    return AlbumMapper.fromJson(json);
  }

  Future<Iterable<Album>> list(Iterable<String> ids) async {
    var json = await _get('$_path?ids=${ids.join(',')}');
    var map = JSON.decode(json);

    var artistsMap = map['albums'] as Iterable<Map>;
    return artistsMap.map((m) => AlbumMapper.parse(m));
  }
}