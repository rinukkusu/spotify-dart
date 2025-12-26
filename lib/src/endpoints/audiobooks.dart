// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../../spotify.dart';

/// Endpoint for audiobooks `v1/audiobooks`
class Audiobooks extends EndpointPaging {
  late AudiobooksMe _me;

  @override
  String get _path => 'v1/audiobooks';

  Audiobooks(SpotifyApiBase api) : super(api) {
    _me = AudiobooksMe(api);
  }

  AudiobooksMe get me => _me;

  /// Get Spotify catalog information for a single audiobook identified by its
  /// unique Spotify ID.
  ///
  /// Audiobooks are only available within the US, UK, Canada, Ireland, New
  /// Zealand and Australia markets.
  ///
  /// [audiobookId] : The Spotify ID for the audiobook
  /// [market] : An ISO 3166-1 alpha-2 country code. If a country code is
  /// specified, only content that is available in that market will be returned
  Future<Audiobook> get(String audiobookId, {Market? market}) async {
    if (audiobookId.isEmpty) {
      throw ArgumentError('No audiobook id was provided');
    }
    final queryMap = {'market': market?.name};
    final query = _buildQuery(queryMap);
    final queryString = query.isNotEmpty ? '?$query' : '';

    final jsonString = await _get('$_path/$audiobookId$queryString');
    final map = json.decode(jsonString);

    return Audiobook.fromJson(map);
  }

  /// Get Spotify catalog information for several audiobooks identified by
  /// their Spotify IDs.
  ///
  /// Audiobooks are only available within the US, UK, Canada, Ireland, New
  /// Zealand and Australia markets.
  ///
  /// [audiobookIds] : A list of the Spotify IDs for the audiobooks. Maximum: 50 IDs
  /// [market] : An ISO 3166-1 alpha-2 country code. If a country code is
  /// specified, only content that is available in that market will be returned
  Future<Iterable<Audiobook>> list(List<String> audiobookIds, {Market? market}) async => _listWithIds(
        path: _path,
        ids: audiobookIds,
        jsonKey: 'audiobooks',
        fromJson: Audiobook.fromJson,
        optionalParams: {'market': market?.name},
      );

  /// Get Spotify catalog information about an audiobook's chapters.
  ///
  /// Audiobooks are only available within the US, UK, Canada, Ireland, New
  /// Zealand and Australia markets.
  ///
  /// [audiobookId] : The Spotify ID for the audiobook
  /// [market] : An ISO 3166-1 alpha-2 country code. If a country code is
  /// specified, only content that is available in that market will be returned
  Pages<ChapterSimple> chapters(String audiobookId, {Market? market}) {
    final query = _buildQuery({'market': market?.name});
    final queryString = query.isNotEmpty ? '?$query' : '';

    return _getPages('$_path/$audiobookId/chapters$queryString', (json) => ChapterSimple.fromJson(json));
  }
}
