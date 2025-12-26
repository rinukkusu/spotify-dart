// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../../spotify.dart';

/// Endpoint of chapters `v1/chapters`
class Chapters extends EndpointBase {
  @override
  String get _path => 'v1/chapters';

  Chapters(super.api);

  /// Get Spotify catalog information for a single chapter identified by its
  /// unique Spotify ID.
  ///
  /// Chapters are only available within the US, UK, Canada, Ireland, New
  /// Zealand and Australia markets.
  ///
  /// [chapterId] : The Spotify ID for the chapter
  /// [market] : An ISO 3166-1 alpha-2 country code. If a country code is
  /// specified, only content that is available in that market will be returned
  Future<Chapter> get(String chapterId, {Market? market}) async {
    if (chapterId.isEmpty) {
      throw ArgumentError('No chapter id was provided');
    }
    final jsonString = await _api._get('$_path/$chapterId?${_buildQuery({'market': market?.name})}');
    return Chapter.fromJson(jsonDecode(jsonString));
  }

  /// Get Spotify catalog information for several chapters identified by their
  /// Spotify IDs.
  ///
  /// Chapters are only available within the US, UK, Canada, Ireland, New
  /// Zealand and Australia markets.
  ///
  /// [chapterIds] : A list of the Spotify IDs for the chapters. Maximum: 50 IDs
  /// [market] : An ISO 3166-1 alpha-2 country code. If a country code is
  /// specified, only content that is available in that market will be returned
  Future<Iterable<Chapter>> list(List<String> chapterIds, {Market? market}) async => _listWithIds(
      path: _path,
      ids: chapterIds,
      jsonKey: 'chapters',
      fromJson: Chapter.fromJson,
      optionalParams: {'market': market?.name},);
}
