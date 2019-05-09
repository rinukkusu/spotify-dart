// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Users extends EndpointPaging {
  @override
  String get _path => 'v1/users';

  Users(SpotifyApiBase api) : super(api);

  Future<User> me() async {
    var jsonString = await _api._get('v1/me');
    var map = json.decode(jsonString);

    return User.fromJson(map);
  }

  Future<Player> currentlyPlaying() async {
    var jsonString = await _api._get('v1/me/player/currently-playing');

    if (jsonString.isEmpty) {
      return new Player();
    }

    var map = json.decode(jsonString);
    return Player.fromJson(map);
  }

  Future<Iterable<Track>> recentlyPlayed() async {
    var jsonString = await _api._get('v1/me/player/recently-played');
    var map = json.decode(jsonString);

    var items = map["items"] as Iterable<dynamic>;
    return items.map((item) => Track.fromJson(item["track"]));
  }

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
