// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Tracks extends EndpointBase {
  TracksMe _me;
  @override
  String get _path => 'v1/tracks';

  Tracks(SpotifyApiBase api) : super(api) {
    _me = new TracksMe(api);
  }

  TracksMe get me => _me;

  Future<Track> get(String trackId) async {
    var json = await _api._get('$_path/$trackId');
    var map = JSON.decode(json);

    return Track.fromJson(map);
  }

  Future<Iterable<Track>> list(Iterable<String> trackIds) async {
    var json = await _api._get('$_path?ids=${trackIds.join(',')}');
    var map = JSON.decode(json);

    var artistsMap = map['tracks'] as Iterable<dynamic>;
    return artistsMap.map((m) => Track.fromJson(m));
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
    int limit = ids.length < 50 ? ids.length : 50;
    String idsParam = ids.sublist(0, limit).join(',');
    var json = await _api._get('$_path/contains?ids=$idsParam');
    List<bool> list = JSON.decode(json);
    return list;
  }

  Future<Null> saveOne(String id) {
    return save([id]);
  }

  Future<Null> save(List<String> ids) async {
    int limit = ids.length < 50 ? ids.length : 50;
    String idsParam = ids.sublist(0, limit).join(',');
    await _api._put('$_path?ids=$idsParam', '');
  }
}
