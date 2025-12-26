// Copyright (c) 2019, chances, rinukkusu. All rights reserved. Use of this
// source code is governed by a BSD-style license that can be found in the
// LICENSE file.

part of '../../spotify.dart';

abstract class _MeEndpointBase extends EndpointPaging {
  @override
  String get _path => 'v1/me';

  _MeEndpointBase(super.api);
}

/// Endpoint for authenticated users `v1/me/*`
class Me extends _MeEndpointBase {
  late PlayerEndpoint _player;
  late final AlbumsMe _albumsMe = AlbumsMe._(super._api);
// late final AudioBooksMe _audiobooksMe = AudioBooksMe._(super.api);
  late final EpisodesMe _episodesMe = EpisodesMe._(super._api);
  late final ShowsMe _showsMe = ShowsMe._(super._api);
  late final TracksMe _tracksMe = TracksMe._(super._api);
  // late final PlaylistsMe _playlistsMe = PlaylistsMe._(super._api);

  /// Accesses the user's shows
  ShowsMe get shows => _showsMe;

  /// Accesses the user's episodes
  EpisodesMe get episodes => _episodesMe;

  /// Accesses the user's albums
  AlbumsMe get albums => _albumsMe;

  TracksMe get tracks => _tracksMe;

  Me(super.api, PlayerEndpoint player) {
    _player = player;
  }

  Future<User> get() async {
    final jsonString = await _api._get(_path);
    final map = json.decode(jsonString);

    return User.fromJson(map);
  }

  /// Endpoint `/v1/me/following` only supports [FollowingType.artist]
  /// at the moment.
  ///
  /// Needs `user-follow-read` scope
  CursorPages<Artist> following(FollowingType type) {
    if (type != FollowingType.artist) {
      throw ArgumentError.value(
        type,
        'type',
        'Only [FollowingType.artist] supported for now. '
            'Check the spotify documentation: '
            'https://developer.spotify.com/documentation/web-api/reference/get-followed',
      );
    }
    // since 'artists' is the container, there is no
    // containerParse necessary. Adding json to make the
    // CursorPages-Object happy.
    return _getCursorPages(
      '$_path/following?type=${type._key}',
      (json) => Artist.fromJson(json),
      'artists',
      (json) => json,
    );
  }

  /// Check to see if the current user is following one or more artists or
  /// other Spotify users. The output [bool] list
  /// is in the same order as the provided artist-id list
  @Deprecated('Use [spotify.me.checkFollowing(type, ids)] instead')
  Future<List<bool>> isFollowing(FollowingType type, List<String> ids) async =>
      (await checkFollowing(type, ids)).values.toList();

