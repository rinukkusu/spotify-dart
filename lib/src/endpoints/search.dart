// Copyright (c) 2018 hayribakici, ebarnsli. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Search extends EndpointPaging {
  @override
  String get _path => 'v1/search';

  Search(SpotifyApiBase api) : super(api);

  /// Get Spotify Catalog information about albums, artists, playlists, 
  /// tracks, shows or episodes that match a keyword string.
  /// 
  /// [market]: An ISO 3166-1 alpha-2 country code or the string 'from_token'.
  /// If a country code is specified, only artists, albums, and tracks with 
  /// content that is playable in that market is returned. 
  BundledPages get(String searchQuery,
      [Iterable<SearchType> types = SearchType.all, String market = '']) {
    var type = types.map((type) => type.key).join(',');

    var queryMap = {
      'q': searchQuery,
      'type': type
    };
    if (market?.isNotEmpty == true) {
      queryMap.addAll({'market': market});
    }

    var query = _buildQuery(queryMap);

    return _getBundledPages('$_path?$query', {
      'playlists': (json) => PlaylistSimple.fromJson(json),
      'albums': (json) => AlbumSimple.fromJson(json),
      'artists': (json) => Artist.fromJson(json),
      'tracks': (json) => Track.fromJson(json)
    });
  }
}

class SearchType {
  final String _key;

  const SearchType(this._key);
  String get key => _key;

  static const album = SearchType('album');
  static const artist = SearchType('artist');
  static const playlist = SearchType('playlist');
  static const track = SearchType('track');
  static const all = [
    SearchType.album,
    SearchType.artist,
    SearchType.playlist,
    SearchType.track
  ];
}
