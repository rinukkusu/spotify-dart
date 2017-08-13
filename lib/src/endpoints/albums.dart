part of spotify;

class Albums {
  String _path = 'v1/albums';
  SpotifyApiBase _api;

  Albums(this._api);

  Future<Album> get(String id) async {
    var json = await _api._get('$_path/$id');
    return AlbumMapper.fromJson(json);
  }

  Future<Iterable<Album>> list(Iterable<String> ids) async {
    var json = await _api._get('$_path?ids=${ids.join(',')}');
    var map = JSON.decode(json);

    var artistsMap = map['albums'] as Iterable<Map>;
    return artistsMap.map((m) => AlbumMapper.parse(m));
  }
}