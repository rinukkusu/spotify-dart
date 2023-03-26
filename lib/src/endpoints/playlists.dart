// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

/// Endpoint of playlists
class Playlists extends EndpointPaging {
  @override
  String get _path => 'v1/browse';

  Playlists(SpotifyApiBase api) : super(api);

  Future<Playlist> get(String playlistId) async {
    return Playlist.fromJson(
        jsonDecode(await _api._get('v1/playlists/$playlistId')));
  }

  /// Returns the featuerd playlists
  Pages<PlaylistSimple> get featured => _getPages(
      '$_path/featured-playlists',
      (json) => PlaylistSimple.fromJson(json),
      'playlists',
      (json) => PlaylistsFeatured.fromJson(json));

  Pages<PlaylistSimple> get me {
    return _getPages(
        'v1/me/playlists', (json) => PlaylistSimple.fromJson(json));
  }

  /// Returns a playlist of a user with [userId]
  Pages<PlaylistSimple> getUsersPlaylists(String userId,
      [int limit = defaultLimit, int offset = 0]) {
    assert(userId.isNotEmpty, 'UserId cannot be empty');
    return _getPages(
        'v1/users/$userId/playlists', (json) => PlaylistSimple.fromJson(json));
  }

  /// [playlistId] - the Spotify playlist ID
  Pages<Track> getTracksByPlaylistId(playlistId) {
    return _getPages('v1/playlists/$playlistId/tracks',
        (json) => Track.fromJson(json['track']));
  }

  /// [userId] - the Spotify user ID
  ///
  /// [playlistName] - the name of the new playlist
  ///
  /// [public] - Defaults to `true`. If `true` the playlist will be public,
  /// if `false` it will be private.
  ///
  /// [collaborative] - Defaults to `false`. If `true` the playlist will
  /// be collaborative.
  ///
  /// [description] - the description of the new playlist
  Future<Playlist> createPlaylist(String userId, String playlistName,
      {bool? public, bool? collaborative, String? description}) async {
    final url = 'v1/users/$userId/playlists';
    final json = <String, dynamic>{'name': playlistName};

    if (public != null) json['public'] = public;
    if (collaborative != null) json['collaborative'] = collaborative;
    if (description != null) json['description'] = description;

    final playlistJson = await _api._post(url, jsonEncode(json));
    return Playlist.fromJson(jsonDecode(playlistJson));
  }

  /// [playlistId] - the ID of the playlist to update
  ///
  /// [playlistName] - the new name of the playlist
  ///
  /// [public] - Defaults to `true`. If `true` the playlist will be public,
  /// if `false` it will be private.
  ///
  /// [collaborative] - Defaults to `false`. If `true` the playlist will
  /// be collaborative.
  ///
  /// [description] - the new description of the playlist
  Future<void> updatePlaylist(
    String playlistId,
    String playlistName, {
    bool? public,
    bool? collaborative,
    String? description,
  }) async {
    final url = 'v1/playlists/$playlistId';
    final json = <String, dynamic>{'name': playlistName};

    if (public != null) json['public'] = public;
    if (collaborative != null) json['collaborative'] = collaborative;
    if (description != null) json['description'] = description;

    await _api._put(url, jsonEncode(json));
  }

  /// Removes a playlist with [playlistId]
  ///
  /// Since there is actually no endpoint for removing a playlist,
  /// the spotify [documentation](https://developer.spotify.com/documentation/general/guides/working-with-playlists/#following-and-unfollowing-a-playlist)
  /// says this:
  /// > We have no endpoint for deleting a playlist in the Web API;
  /// the notion of deleting a playlist is not relevant within the Spotify’s
  /// playlist system. Even if you are the playlist’s owner and you
  /// choose to manually remove it from your own list of playlists,
  /// you are simply unfollowing it. Although this behavior may sound strange,
  /// it means that other users who are already following the playlist
  /// can keep enjoying it.
  Future<void> removePlaylist(String playlistId) async =>
      unfollowPlaylist(playlistId);

