// Copyright (c) 2019, chances, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

abstract class _MeEndpointBase extends EndpointPaging {
  @override
  String get _path => 'v1/me';

  _MeEndpointBase(SpotifyApiBase api) : super(api);
}

/// Endpoint for authenticated users `v1/me/*`
class Me extends _MeEndpointBase {
  late PlayerEndpoint _player;

  Me(SpotifyApiBase api, PlayerEndpoint player) : super(api) {
    _player = player;
  }

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
  @Deprecated('Use [spotify.player.currentlyPlaying()]')
  Future<PlaybackState> currentlyPlaying() async => _player.currentlyPlaying();

  // Get the currently playing as well as the queued objects.
  @Deprecated('Use [spotify.player.queue()]')
  Future<Queue> queue() async => _player.queue();

  // Add an object to the queue with a trackId.
  @Deprecated('Use [spotify.player.addToQueue()]')
  Future<void> addToQueue(String trackId) async => _player.addToQueue(trackId);

  /// Get tracks from the current user’s recently played tracks.
  /// Note: Currently doesn’t support podcast episodes.
  CursorPages<PlayHistory> recentlyPlayed(
      {int? limit, DateTime? after, DateTime? before}) {
    assert(after == null || before == null,
        'Cannot specify both after and before.');

    return _getCursorPages(
        '$_path/player/recently-played?' +
            _buildQuery({
              'limit': limit,
              'after': after?.millisecondsSinceEpoch,
              'before': before?.millisecondsSinceEpoch
            }),
        (json) => PlayHistory.fromJson(json));
  }

  /// Toggle Shuffle For User's Playback.
  ///
  /// Use [state] to toggle the shuffle. `true` to turn shuffle on and `false`
  /// to turn it off respectively.
  /// Returns the current player state by making another request.
  /// See [player(String market)];
  @Deprecated('Use [spotify.player.shuffle()]')
  Future<PlaybackState?> shuffle(bool state, [String? deviceId]) async =>
      _player.shuffle(state, deviceId: deviceId);

  @Deprecated('Use [spotify.player.playbackState()]')
  Future<PlaybackState> player([String? market]) async =>
      _player.playbackState(market);

  /// Get the current user's top tracks.
  Future<Iterable<Track>> topTracks() async {
    final jsonString = await _api._get('$_path/top/tracks');
    final map = json.decode(jsonString);

    final items = map['items'] as Iterable<dynamic>;
    return items.map((item) => Track.fromJson(item));
  }

  /// Get the current user's top artists.
  Future<Iterable<Artist>> topArtists() async {
    final jsonString = await _api._get('$_path/top/artists');
    final map = json.decode(jsonString);

    final items = map['items'] as Iterable<dynamic>;
    return items.map((item) => Artist.fromJson(item));
  }

  /// Get information about a user’s available devices.
  @Deprecated('Use [spotify.player.devices()]')
  Future<Iterable<Device>> devices() async => _player.devices();

  /// Get a list of shows saved in the current Spotify user’s library.
  Pages<Show> savedShows() {
    return _getPages('$_path/shows', (json) => Show.fromJson(json['show']));
  }

  /// Save shows for the current user. It requires the `user-library-modify`
  /// scope.
  /// [ids] - the ids of the shows to save
  Future<void> saveShows(List<String> ids) async {
    assert(ids.isNotEmpty, 'No show ids were provided for saving');
    await _api._put('$_path/shows?' + _buildQuery({'ids': ids.join(',')}));
  }

  /// Removes shows for the current user. It requires the `user-library-modify`
  /// scope.
  /// [ids] - the ids of the shows to remove
  /// [market] - An ISO 3166-1 alpha-2 country code. If a country code is
  /// specified, only content that is available in that market will be returned.
  Future<void> removeShows(List<String> ids, [String market = '']) async {
    assert(ids.isNotEmpty, 'No show ids were provided for removing');
    var query = _buildQuery({'ids': ids.join(','), 'market': market});
    await _api._delete('$_path/shows?' + query);
  }

  /// Check if passed albums (ids) are saved by current user.
  /// [ids] - list of id's to check
  /// Returns the list of id's mapped with the response whether it has been saved
  Future<Map<String, bool>> containsSavedShows(List<String> ids) async {
    assert(
        ids.isNotEmpty, 'No show ids were provided for checking saved shows');
    var query = _buildQuery({'ids': ids.join(',')});
    var jsonString = await _api._get('$_path/shows/contains?' + query);
    var response = List.castFrom<dynamic, bool>(jsonDecode(jsonString));

    return Map.fromIterables(ids, response);
  }

  /// gets current user's saved albums in pages
  Pages<AlbumSimple> savedAlbums() {
    return _getPages('$_path/albums', (json) => Album.fromJson(json['album']));
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
  @Deprecated('Use [containsSavedAbums(ids)]')
  Future<List<bool>> isSavedAlbums(List<String> ids) async {
    final result = await containsSavedAlbums(ids);
    return result.values.toList();
  }

  /// Check if passed albums (ids) are saved by current user.
  /// Returns the list of id's mapped with the response whether it has been saved
  Future<Map<String, bool>> containsSavedAlbums(List<String> ids) async {
    assert(ids.isNotEmpty, 'No album ids were provided for checking');
    final jsonString =
        await _api._get('$_path/albums/contains?ids=${ids.join(",")}');
    final result = List.castFrom<dynamic, bool>(json.decode(jsonString));

    return Map.fromIterables(ids, result);
  }

  /// Returns the current user's saved episodes. Requires the `user-library-read`
  /// scope.
  Pages<EpisodeFull> savedEpisodes() {
    return _getPages(
        '$_path/episodes', (json) => EpisodeFull.fromJson(json['episode']));
  }

  /// Saves episodes for the current user. Requires the `user-library-modify`
  /// scope.
  /// [ids] - the ids of the episodes
  Future<void> saveEpisodes(List<String> ids) async {
    assert(ids.isNotEmpty, 'No episode ids were provided for saving');
    await _api._put('$_path/episodes?' + _buildQuery({'ids': ids.join(',')}));
  }

  /// Removes episodes for the current user. Requires the `user-library-modify`
  /// scope.
  /// [ids] - the ids of the episodes
  Future<void> removeEpisode(List<String> ids) async {
    assert(ids.isNotEmpty, 'No episode ids were provided for removing');
    await _api
        ._delete('$_path/episodes?' + _buildQuery({'ids': ids.join(',')}));
  }

  /// Check if passed episode [ids] are saved by current user.
  /// Returns the list of id's mapped with the response whether it has been saved
  Future<Map<String, bool>> containsSavedEpisodes(List<String> ids) async {
    assert(ids.isNotEmpty, 'No episode ids were provided for checking');
    final jsonString = await _api._get(
        '$_path/episodes/contains?' + _buildQuery({'ids': ids.join(',')}));
    final result = List.castFrom<dynamic, bool>(json.decode(jsonString));

    return Map.fromIterables(ids, result);
  }
}

class FollowingType extends ExtendedEnum {
  const FollowingType(String key) : super(key);

  static const artist = FollowingType('artist');
  static const user = FollowingType('user');
}
