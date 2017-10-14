// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Playlists extends EndpointBase {
  @override
  String get _path => 'v1/browse';

  Playlists(SpotifyApiBase api) : super(api);

  Future<Iterable<Playlist>> featured() async {
    var json = await _api._get('$_path/featured-playlists');
    var map = JSON.decode(json);

    var playlistsMap = map['items'] as Iterable<Map>;
    return playlistsMap.map((m) => PlaylistMapper.parse(m));
  }

  Future<Iterable<PlaylistSimple>> me() async {
    var json = await _api._get('v1/me/playlists');
    var map = JSON.decode(json);

    var playlistsMap = map['items'] as Iterable<Map>;
    return playlistsMap.map((m) => PlaylistSimpleMapper.parse(m));
  }
}
