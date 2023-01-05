// Copyright (c) 2019, chances, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Me extends EndpointPaging {
  @override
  String get _path => 'v1/me';

  Me(SpotifyApiBase api) : super(api);

  Future<User> get() async {
    final jsonString = await _api._get(_path);
    final map = json.decode(jsonString);

    return User.fromJson(map);
  }

  /// Endpoint /v1/me/following only supports "artist" type at the moment.
  /// needs 'user-follow-read' scope
  CursorPages<Artist> following(FollowingType type, [String after = '']) {
    // since 'artists' is the container, there is no
    // containerParse necessary. Adding json to make the
    // CursorPages-Object happy.
    return _getCursorPages('$_path/following?type=${type.key}',
        (json) => Artist.fromJson(json), 'artists', (json) => json);
  }

  /// Check if current user follow the provided artists. The output [bool]
  /// list is in the same order as the provided artist-id list
  Future<List<bool>> isFollowing(FollowingType type, List<String> ids) async {
    assert(ids.isNotEmpty, 'No user/artist id was provided');
    final jsonString = await _api._get(
        '$_path/following/contains?type=${type.key}&ids=${ids.join(",")}');
    final list = List.castFrom<dynamic, bool>(json.decode(jsonString));
    return list;
  }

  /// Follow provided users/artists\
  /// [type] - Type of Follow\
  /// [ids] - user/artist
  Future<void> follow(FollowingType type, List<String> ids) async {
    assert(ids.isNotEmpty, 'No user/artist id was provided');
    await _api._put("$_path/following?type=${type.key}&ids=${ids.join(",")}");
  }

  /// Unfollow already following users/artists\
  /// [type] - Type of Follow\
  /// [ids] - user/artist
  Future<void> unfollow(FollowingType type, List<String> ids) async {
    assert(ids.isNotEmpty, 'No user/artist id was provided');
    await _api
        ._delete("$_path/following?type=${type.key}&ids=${ids.join(",")}");
  }

  /// Get the object currently being played on the user’s Spotify account.
  Future<Player> currentlyPlaying() async {
    final jsonString = await _api._get('$_path/player/currently-playing');

    if (jsonString.isEmpty) {
      return Player();
    }

    final map = json.decode(jsonString);
    return Player.fromJson(map);
  }

  /// Get tracks from the current user’s recently played tracks.
  /// Note: Currently doesn’t support podcast episodes.
  CursorPages<PlayHistory> recentlyPlayed({int? limit, DateTime? after, DateTime? before}) {
    assert(after == null || before == null,
      'Cannot specify both after and before.');

    return _getCursorPages('$_path/player/recently-played?' +
        _buildQuery({
          'limit': limit,
          'after': after?.millisecondsSinceEpoch,
          'before': before?.millisecondsSinceEpoch
        }), (json) => PlayHistory.fromJson(json));
  }

  /// Get the current user's top tracks.
  /// @param limit: the maximum number of items to return. Default: 20. Minimum: 1. Maximum: 50.
  /// @param offset: The index of the first item to return. Default: 0 (the first item). Use with limit to get the next set of items.
  /// @param time_range: Over what time frame the affinities are computed (long_term, medium_term, short_term)
  /// For more information, see https://developer.spotify.com/documentation/web-api/reference/#/operations/get-users-top-artists-and-tracks
  Future<Iterable<Track>> topTracks(int limit, int offset, String timeRange) async {
    final jsonString = await _api._get('$_path/top/tracks?time_range=$timeRange&limit=$limit&offset=$offset');
    final map = json.decode(jsonString);

    final items = map['items'] as Iterable<dynamic>;
    return items.map((item) => Track.fromJson(item));
  }

  /// Get the current user's top artists.
  /// @param limit: the maximum number of items to return. Default: 20. Minimum: 1. Maximum: 50.
  /// @param offset: The index of the first item to return. Default: 0 (the first item). Use with limit to get the next set of items.
  /// @param time_range: Over what time frame the affinities are computed (long_term, medium_term, short_term)
  /// For more information See https://developer.spotify.com/documentation/web-api/reference/#/operations/get-users-top-artists-and-tracks
  Future<Iterable<Artist>> topArtists(int limit, int offset, String timeRange) async {
    final jsonString = await _api._get('$_path/top/artists?time_range=$timeRange&limit=$limit&offset=$offset');
    final map = json.decode(jsonString);

    final items = map['items'] as Iterable<dynamic>;
    return items.map((item) => Artist.fromJson(item));
  }

  /// Get information about a user’s available devices.
  Future<Iterable<Device>> devices() async {
    return _api._get('$_path/player/devices').then(_parseDeviceJson);
  }

  /// Get a list of shows saved in the current Spotify user’s library.
  Pages<Show> savedShows() {
    return _getPages('$_path/shows', (json) => Show.fromJson(json['show']));
  }

  /// gets current user's saved albums in pages
  Pages<AlbumSimple> savedAlbums() {
    return _getPages('v1/me/albums', (json) => Album.fromJson(json['album']));
  }

  /// Save albums for the current-user. It requires the
  /// `user-library-modify` scope of Spotify WebSDK\
  /// [ids] - the ids of the albums
  Future<void> saveAlbums(List<String> ids) async {
    assert(ids.isNotEmpty, 'No album ids were provided for saving');
    await _api._put('$_path/albums?ids=${ids.join(",")}');
  }

  /// Remove albums for the current-user. It requires the
  /// `user-library-modify` scope of Spotify WebSDK\
  /// [ids] - the ids of the albums
  Future<void> removeAlbums(List<String> ids) async {
    assert(ids.isNotEmpty, 'No album ids were provided for removing');
    await _api._delete('$_path/albums?ids=${ids.join(",")}');
  }

  /// Check if passed albums (ids) are saved by current user. The output
  /// [bool] list is in the same order as the provided album ids list
  Future<List<bool>> isSavedAlbums(List<String> ids) async {
    assert(ids.isNotEmpty, 'No album ids were provided for checking');
    final jsonString =
        await _api._get('$_path/albums/contains?ids=${ids.join(",")}');
    final list = List.castFrom<dynamic, bool>(json.decode(jsonString));
    return list;
  }

  Iterable<Device> _parseDeviceJson(String jsonString) {
    final map = json.decode(jsonString);

    final items = map['devices'] as Iterable<dynamic>;
    return items.map((item) => Device.fromJson(item));
  }
}

class FollowingType {
  final String _key;

  const FollowingType(this._key);

  String get key => _key;

  static const artist = FollowingType('artist');
  static const user = FollowingType('user');
}