  /// Check if current user follow the provided [FollowingType.artist]s or
  /// [FollowingType.user]s.
  ///
  /// Returns the list of [ids] mapped with the response whether it has been
  /// followed or not
  Future<Map<String, bool>> checkFollowing(
    FollowingType type,
    List<String> ids,
  ) async {
    if (ids.isEmpty) {
      throw ArgumentError('No user/artist id was provided');
    }

    final jsonString = await _api._get('$_path/following/contains?${_buildQuery({
          'type': type._key,
          'ids': ids.join(','),
        })}');
    final list = List.castFrom<dynamic, bool>(json.decode(jsonString));
    return Map.fromIterables(ids, list);
  }

  /// Follow provided users/artists\
  /// [type] - Type of Follow\
  /// [ids] - user/artist
  Future<void> follow(FollowingType type, List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No user/artist id was provided');
    }
    await _api._put("$_path/following?type=${type._key}&ids=${ids.join(",")}");
  }

  /// Unfollow already following users/artists\
  /// [type] - Type of Follow\
  /// [ids] - user/artist
  Future<void> unfollow(FollowingType type, List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No user/artist id was provided');
    }
    await _api._delete("$_path/following?type=${type._key}&ids=${ids.join(",")}");
  }

  /// Get the object currently being played on the user’s Spotify account.
  @Deprecated('Use [spotify.player.currentlyPlaying()] instead')
  Future<PlaybackState> currentlyPlaying() async => _player.currentlyPlaying();

  // Get the currently playing as well as the queued objects.
  @Deprecated('Use [spotify.player.queue()] instead')
  Future<Queue> queue() async => _player.queue();

  // Add an object to the queue with a trackId.
  @Deprecated('Use [spotify.player.addToQueue()]')
  Future<void> addToQueue(String trackId) async => _player.addToQueue(trackId);

  /// Get tracks from the current user's recently played tracks.
  /// Note: Currently doesn't support podcast episodes.
  CursorPages<PlayHistory> recentlyPlayed({
    int? limit,
    DateTime? after,
    DateTime? before,
  }) {
    if (after != null && before != null) {
      throw ArgumentError('Cannot specify both after and before.');
    }

    return _getCursorPages(
      '$_path/player/recently-played?${_buildQuery({
            'limit': limit,
            'after': after?.millisecondsSinceEpoch,
            'before': before?.millisecondsSinceEpoch,
          })}',
      (json) => PlayHistory.fromJson(json),
    );
  }

  /// Toggle Shuffle For User's Playback.
  ///
  /// Use [state] to toggle the shuffle. `true` to turn shuffle on and `false`
  /// to turn it off respectively.
  /// Returns the current player state by making another request.
  /// See [player];
  @Deprecated('Use [spotify.player.shuffle()]')
  Future<PlaybackState?> shuffle(bool state, [String? deviceId]) async => _player.shuffle(state, deviceId: deviceId);

  @Deprecated('Use [spotify.player.playbackState()]')
  Future<PlaybackState> player([String? market]) async => _player.playbackState(Market.values.asNameMap()[market]);

  /// Get the current user's top tracks, spanning over a [timeRange].
  /// The [timeRange]'s default is [TimeRange.mediumTerm].
  Pages<Track> topTracks({TimeRange timeRange = TimeRange.mediumTerm}) =>
      _top(_TopItemsType.tracks, (item) => Track.fromJson(item), timeRange);

  /// Get the current user's top artists, spanning over a [timeRange].
  /// The [timeRange]'s default is [TimeRange.mediumTerm].
  Pages<Artist> topArtists({TimeRange timeRange = TimeRange.mediumTerm}) =>
      _top(_TopItemsType.artists, (item) => Artist.fromJson(item), timeRange);

  Pages<T> _top<T>(
    _TopItemsType type,
    T Function(dynamic) parser,
    TimeRange range,
  ) =>
      _getPages(
        '$_path/top/${type.name}?${_buildQuery({
              'time_range': range._key,
            })}',
        parser,
      );

  /// Get information about a user’s available devices.
  @Deprecated('Use [spotify.player.devices()] instead')
  Future<Iterable<Device>> devices() async => _player.devices();

  /// Get a list of shows saved in the current Spotify user’s library.
  @Deprecated('Use [spotify.me.shows.getSaved()] instead')
  Pages<Show> savedShows() => _showsMe.saved();

  /// Save shows for the current user. It requires the `user-library-modify`
  /// scope.
  /// [ids] - the ids of the shows to save
  @Deprecated('Use [spotify.me.shows.save(ids)] instead.')
  Future<void> saveShows(List<String> ids) async => _showsMe.save(ids);

  /// Removes shows for the current user. It requires the `user-library-modify`
  /// scope.
  /// [ids] - the ids of the shows to remove
  /// [market] - An ISO 3166-1 alpha-2 country code. If a country code is
  /// specified, only content that is available in that market will be returned.
  @Deprecated('Use [spotify.me.shows.remove(ids)] instead.')
  Future<void> removeShows(List<String> ids, [Market? market]) async => _showsMe.remove(ids, market);

  /// Check if passed albums (ids) are saved by current user.
  /// [ids] - list of IDs to check
  /// Returns the list of IDs mapped with the response whether it has been saved
  @Deprecated('Use [spotify.me.shows.contains(ids)] instead.')
  Future<Map<String, bool>> containsSavedShows(List<String> ids) async => _showsMe.contains(ids);

  /// gets current user's saved albums in pages
  @Deprecated('Use [spotify.me.albums.getSaved()] instead]')
  Pages<AlbumSimple> savedAlbums() => _albumsMe.saved();

  /// Save albums for the current-user. It requires the
  /// `user-library-modify` scope of Spotify WebSDK\
  /// [ids] - the ids of the albums
  @Deprecated('Use [spotify.me.albums.save(ids)] instead')
  Future<void> saveAlbums(List<String> ids) async => _albumsMe.save(ids);

  /// Remove albums for the current-user. It requires the
  /// `user-library-modify` scope of Spotify WebSDK\
  /// [ids] - the ids of the albums
  @Deprecated('Use [spotify.me.albums.remove(ids)] instead')
  Future<void> removeAlbums(List<String> ids) async => _albumsMe.remove(ids);

  /// Check if passed albums (ids) are saved by current user. The output
  /// [bool] list is in the same order as the provided album ids list
  @Deprecated('Use [spotify.me.albums.contains(ids)]')
  Future<List<bool>> isSavedAlbums(List<String> ids) async {
    final result = await containsSavedAlbums(ids);
    return result.values.toList();
  }

  /// Check if passed albums (ids) are saved by current user.
  /// Returns the list of IDs mapped with the response whether it has been
  /// saved.
  @Deprecated('Use [spotify.me.albums.contains(ids)]')
  Future<Map<String, bool>> containsSavedAlbums(List<String> ids) async => _albumsMe.contains(ids);

  /// Returns the current user's saved episodes. Requires the
  /// `user-library-read` scope.
  @Deprecated('Use [spotify.me.getSaved()] instead')
  Pages<EpisodeFull> savedEpisodes() => _episodesMe.saved();

  /// Saves episodes for the current user. Requires the `user-library-modify`
  /// scope.
  /// [ids] - the ids of the episodes
  @Deprecated('Use [spotify.me.episodes.save(ids)] instead')
  Future<void> saveEpisodes(List<String> ids) async => _episodesMe.save(ids);

  /// Removes episodes for the current user. Requires the `user-library-modify`
  /// scope.
  /// [ids] - the ids of the episodes
  @Deprecated('Use [spotify.me.episodes.remove(ids)] instead')
  Future<void> removeEpisodes(List<String> ids) async => _episodesMe.remove(ids);

  /// Check if passed episode [ids] are saved by current user.
  /// Returns the list of IDs mapped with the response whether it has been
  /// saved.
  @Deprecated('Use [spotify.me.episodes.contains(ids)] instead')
  Future<Map<String, bool>> containsSavedEpisodes(List<String> ids) async => _episodesMe.contains(ids);
}

