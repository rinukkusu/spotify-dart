// Copyright (c) 2018 hayribakici, ebarnsli. All rights reserved. Use of this
// source code is governed by a BSD-style license that can be found in the
// LICENSE file.

part of '../../spotify.dart';

/// Endpoint of the search `v1/search`
class Search extends EndpointPaging {
  @override
  String get _path => 'v1/search';

  Search(super.api);

  /// Get Spotify Catalog information about albums, artists, playlists,
  /// tracks, shows, episodes or audiobooks that match a keyword string.
  ///
  /// [types]: Valid types are: album, artist, playlist, track, show, episode
  /// and audiobook. Search results include hits from all the specified item
  /// types.
  ///
  /// [market]: An ISO 3166-1 alpha-2 country code or the string 'from_token'.
  /// If a country code is specified, only artists, albums, and tracks with
  /// content that is playable in that market is returned.
  SearchResults get(
    String searchQuery, {
    Iterable<SearchType> types = SearchType.values,
    Market? market,
  }) {
    final type = types.map((type) => type._key).join(',');

    final query = _buildQuery({
      'q': searchQuery,
      'type': type,
      'market': market?.name,
    });

    return SearchResults(
      _api,
      '$_path?$query',
      {
        'playlists': (json) => PlaylistSimple.fromJson(json),
        'albums': (json) => AlbumSimple.fromJson(json),
        'artists': (json) => Artist.fromJson(json),
        'tracks': (json) => Track.fromJson(json),
        'shows': (json) => Show.fromJson(json),
        'episodes': (json) => Episode.fromJson(json),
        'audiobooks': (json) => AudiobookSimple.fromJson(json),
      },
      null,
      null,
      null,
      5,
      10,
    );
  }
}

/// Page that allows multiple types (artist, track, episode etc.) together
/// with additional offset constraints.
class SearchResults extends BundledPages {
  SearchResults(
    super.api,
    super.path,
    super.pageMappers, [
    super.pageKey,
    super.pageContainerParser,
    super.pageItemFilter,
    super.defaultLimit,
    super.maxLimit,
  ]);

  @override
  Future<List<Page<dynamic>>> getPage(int limit, [int offset = 0]) async {
    const maxOffsetLimit = 1000;
    const minOffsetLimit = 0;

    if (offset < minOffsetLimit || offset > maxOffsetLimit) {
      throw RangeError.range(offset, minOffsetLimit, maxOffsetLimit);
    }
    return super.getPage(limit, offset);
  }
}

/// Type for narrowing the search results
enum SearchType {
  album(key: 'album'),
  artist(key: 'artist'),
  playlist(key: 'playlist'),
  track(key: 'track'),
  show(key: 'show'),
  episode(key: 'episode'),
  audiobook(key: 'audiobook');

  const SearchType({required String key}) : _key = key;

  final String _key;
}
