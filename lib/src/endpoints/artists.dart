// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Artists extends EndpointBase {
  @override
  String get _path => 'v1/artists';

  Artists(SpotifyApiBase api) : super(api);

  Future<Artist> get(String artistId) async {
    var jsonString = await _api._get('$_path/$artistId');
    var map = json.decode(jsonString);

    return Artist.fromJson(map);
  }

  Future<Iterable<Track>> getTopTracks(
      String artistId, String countryCode) async {
    var jsonString =
        await _api._get('$_path/$artistId/top-tracks?country=$countryCode');
    var map = json.decode(jsonString);

    var topTracks = map['tracks'] as Iterable<dynamic>;
    return topTracks.map((m) => Track.fromJson(m));
  }

  Future<Iterable<Artist>> getRelatedArtists(String artistId) async {
    var jsonString = await _api._get('$_path/$artistId/related-artists');
    var map = json.decode(jsonString);

    var relatedArtists = map['artists'] as Iterable<dynamic>;
    return relatedArtists.map((m) => Artist.fromJson(m));
  }

  Future<Iterable<Artist>> list(Iterable<String> artistIds) async {
    var jsonString = await _api._get('$_path?ids=${artistIds.join(',')}');
    var map = json.decode(jsonString);

    var artistsMap = map['artists'] as Iterable<dynamic>;
    return artistsMap.map((m) => Artist.fromJson(m));
  }

  Future<Iterable<Artist>> relatedArtists(String artistId) async {
    var jsonString = await _api._get('$_path/$artistId/related-artists');
    var map = json.decode(jsonString);

    var artistsMap = map['artists'] as Iterable<dynamic>;
    return artistsMap.map((m) => Artist.fromJson(m));
  }
}