abstract class MeOperations<T> extends _MeEndpointBase {
  String get _errorMessage;

  MeOperations(super.api);

  Pages<T> saved();

  Future<void> save(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError(_errorMessage);
    }
    await _api._put('$_path?${_buildQuery({'ids': ids.join(',')})}');
  }

  Future<void> removeOne(String id) async => remove([id]);

  Future<void> remove(List<String> ids);

  Future<bool> containsOne(String id) async => (await contains([id]))[id] ?? false;

  Future<Map<String, bool>> contains(List<String> ids);

  Future<void> saveImpl(List<String> ids, String type) async {}
}

class ShowsMe extends MeOperations<Show> {
  @override
  String get _path => '${super._path}/shows';

  @override
  String get _errorMessage => 'No show id\'s were provided';

  ShowsMe._(super.api);

  /// Save shows for the current user. It requires the  [LibraryAuthorizationScope.modify] scope.
  /// [ids] - the ids of the shows to save
  @override
  Future<void> save(List<String> ids) async => super.save(ids);

  /// Removes shows for the current user. It requires the `user-library-modify`
  /// scope.
  /// [ids] - the ids of the shows to remove
  /// [market] - An ISO 3166-1 alpha-2 country code. If a country code is
  /// specified, only content that is available in that market will be returned.
  Future<void> remove(List<String> ids, [Market? market]) async {
    if (ids.isEmpty) {
      throw ArgumentError(_errorMessage);
    }
    final queryMap = {
      'ids': ids.join(','),
      'market': market?.name,
    };
    await _api._delete('$_path?${_buildQuery(queryMap)}');
  }

  /// Check if passed albums (ids) are saved by current user.
  /// [ids] - list of IDs to check
  /// Returns the list of IDs mapped with the response whether it has been saved
  Future<Map<String, bool>> contains(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError(_errorMessage);
    }
    final query = _buildQuery({'ids': ids.join(',')});
    final jsonString = await _api._get('$_path/contains?$query');
    final response = List.castFrom<dynamic, bool>(jsonDecode(jsonString));

