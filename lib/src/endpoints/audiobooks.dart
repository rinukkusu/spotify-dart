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
  Future<Iterable<Audiobook>> list(List<String> audiobookIds,
          {Market? market}) async =>
      _listWithIds(
          path: _path,
          ids: audiobookIds,
          jsonKey: 'audiobooks',
          fromJson: Audiobook.fromJson,
          optionalParams: {'market': market?.name});

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

    return _getPages('$_path/$audiobookId/chapters$queryString',
        (json) => ChapterSimple.fromJson(json));
  }
}

/// Endpoint for authenticated user's audiobooks `v1/me/audiobooks`
class AudiobooksMe extends EndpointPaging {
  @override
  String get _path => 'v1/me/audiobooks';

  AudiobooksMe(super.api);

  /// Get a list of the audiobooks saved in the current Spotify user's 'Your
  /// Music' library.
  ///
  /// Requires the `user-library-read` scope.
  Pages<AudiobookSaved> get saved {
    return _getPages(_path, (json) => AudiobookSaved.fromJson(json));
  }

  /// Check if one or more audiobooks are already saved in the current Spotify
  /// user's 'Your Music' library.
  ///
  /// Requires the `user-library-read` scope.
  ///
  /// [ids] : A list of the Spotify IDs for the audiobooks. Maximum: 50 IDs
  /// Returns a Map of audiobook ID to boolean indicating if the audiobook is saved
  Future<Map<String, bool>> contains(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No audiobook ids were provided');
    }
    final limit = ids.length < 50 ? ids.length : 50;
    final idsParam = ids.sublist(0, limit).join(',');
    final jsonString = await _api._get('$_path/contains?ids=$idsParam');
    final list = List.castFrom<dynamic, bool>(json.decode(jsonString));
    return Map.fromIterables(ids, list);
  }

  /// Check if a single audiobook is already saved in the current Spotify user's
  /// 'Your Music' library.
  ///
  /// Requires the `user-library-read` scope.
  ///
  /// [id] : The Spotify ID for the audiobook
  /// Returns true if the audiobook is saved, false otherwise
  Future<bool> containsOne(String id) async {
    final list = await contains([id]);
    return list[id] ?? false;
  }

  /// Save one or more audiobooks to the current user's 'Your Music' library.
  ///
  /// Requires the `user-library-modify` scope.
  ///
  /// [ids] : A list of the Spotify IDs for the audiobooks. Maximum: 50 IDs
  Future<void> save(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No audiobook ids were provided');
    }
    final limit = ids.length < 50 ? ids.length : 50;
    final idsParam = ids.sublist(0, limit).join(',');
    await _api._put('$_path?ids=$idsParam', '');
  }

  /// Save a single audiobook to the current user's 'Your Music' library.
  ///
  /// Requires the `user-library-modify` scope.
  ///
  /// [id] : The Spotify ID for the audiobook
  Future<void> saveOne(String id) => save([id]);

  /// Remove one or more audiobooks from the current user's 'Your Music' library.
  ///
  /// Requires the `user-library-modify` scope.
  ///
  /// [ids] : A list of the Spotify IDs for the audiobooks. Maximum: 50 IDs
  Future<void> remove(List<String> ids) async {
    if (ids.isEmpty) {
      throw ArgumentError('No audiobook ids were provided');
    }
    final limit = ids.length < 50 ? ids.length : 50;
    final idsParam = ids.sublist(0, limit).join(',');
    await _api._delete('$_path?ids=$idsParam');
  }

  /// Remove a single audiobook from the current user's 'Your Music' library.
  ///
  /// Requires the `user-library-modify` scope.
  ///
  /// [id] : The Spotify ID for the audiobook
  Future<void> removeOne(String id) => remove([id]);
}
