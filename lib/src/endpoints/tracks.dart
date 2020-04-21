// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Tracks extends EndpointBase {
  TracksMe _me;
  @override
  String get _path => 'v1/tracks';

  Tracks(SpotifyApiBase api) : super(api) {
    _me = TracksMe(api);
  }

  TracksMe get me => _me;

  Future<Track> get(String trackId) async {
    var jsonString = await _api._get('$_path/$trackId');
    var map = json.decode(jsonString);

    return Track.fromJson(map);
  }

  Future<Iterable<Track>> list(Iterable<String> trackIds) async {
    var jsonString = await _api._get('$_path?ids=${trackIds.join(',')}');
    var map = json.decode(jsonString);
    var artistsMap = map['tracks'] as Iterable<dynamic>;
    return artistsMap.map((m) => Track.fromJson(m));
  }

  /// queries track batches of size [queryLimit] from [trackIds] and yields Track object Iterables
  Stream<Iterable<Track>> listInBatches(Iterable<String> trackIds, [int batchSize=50]) async* {
    for (var batch in batches(trackIds, batchSize)) {
      yield await list(batch);
    }
  }

  /// queries track batches of size [queryLimit] from [trackIds] and yields the Track objects
  Stream<Track> tracksStream(Iterable<String> trackIds, [int queryLimit=50]) async* {
    await for (var batch in listInBatches(trackIds)) {
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
    var list = await contains([id]);
    return list.first;
  }

  Future<List<bool>> contains(List<String> ids) async {
    var limit = ids.length < 50 ? ids.length : 50;
    var idsParam = ids.sublist(0, limit).join(',');
    var jsonString = await _api._get('$_path/contains?ids=$idsParam');
    List<bool> list = json.decode(jsonString);
    return list;
  }

  Future<Null> saveOne(String id) {
    return save([id]);
  }

  Future<Null> save(List<String> ids) async {
    var limit = ids.length < 50 ? ids.length : 50;
    var idsParam = ids.sublist(0, limit).join(',');
    await _api._put('$_path?ids=$idsParam', '');
  }
}