    return Map.fromIterables(ids, response);
  }

  /// Get a list of shows saved in the current Spotify user’s library.
  @override
  Pages<Show> saved() => _getPages(_path, (json) => Show.fromJson(json['show']));
}

class EpisodesMe extends MeOperations<EpisodeFull> {
  @override
  String get _path => '${super._path}/episodes';

  @override
  String get _errorMessage => 'No episode id\'s were provided';

  EpisodesMe._(super.api);

  /// Returns the current user's saved episodes. Requires the
  /// `user-library-read` scope.
  @override
  Pages<EpisodeFull> saved() => _getPages(
        _path,
        (json) => EpisodeFull.fromJson(json['episode']),
      );

  /// Saves episodes for the current user. Requires the `user-library-modify`
  /// scope.
  /// [ids] - the ids of the episodes
  @override
  Future<void> save(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No episode ids were provided for saving');
    }
    await _api._put('$_path?${_buildQuery({'ids': ids.join(',')})}');
  }

  /// Removes episodes for the current user. Requires the `user-library-modify`
  /// scope.
  /// [ids] - the ids of the episodes
  @override
  Future<void> remove(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No episode ids were provided for removing');
    }
    await _api._delete('$_path?${_buildQuery({'ids': ids.join(',')})}');
  }

  /// Check if passed episode [ids] are saved by current user.
  /// Returns the list of IDs mapped with the response whether it has been
  /// saved.
  @override
  Future<Map<String, bool>> contains(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No episode ids were provided for checking');
    }
    final jsonString = await _api._get(
      '$_path/contains?${_buildQuery({'ids': ids.join(',')})}',
    );
    final result = List.castFrom<dynamic, bool>(json.decode(jsonString));

    return Map.fromIterables(ids, result);
  }
}

class AlbumsMe extends MeOperations<AlbumSimple> {
  @override
  String get _path => '${super._path}/albums';

  @override
  String get _errorMessage => 'No album id\'s were provided';

  AlbumsMe._(super.api);

  /// gets current user's saved albums in pages
  Pages<AlbumSimple> saved() {
    return _getPages(_path, (json) => Album.fromJson(json['album']));
  }

  /// Save albums for the current-user. It requires the
  /// `user-library-modify` scope of Spotify WebSDK\
  /// [ids] - the ids of the albums
  Future<void> save(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No album ids were provided for saving');
    }
    await _api._put('$_path?ids=${ids.join(",")}');
  }

  /// Remove albums for the current-user. It requires the
  /// `user-library-modify` scope of Spotify WebSDK\
  /// [ids] - the ids of the albums
  Future<void> remove(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No album ids were provided for removing');
    }
    await _api._delete('$_path?ids=${ids.join(",")}');
  }

  /// Check if passed albums (ids) are saved by current user.
  /// Returns the list of IDs mapped with the response whether it has been
  /// saved.
  Future<Map<String, bool>> contains(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No album ids were provided for checking');
    }
    final jsonString = await _api._get('$_path/contains?ids=${ids.join(",")}');
    final result = List.castFrom<dynamic, bool>(json.decode(jsonString));

    return Map.fromIterables(ids, result);
  }
}

class TracksMe extends MeOperations<TrackSaved> {
  @override
  String get _path => '${super._path}/tracks';

  @override
  String get _errorMessage => 'No show id\'s were provided';

  TracksMe._(super.api);

  @override
  Pages<TrackSaved> saved() {
    return _getPages(_path, (json) => TrackSaved.fromJson(json));
  }

  @override
  Future<bool> containsOne(String id) async {
    final list = await contains([id]);
    return list[id] ?? false;
  }

  Future<Map<String, bool>> contains(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No track ids were provided');
    }
    final limit = ids.length < 50 ? ids.length : 50;
    final idsParam = ids.sublist(0, limit).join(',');
    final jsonString = await _api._get('$_path/contains?ids=$idsParam');
    final list = List.castFrom<dynamic, bool>(json.decode(jsonString));
    return Map.fromIterables(ids, list);
  }

  Future<void> saveOne(String id) => save([id]);

  Future<void> save(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No track ids were provided');
    }
    final limit = ids.length < 50 ? ids.length : 50;
    final idsParam = ids.sublist(0, limit).join(',');
    await _api._put('$_path?ids=$idsParam', '');
  }

  Future<void> removeOne(String id) {
    return remove([id]);
  }

  Future<void> remove(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No track ids were provided');
    }
    final limit = ids.length < 50 ? ids.length : 50;
    final idsParam = ids.sublist(0, limit).join(',');
    await _api._delete('$_path?ids=$idsParam');
  }
}

