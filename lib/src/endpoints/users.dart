// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Users extends EndpointPaging {
  @override
  String get _path => 'v1/users';

  Users(SpotifyApiBase api) : super(api);

  Future<User> me() async {
    var json = await _api._get('v1/me');
    return UserMapper.fromJson(json);
  }

  Future<UserPublic> get(String userId) async {
    var json = await _api._get('$_path/$userId');
    return UserPublicMapper.fromJson(json);
  }

  Pages<PlaylistSimple> playlists(String userId) {
    return _getPages('$_path/$userId/playlists', PlaylistSimpleMapper.parse);
  }

  Future<Playlist> playlist(String userId, String playlistId) async {
    var json = await _api._get('$_path/$userId/playlists/$playlistId');
    return PlaylistMapper.fromJson(json);
  }

  Pages<PlaylistTrack> playlistTracks(String userId, String playlistId) {
    return _getPages(
        '$_path/$userId/playlists/$playlistId/tracks',
        PlaylistTrackMapper.parse
    );
  }
}
