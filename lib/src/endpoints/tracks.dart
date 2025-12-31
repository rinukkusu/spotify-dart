// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../../spotify.dart';

/// Endpoint of tracks `v1/tracks`
class Tracks extends EndpointBase {
  late TracksMe _me;

  @override
  String get _path => 'v1/tracks';

  Tracks(super.api, Me me) {
    _me = me.tracks;
  }

  @Deprecated('Use [spotify.me.tracks] instead')
  TracksMe get me => _me;

  Future<Track> get(String trackId) async {
    final jsonString = await _api._get('$_path/$trackId');
    final map = json.decode(jsonString);

    return Track.fromJson(map);
  }

  Future<Iterable<Track>> list(List<String> trackIds) async => _listWithIds(
        path: _path,
        ids: trackIds,
        jsonKey: 'tracks',
        fromJson: Track.fromJson,
      );

  /// queries track batches of size [queryLimit] from [trackIds] and yields
  /// [Track] object [Iterable].
  Stream<Iterable<Track>> listInBatches(
    Iterable<String> trackIds, [
    int batchSize = 50,
  ]) async* {
    for (final batch in batches(trackIds, batchSize)) {
      yield await list(batch);
    }
  }

  /// queries track batches of size [queryLimit] from [trackIds] and yields the
  /// [Track] objects
  Stream<Track> tracksStream(
    Iterable<String> trackIds, [
    int queryLimit = 50,
  ]) async* {
    await for (final batch in listInBatches(trackIds)) {
      yield* Stream.fromIterable(batch);
    }
  }
}
