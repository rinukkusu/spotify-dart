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
  late final AlbumsMe _albumsMe = AlbumsMe._(super._api);
  late final AudiobooksMe _audiobooksMe = AudiobooksMe._(super._api);
  late final EpisodesMe _episodesMe = EpisodesMe._(super._api);
  late final ShowsMe _showsMe = ShowsMe._(super._api);
  late final TracksMe _tracksMe = TracksMe._(super._api);
  late final PlaylistsMe _playlistsMe = PlaylistsMe._(super._api);
  late final LibraryMe _libraryMe = LibraryMe(super._api);

  /// Accesses the user's audiobooks.
  AudiobooksMe get audiobooks => _audiobooksMe;

  /// Accesses the user's shows.
  ShowsMe get shows => _showsMe;

  /// Accesses the user's episodes.
  EpisodesMe get episodes => _episodesMe;

  /// Accesses the user's albums.
  AlbumsMe get albums => _albumsMe;

  /// Accesses the user's tracks.
  TracksMe get tracks => _tracksMe;

  /// Accesses the user's playlists.
  PlaylistsMe get playlists => _playlistsMe;

  LibraryMe get library => _libraryMe;

  Me(super.api);

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
}

abstract class _SavedMe<T> extends _MeEndpointBase {
  _SavedMe(super.api);

  /// Returns the saved content for the current user.
  ///
  /// Requires [LibraryAuthorizationScope.read] scope.
  Pages<T> saved();

  Pages<T> _savedImpl(ParserFunction<T> pageItemParser, [Market? market]) => _getPages(
        "$_path?$_buildQuery({'market' : $market})",
        pageItemParser,
      );
}

///
class LibraryMe extends _MeEndpointBase {
  @override
  String get _path => '${super._path}/library';

  String get _errorMessage => 'No uri\'s were provided';

  int get _idSizeConstraint => 50;

  LibraryMe(super.api);

  /// Save this content with given [uri] for the current user.
  ///
  /// Requires the [LibraryAuthorizationScope.modify] scope.
  Future<void> saveOne(SpotifyUri uri) async => save([uri]);

  /// Save this content with given [uris] for the current user.
  ///
  /// Requires the [LibraryAuthorizationScope.modify] scope.
  ///
  /// **Note:** Only the 50 [uris] are allowed, otherwise throws [RangeError].
  Future<void> save(List<SpotifyUri> uris) async {
    _ensureListContainsElements(uris);
    _ensureListWithinSizeContrants(uris, 'uris');
    await _api._put('$_path?${_buildQuery({'uris': uris.join(',')})}');
  }

  /// Check if the passed [uri] are saved by current user.
  /// Returns `true` or `false` whether the content has been saved.
  ///
  /// Requires [LibraryAuthorizationScope.read] scope.
  Future<bool> containsOne(SpotifyUri uri) async => (await contains([uri]))[uri] ?? false;

  /// Check if passed [uris] are saved by current user.
  /// Returns the same list of [uris] mapped with the response whether it has been saved or not.
  ///
  /// Requires [LibraryAuthorizationScope.read] scope.
  /// **Note:** Only the 50 [uris] are allowed, otherwise throws [RangeError].
  Future<Map<SpotifyUri, bool>> contains(List<SpotifyUri> uris) async {
    _ensureListContainsElements(uris);
    _ensureListWithinSizeContrants(uris, 'uris');
    final query = _buildQuery({'uris': uris.join(',')});
    final jsonString = await _api._get('$_path/contains?$query');
    final response = List.castFrom<dynamic, bool>(jsonDecode(jsonString));

    return Map.fromIterables(uris, response);
  }

  /// Removes content with given [uri] for the current user.
  ///
  /// Requires the [LibraryAuthorizationScope.modify] scope.
  Future<void> removeOne(SpotifyUri uri, [Market? market]) async => remove([uri]);

  /// Removes content with given list of [uri] for the current user.
  ///
  /// Requires the [LibraryAuthorizationScope.modify] scope.
  Future<void> remove(List<SpotifyUri> uris) async {
    _ensureListContainsElements(uris);
    _ensureListWithinSizeContrants(uris, 'uris');
    _ensureValidUris(uris);
    await _api._delete('$_path?${_buildQuery({'uris': uris.join(',')})}');
  }

  void _ensureListContainsElements<T>(List<T> elements) {
    if (elements.isEmpty) {
      throw ArgumentError(_errorMessage);
    }
  }