  /// [playlistId] - the ID of the playlist to update
  ///
  /// [imageData] - BASE64 encoded JPEG image data
  ///
  Future<void> updatePlaylistImage(String playlistId, String imageData) async {
    final url = 'v1/playlists/$playlistId/images';
    await _api._put(url, imageData);
  }

  /// Adds a track with [trackUri] (i.e spotify:track:4iV5W9uYEdYUVa79Axb7Rh)
  /// to a playlist with [playlistId]
  Future<void> addTrack(String trackUri, String playlistId,
      {int position = -1}) async {
    var url = 'v1/playlists/$playlistId/tracks';

    if (position >= 0) {
      url = '$url?position=$position';
    }

    await _api._post(
        url,
        jsonEncode({
          'uris': [trackUri]
        }));
  }

  /// Adds a collection of [uris] (i.e each list
  /// item in the format of "spotify:track:4iV5W9uYEdYUVa79Axb7Rh") to a
  /// playlist with [playlistId]
  Future<void> addTracks(List<String> uris, String playlistId) async {
    assert(playlistId.isNotEmpty, 'No playlist id was provided');
    assert(uris.isNotEmpty, 'No uris provided');
    final url = 'v1/playlists/$playlistId/tracks';
    await _api._post(url, jsonEncode({'uris': uris}));
  }

  /// Removes a track with [trackUri] in the playlist with [playlistId]
  ///
  /// [trackUris] - the Spotify track uris
  /// (i.e each list item in the format of "spotify:track:4iV5W9uYEdYUVa79Axb7Rh")
  Future<void> removeTrack(String trackUri, String playlistId,
      [List<int>? positions]) async {
    assert(playlistId.isNotEmpty, 'No playlist id was provided');
    final url = 'v1/playlists/$playlistId/tracks';
    final track = <String, dynamic>{'uri': trackUri};
    if (positions != null) {
      track['positions'] = positions;
    }

    final body = jsonEncode({
      'tracks': [track]
    });
    await _api._delete(url, body);
  }

  /// Removes multiple tracks from a playlist wish [playlistId]
  /// [trackUris] - the Spotify track uris
  /// (i.e each list item in the format of "spotify:track:4iV5W9uYEdYUVa79Axb7Rh")
  Future<void> removeTracks(List<String> trackUris, String playlistId) async {
    assert(trackUris.isNotEmpty, 'No trackUris are provided');
    assert(playlistId.isNotEmpty, 'No playlist id was provided');
    final url = 'v1/playlists/$playlistId/tracks';
    final tracks =
        trackUris.map((uri) => <String, dynamic>{'uri': uri}).toList();

    final body = jsonEncode({
      'tracks': tracks,
    });
    await _api._delete(url, body);
  }

  /// Replaces items (tracks, episodes etc.) in a playlist with [playlistId]
  ///
  /// [uris] - the spotify ids to overwrite a playlists existing items.
  ///
  /// Returns a new `snapshotId` for the playlist.
  Future<String> replace(String playlistId, List<String> uris) async {
    assert(uris.isNotEmpty, 'No uris provided');
    return _replace(playlistId, uris);
  }

  /// Clears all items of [playlistId].
  ///
  /// Returns a new `snapshotId` of the playlist.
  Future<String> clear(String playlistId) => _replace(playlistId, []);

  /// internal replace method
  Future<String> _replace(String playlistId, List<String> uris) async {
    var body = jsonEncode({
      'uris': uris,
    });
    return _reorderOrReplace(playlistId, body);
  }

