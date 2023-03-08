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
  /// [types]: Valid types are: album , artist, playlist, track, show and episode.
  /// Search results include hits from all the specified item types.
  ///
  /// [market]: An ISO 3166-1 alpha-2 country code or the string 'from_token'.
  /// If a country code is specified, only artists, albums, and tracks with
  /// content that is playable in that market is returned.
  BundledPages get(
    String searchQuery, {
    Iterable<SearchType> types = SearchType.all,
    String market = '',
  }) {
    var type = types.map((type) => type.key).join(',');

    var queryMap = {'q': searchQuery, 'type': type};
    if (market.isNotEmpty) {
      queryMap.addAll({'market': market});
    }

    var query = _buildQuery(queryMap);

    return _getBundledPages('$_path?$query', {
      'playlists': (json) => PlaylistSimple.fromJson(json),
      'albums': (json) => AlbumSimple.fromJson(json),
      'artists': (json) => Artist.fromJson(json),
      'tracks': (json) => Track.fromJson(json),
      'shows': (json) => Show.fromJson(json),
      'episodes': (json) => Episode.fromJson(json)
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
  static const show = SearchType('show');
  static const episode = SearchType('episode');
  static const all = [
    SearchType.album,
    SearchType.artist,
    SearchType.playlist,
    SearchType.track,
    SearchType.show,
    SearchType.episode,
    SearchType.show,
  ];
}
