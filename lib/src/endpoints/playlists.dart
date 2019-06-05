// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Playlists extends EndpointPaging {
  @override
  String get _path => 'v1/browse';

  Playlists(SpotifyApiBase api) : super(api);

  Pages<PlaylistSimple> get featured {
    return _getPages(
        '$_path/featured-playlists',
        (json) => PlaylistSimple.fromJson(json),
        'playlists',
        (json) => PlaylistsFeatured.fromJson(json));
  }

  Pages<PlaylistSimple> get me {
    return _getPages('v1/me/playlists', (json) => Playlist.fromJson(json));
  }

  /// [playlistId] - the Spotify playlist ID
  Pages<TrackSimple> getTracksByPlaylistId(playlistId) {
    return _getPages('v1/playlists/$playlistId/tracks',
        (json) => TrackSimple.fromJson(json['track']));
  }

  /// [country] - a country: an ISO 3166-1 alpha-2 country code. Provide this
  /// parameter to ensure that the category exists for a particular country.
  ///
  /// [locale] - the desired language, consisting of an ISO 639-1 language code
  /// and an ISO 3166-1 alpha-2 country code, joined by an underscore. For
  /// example: es_MX, meaning "Spanish (Mexico)". Provide this parameter if you
  /// want the category strings returned in a particular language. Note that,
  /// if locale is not supplied, or if the specified language is not available,
  /// the category strings returned will be in the Spotify default language
  /// (American English).
  ///
  /// [categoryId] - the Spotify category ID for the category.
  Pages<PlaylistSimple> getByCategoryId(String categoryId,
      {String country, String locale}) {
    final String query = _buildQuery({'country': country, 'locale': locale});

    return _getPages(
        '$_path/categories/$categoryId/playlists?$query',
        (json) => PlaylistSimple.fromJson(json),
        'playlists',
        (json) => PlaylistsFeatured.fromJson(json));
  }
}