  /// Reorders items in a playlist with [playlistId] and its
  /// optional [snapshotId] against which you want to make the changes.
  ///
  /// [rangeStart] is the position of the first item to be reordered.
  ///
  /// [insertBefore] is the position where the item(s) should be inserted.
  /// To reorder the item(s) to the end of the playlist, simply set [insertBefore]
  /// to the position after the last item.
  ///
  /// [rangeLength] is the amount of items to be reordered. Defaults to `1` if not set.
  /// The range of items to be reordered begins from the [rangeStart] position,
  /// and includes the [rangeLength] subsequent items.
  ///
  /// If [snapshotId] is `null`, the current id is used.
  ///
  /// Returns a new `snapshotId` for the playlist.
  Future<String> reorder(String playlistId,
      {required int rangeStart,
      required int insertBefore,
      int rangeLength = 1,
      String? snapshotId}) async {
    assert(rangeStart >= 0, 'rangeStart out of bounds');
    var body = <String, dynamic>{
      'range_start': rangeStart,
      'insert_before': insertBefore,
      'range_length': rangeLength,
    };
    if (snapshotId != null) {
      body['snapshot_id'] = snapshotId;
    }
    return _reorderOrReplace(playlistId, jsonEncode(body));
  }

  /// Endpoint of reordering and replacing items in a playlist depending
  /// on the request's parameters, a.k.a [body].
  ///
  /// Returns a new `snapshotId` of the playlist.
  Future<String> _reorderOrReplace(String playlistId, String body) async {
    assert(playlistId.isNotEmpty, 'No playlist id was provided');
    return await _api._put('v1/playlists/$playlistId/tracks', body);
  }

  /// [country] - a country: an ISO 3166-1 alpha-2 country code. Provide this
  /// parameter to ensure that the category exists for a particular country.
  ///
  /// [locale] - the desired language, consisting of an ISO 639-1 language code
  /// and an ISO 3166-1 alpha-2 country code, joined by an underscore. For
  /// example: es_MX, meaning "Spanish (Mexico)". Provide this parameter if you
  /// want the category strings returned in a particular language. Note that,
  /// if locale is not supplied, or if the specified language is not available,
  /// the category strings returned will be in the Spotify default language
  /// (American English).
  ///
  /// [categoryId] - the Spotify category ID for the category.
  Pages<PlaylistSimple> getByCategoryId(String categoryId,
      {String? country, String? locale}) {
    final query = _buildQuery({'country': country, 'locale': locale});

    return _getPages(
        '$_path/categories/$categoryId/playlists?$query',
        (json) => PlaylistSimple.fromJson(json),
        'playlists',
        (json) => PlaylistsFeatured.fromJson(json));
  }

  /// [playlistId] - the playlist ID
  ///
  /// [public] - Defaults to `true`. If `true` the playlist will be included
  /// in user’s public playlists, if `false` it will remain private.
  Future<void> followPlaylist(String playlistId, {bool public = true}) async {
    final url = 'v1/playlists/$playlistId/followers';
    final body = jsonEncode({'public': public});
    await _api._put(url, body);
  }

  /// unfollow a certain private/public playlist
  ///
  /// it requires `playlist-modify-public` & `playlist-modify-private`
  /// scopes
  ///
  /// [playlistId] - the playlist ID
  Future<void> unfollowPlaylist(String playlistId) async {
    final url = 'v1/playlists/$playlistId/followers';
    await _api._delete(url);
  }

  /// check if a playlist is followed by provided users
  /// [playlistId] - the playlist ID
  /// [userIds] - the ids of the users
  /// The output List of boolean maps to the order of provided userIds list
  Future<List<bool>> followedBy(String playlistId, List<String> userIds) async {
    assert(userIds.isNotEmpty, 'No user id was provided for checking');
    final jsonString = await _api._get(
      'v1/playlists/$playlistId/followers/contains?ids=${userIds.join(",")}',
    );
    final list = List.castFrom<dynamic, bool>(json.decode(jsonString));
    return list;
  }

  /// Returns the cover images of [playlistId]
  Future<Iterable<Image>> images(String playlistId) async {
    assert(playlistId.isNotEmpty, 'PlaylistId cannot be empty');
    var jsonString = await _api._get('v1/playlists/$playlistId/images');
    final items = json.decode(jsonString) as Iterable<dynamic>;
    return items.map((item) => Image.fromJson(item));
  }
}