  void _ensureListWithinSizeContrants<T>(List<T> elements, String name) {
    if (elements.length > _idSizeConstraint) {
      throw RangeError.range(
        elements.length,
        0,
        _idSizeConstraint,
        name,
        'Maximum of $_idSizeConstraint Uri\'s allowed per request',
      );
    }
  }

  void _ensureValidUris(List<SpotifyUri> uris) {
    final valid = uris.map((uri) => isValidUri(uri)).reduce((b1, b2) => b1 && b2);
    if (!valid) {
      throw ArgumentError('Invalid uris found');
    }
  }
}

/// Endpoint for authenticated user's shows `v1/me/shows`
class ShowsMe extends _SavedMe<Show> {
  ShowsMe._(super.api);

  @override
  String get _path => '${super._path}/shows';

  /// gets current user's shows albums in [Pages]
  @override
  Pages<Show> saved() => _savedImpl((json) => Show.fromJson(json['show']));
}

/// Endpoint for authenticated user's episodes `v1/me/episodes`
class EpisodesMe extends _SavedMe<EpisodeFull> {
  @override
  String get _path => '${super._path}/episodes';

  EpisodesMe._(super.api);

  /// Returns the current user's saved episodes.
  ///
  /// Requires the [LibraryAuthorizationScope.read] scope.
  @override
  Pages<EpisodeFull> saved([Market? market]) => _savedImpl(
        (json) => EpisodeFull.fromJson(json['episode']),
        market,
      );
}

/// Endpoint for authenticated user's albums `v1/me/albums`
class AlbumsMe extends _SavedMe<AlbumSimple> {
  @override
  String get _path => '${super._path}/albums';

  AlbumsMe._(super.api);

  /// gets current user's saved albums in [Pages]
  @override
  Pages<AlbumSimple> saved([Market? market]) => _savedImpl(
        (json) => Album.fromJson(json['album']),
        market,
      );
}

/// Endpoint for authenticated user's tracks `v1/me/tracks`
class TracksMe extends _SavedMe<TrackSaved> {
  @override
  String get _path => '${super._path}/tracks';

  TracksMe._(super.api);

  /// gets current user's saved tracks in [Pages]
  @override
  Pages<TrackSaved> saved([Market? market]) => _savedImpl(
        (json) => TrackSaved.fromJson(json),
        market,
      );
}

/// Endpoint for authenticated user's audiobooks `v1/me/audiobooks`
class AudiobooksMe extends _SavedMe<AudiobookSaved> {
  @override
  String get _path => '${super._path}/audiobooks';

  AudiobooksMe._(super.api);

  /// Get a list of the audiobooks saved in the current Spotify user's 'Your
  /// Music' library.
  ///
  /// Requires the [LibraryAuthorizationScope.read] scope.
  @override
  Pages<AudiobookSaved> saved() => _savedImpl((json) => AudiobookSaved.fromJson(json));
}

/// Endpoint for authenticated user's playlists `v1/me/playlists`
class PlaylistsMe extends _SavedMe<PlaylistSimple> {
  PlaylistsMe._(super.api);

  @override
  String get _path => '${super._path}/playlists';

  /// Returns the saved content for the current user.
  ///
  /// Requires [PlaylistAuthorizationScope.readPrivate] scope.
  @override
  Pages<PlaylistSimple> saved() => _savedImpl((json) => PlaylistSimple.fromJson(json));

  /// Create a playlist for the current Spotify user.
  ///
  /// The playlist will be empty until you add tracks to it.
  /// Each user is generally limited to a maximum of 11000 playlists.
  ///
  /// [name] - The name for the new playlist.
  ///
  /// [public] - Defaults to `true`. If `true` the playlist will be public,
  /// if `false` the playlist will be private.
  ///
  /// [collaborative] - Defaults to `false`. If `true` the playlist will be
  /// collaborative. Note: to create a collaborative playlist you must also
  /// set [public] to `false`.
  ///
  /// [description] - The playlist description as displayed in Spotify Clients.
  ///
  /// Requires [PlaylistAuthorizationScope.modifyPublic] and/or
  /// [PlaylistAuthorizationScope.modifyPrivate] scope.
  Future<Playlist> create(
    String name, {
    bool? public,
    bool? collaborative,
    String? description,
  }) async {
    final body = <String, dynamic>{'name': name};
    if (public != null) body['public'] = public;
    if (collaborative != null) body['collaborative'] = collaborative;
    if (description != null) body['description'] = description;

    final response = await _api._post(_path, jsonEncode(body));
    return Playlist.fromJson(jsonDecode(response));
  }
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
