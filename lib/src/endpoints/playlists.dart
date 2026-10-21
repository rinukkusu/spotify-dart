// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../../spotify.dart';

/// Endpoint of playlists
class Playlists extends EndpointPaging {
  @override
  String get _path => 'v1/playlists';

  Playlists(super.api);

  Future<Playlist> get(String playlistId) async {
    return Playlist.fromJson(
      jsonDecode(await _api._get('$_path/$playlistId')),
    );
  }

  /// Returns [PlaylistTrack]s for a given [playlistId].
  Pages<PlaylistTrack> getPlaylistTracks(String playlistId) {
    // restricting the return items to `track`
    final query = _buildQuery({'additional_types': 'track'});
    return _getPages(
      '$_path/$playlistId/items?$query',
      (json) => PlaylistTrack.fromJson(json),
      null,
      null,
      (json) => json['item'] != null,
    );
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
    final url = '$_path/$playlistId';
    final json = <String, dynamic>{'name': playlistName};

    if (public != null) json['public'] = public;
    if (collaborative != null) json['collaborative'] = collaborative;
    if (description != null) json['description'] = description;

    await _api._put(url, jsonEncode(json));
  }

  /// [playlistId] - the ID of the playlist to update
  ///
  /// [imageData] - BASE64 encoded JPEG image data
  ///
  Future<void> updatePlaylistImage(String playlistId, String imageData) async {
    final url = '$_path/$playlistId/images';
    await _api._put(url, imageData);
  }

  /// Adds a track with [trackUri] (i.e spotify:track:4iV5W9uYEdYUVa79Axb7Rh)
  /// to a playlist with [playlistId]
  Future<String> addTrack(
    String trackUri,
    String playlistId, {
    int position = -1,
  }) async {
    var url = '$_path/$playlistId/items';

    if (position >= 0) {
      url = '$url?position=$position';
    }

    return _extractSnapshotID(
      await _api._post(
        url,
        jsonEncode({
          'uris': [trackUri],
        }),
      ),
    );
  }

  /// Adds a collection of [uris] (i.e each list
  /// item in the format of "spotify:track:4iV5W9uYEdYUVa79Axb7Rh") to a
  /// playlist with [playlistId]
  Future<String> addTracks(List<String> uris, String playlistId) async {
    if (playlistId.isEmpty) {
      throw ArgumentError('No playlist id was provided');
    }
    if (uris.isEmpty) {
      throw ArgumentError('No uris provided');
    }
    final url = '$_path/$playlistId/items';
    return _extractSnapshotID(await _api._post(url, jsonEncode({'uris': uris})));
  }

  /// Removes a track with [trackUri] in the playlist with [playlistId]
  ///
  /// [trackUri] - the Spotify track uri
  /// (i.e each list item in the format of
  /// "spotify:track:4iV5W9uYEdYUVa79Axb7Rh")
  ///
  /// [positions] - the positions of the tracks to remove.
  Future<String> removeTrack(
    String trackUri,
    String playlistId, [
    List<int>? positions,
  ]) async {
    if (playlistId.isEmpty) {
      throw ArgumentError('No playlist id was provided');
    }
    final url = '$_path/$playlistId/items';
    final item = <String, dynamic>{'uri': trackUri};
    if (positions != null) {
      item['positions'] = positions;
    }

    final body = jsonEncode({
      'items': [item],
    });
    return _extractSnapshotID(await _api._delete(url, body));
  }

  /// Removes multiple tracks from a playlist wish [playlistId]
  /// [trackUris] - the Spotify track uris
  /// (i.e each list item in the format of
  /// "spotify:track:4iV5W9uYEdYUVa79Axb7Rh")
  Future<String> removeTracks(List<String> trackUris, String playlistId) async {
    if (trackUris.isEmpty) {
      throw ArgumentError('No trackUris are provided');
    }
    if (playlistId.isEmpty) {
      throw ArgumentError('No playlist id was provided');
    }
    final url = '$_path/$playlistId/items';
    final items = trackUris.map((uri) => <String, dynamic>{'uri': uri}).toList();

    final body = jsonEncode({
      'items': items,
    });
    return _extractSnapshotID(await _api._delete(url, body));
  }

  /// Replaces items (tracks, episodes etc.) in a playlist with [playlistId]
  ///
  /// [uris] - the spotify ids to overwrite a playlists existing items.
  ///
  /// Returns a new `snapshotId` for the playlist.
  Future<String> replace(String playlistId, List<String> uris) async {
    if (uris.isEmpty) {
      throw ArgumentError('No uris provided');
    }
    return _replace(playlistId, uris);
  }

  /// Clears all items of [playlistId].
  ///
  /// Returns a new `snapshotId` of the playlist.
  Future<String> clear(String playlistId) => _replace(playlistId, []);

  /// internal replace method
  Future<String> _replace(String playlistId, List<String> uris) async {
    final body = jsonEncode({
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
  /// To reorder the item(s) to the end of the playlist, simply set
  /// [insertBefore] to the position after the last item.
  ///
  /// [rangeLength] is the amount of items to be reordered. Defaults to `1` if
  /// not set. The range of items to be reordered begins from the [rangeStart]
  /// position, and includes the [rangeLength] subsequent items.
  ///
  /// If [snapshotId] is `null`, the current id is used.
  ///
  /// Returns a new `snapshotId` for the playlist.
  Future<String> reorder(
    String playlistId, {
    required int rangeStart,
    required int insertBefore,
    int rangeLength = 1,
    String? snapshotId,
  }) async {
    if (rangeStart < 0) {
      throw RangeError.range(rangeStart, 0, null, 'rangeStart');
    }
    final body = <String, dynamic>{
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
    if (playlistId.isEmpty) {
      throw ArgumentError('No playlist id was provided');
    }
    final response = await _api._put('$_path/$playlistId/items', body);
    return _extractSnapshotID(response);
  }

  String _extractSnapshotID(String jsonString) => jsonDecode(jsonString)['snapshot_id'];

  /// Returns the cover images of [playlistId]
  Future<Iterable<Image>> images(String playlistId) async {
    if (playlistId.isEmpty) {
      throw ArgumentError('PlaylistId cannot be empty');
    }
    final jsonString = await _api._get('$_path/$playlistId/images');
    final items = json.decode(jsonString) as Iterable<dynamic>;
    return items.map((item) => Image.fromJson(item));
  }
}
