// Copyright (c) 2018 hayribakici, ebarnsli. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

/// Endpoint of the search `v1/search`
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
    Iterable<SearchType> types = SearchType.values,
    Market? market,
  }) {
    var type = types.map((type) => type._key).join(',');

    var query = _buildQuery({
      'q': searchQuery,
      'type': type,
      'market': market?.name,
    });

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

/// Type for narrowing the search results
enum SearchType {
  album(key: 'album'),
  artist(key: 'artist'),
  playlist(key: 'playlist'),
  track(key: 'track'),
  show(key: 'show'),
  episode(key: 'episode');

  const SearchType({required String key}) : _key = key;

  final String _key;
}