/// Endpoint for authenticated user's audiobooks `v1/me/audiobooks`
class AudiobooksMe extends _MeEndpointBase {
  @override
  String get _path => 'v1/me/audiobooks';

  AudiobooksMe(super.api);

  /// Get a list of the audiobooks saved in the current Spotify user's 'Your
  /// Music' library.
  ///
  /// Requires the `user-library-read` scope.
  Pages<AudiobookSaved> get saved {
    return _getPages(_path, (json) => AudiobookSaved.fromJson(json));
  }

  /// Check if one or more audiobooks are already saved in the current Spotify
  /// user's 'Your Music' library.
  ///
  /// Requires the `user-library-read` scope.
  ///
  /// [ids] : A list of the Spotify IDs for the audiobooks. Maximum: 50 IDs
  /// Returns a Map of audiobook ID to boolean indicating if the audiobook is saved
  Future<Map<String, bool>> contains(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No audiobook ids were provided');
    }
    if (ids.length > 50) {
      throw RangeError.range(ids.length, 0, 50, 'ids', 'Maximum of 50 audiobook IDs allowed per request');
    }
    final idsParam = ids.join(',');
    final jsonString = await _api._get('$_path/contains?ids=$idsParam');
    final list = List.castFrom<dynamic, bool>(json.decode(jsonString));
    return Map.fromIterables(ids, list);
  }

  /// Check if a single audiobook is already saved in the current Spotify user's
  /// 'Your Music' library.
  ///
  /// Requires the `user-library-read` scope.
  ///
  /// [id] : The Spotify ID for the audiobook
  /// Returns true if the audiobook is saved, false otherwise
  Future<bool> containsOne(String id) async {
    final list = await contains([id]);
    return list[id] ?? false;
  }

  /// Save one or more audiobooks to the current user's 'Your Music' library.
  ///
  /// Requires the `user-library-modify` scope.
  ///
  /// [ids] : A list of the Spotify IDs for the audiobooks. Maximum: 50 IDs
  Future<void> save(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No audiobook ids were provided');
    }
    if (ids.length > 50) {
      throw RangeError.range(ids.length, 0, 50, 'ids', 'Maximum of 50 audiobook IDs allowed per request');
    }
    final idsParam = ids.join(',');
    await _api._put('$_path?ids=$idsParam', '');
  }

  /// Save a single audiobook to the current user's 'Your Music' library.
  ///
  /// Requires the `user-library-modify` scope.
  ///
  /// [id] : The Spotify ID for the audiobook
  Future<void> saveOne(String id) => save([id]);

  /// Remove one or more audiobooks from the current user's 'Your Music' library.
  ///
  /// Requires the `user-library-modify` scope.
  ///
  /// [ids] : A list of the Spotify IDs for the audiobooks. Maximum: 50 IDs
  Future<void> remove(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No audiobook ids were provided');
    }
    if (ids.length > 50) {
      throw RangeError.range(ids.length, 0, 50, 'ids', 'Maximum of 50 audiobook IDs allowed per request');
    }
    final idsParam = ids.join(',');
    await _api._delete('$_path?ids=$idsParam');
  }

  /// Remove a single audiobook from the current user's 'Your Music' library.
  ///
  /// Requires the `user-library-modify` scope.
  ///
  /// [id] : The Spotify ID for the audiobook
  Future<void> removeOne(String id) => remove([id]);
}

enum FollowingType {
  artist(key: 'artist'),
  user(key: 'user');

  const FollowingType({required String key}) : _key = key;

  final String _key;
}

enum TimeRange {
  /// Consists of several years of data and including all new data as it becomes
  /// available.
  longTerm(key: 'long_term'),

  /// Consists of approximately last 6 months
  mediumTerm(key: 'medium_term'),

  /// Consists of approximately last 4 weeks
  shortTerm(key: 'short_term');

  const TimeRange({required String key}) : _key = key;

  final String _key;
}

enum _TopItemsType { artists, tracks }
