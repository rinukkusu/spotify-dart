// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

/// Endpoint of tracks `v1/tracks`
class Tracks extends EndpointBase {
  late TracksMe _me;

  @override
  String get _path => 'v1/tracks';

  Tracks(SpotifyApiBase api) : super(api) {
    _me = TracksMe(api);
  }

  TracksMe get me => _me;

  Future<Track> get(String trackId) async {
    final jsonString = await _api._get('$_path/$trackId');
    final map = json.decode(jsonString);

    return Track.fromJson(map);
  }

  Future<Iterable<Track>> list(Iterable<String> trackIds) async {
    final jsonString = await _api._get('$_path?ids=${trackIds.join(',')}');
    final map = json.decode(jsonString);
    final artistsMap = map['tracks'] as Iterable<dynamic>;
    return artistsMap.map((m) => Track.fromJson(m));
  }

  /// queries track batches of size [queryLimit] from [trackIds] and yields Track object Iterables
  Stream<Iterable<Track>> listInBatches(Iterable<String> trackIds,
      [int batchSize = 50]) async* {
    for (final batch in batches(trackIds, batchSize)) {
      yield await list(batch);
    }
  }

  /// queries track batches of size [queryLimit] from [trackIds] and yields the Track objects
  Stream<Track> tracksStream(Iterable<String> trackIds,
      [int queryLimit = 50]) async* {
    await for (final batch in listInBatches(trackIds)) {
      yield* Stream.fromIterable(batch);
    }
  }
}

class TracksMe extends EndpointPaging {
  @override
  String get _path => 'v1/me/tracks';

  TracksMe(SpotifyApiBase api) : super(api);

  Pages<TrackSaved> get saved {
    return _getPages(_path, (json) => TrackSaved.fromJson(json));
  }

  Future<bool> containsOne(String id) async {
    final list = await containsTracks([id]);
    return list[id] ?? false;
  }

  @Deprecated('Use [containsTracks(ids)] instead')
  Future<List<bool>> contains(List<String> ids) async {
    return (await containsTracks(ids)).values.toList();
  }

  Future<Map<String, bool>> containsTracks(List<String> ids) async {
    assert(ids.isNotEmpty, 'No track ids were provided');
    final limit = ids.length < 50 ? ids.length : 50;
    final idsParam = ids.sublist(0, limit).join(',');
    final jsonString = await _api._get('$_path/contains?ids=$idsParam');
    final list = List.castFrom<dynamic, bool>(json.decode(jsonString));
    return Map.fromIterables(ids, list);
  }

  Future<void> saveOne(String id) => save([id]);

  Future<void> save(List<String> ids) async {
    assert(ids.isNotEmpty, 'No track ids were provided');
    final limit = ids.length < 50 ? ids.length : 50;
    final idsParam = ids.sublist(0, limit).join(',');
    await _api._put('$_path?ids=$idsParam', '');
  }

  Future<void> removeOne(String id) {
    return remove([id]);
  }

  Future<void> remove(List<String> ids) async {
    assert(ids.isNotEmpty, 'No track ids were provided');
    final limit = ids.length < 50 ? ids.length : 50;
    final idsParam = ids.sublist(0, limit).join(',');
    await _api._delete('$_path?ids=$idsParam');
  }
}
