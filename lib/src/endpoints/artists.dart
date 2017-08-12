part of spotify;

class Artists {
  String _path = 'v1/artists';
  SpotifyApiBase _api;

  Artists(this._api);

  Future<Artist> get(String id) async {
    var json = await _api._get('$_path/$id');
    return ArtistMapper.fromJson(json);
  }
}