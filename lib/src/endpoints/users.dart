// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Users extends EndpointPaging {
  @override
  String get _path => 'v1/users';

  late Me _me;
  late PlayerEndpoint _player;

  Users(SpotifyApiBase api, Me me, PlayerEndpoint player) : super(api) {
    _me = me;
    _player = player;
  }

  @Deprecated('Use "SpotifyApi.me.get()"')
  Future<User> me() => _me.get();

  @Deprecated('Use "SpotifyApi.player.currentlyPlaying()"')
  Future<Player> currentlyPlaying() => _player.currentlyPlaying();

  @Deprecated('Use "SpotifyApi.me.recentlyPlayed()"')
  CursorPages<PlayHistory> recentlyPlayed() => _me.recentlyPlayed();

  @Deprecated('Use "SpotifyApi.me.topTracks()"')
  Future<Iterable<Track>> topTracks() => _me.topTracks();

  @Deprecated('Use "SpotifyApi.player.devices()"')
  Future<Iterable<Device>> devices() async => _player.devices();

  Future<UserPublic> get(String userId) async {
    var jsonString = await _api._get('$_path/$userId');
    var map = json.decode(jsonString);

    return UserPublic.fromJson(map);
  }

  Pages<PlaylistSimple> playlists(String userId) {
    return _getPages(
        '$_path/$userId/playlists', (json) => PlaylistSimple.fromJson(json));
  }

  Future<Playlist> playlist(String userId, String playlistId) async {
    var jsonString = await _api._get('$_path/$userId/playlists/$playlistId');
    var map = json.decode(jsonString);

    return Playlist.fromJson(map);
  }

  Pages<PlaylistTrack> playlistTracks(String userId, String playlistId) {
    return _getPages('$_path/$userId/playlists/$playlistId/tracks',
        (json) => PlaylistTrack.fromJson(json));
  }
}
