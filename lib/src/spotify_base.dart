// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

abstract class SpotifyApiBase {
  final SpotifyApiCredentials _credentials;

  static const String _baseUrl = 'https://api.spotify.com';
  static const String _tokenRefreshUrl =
      'https://accounts.spotify.com/api/token';

  Artists _artists;
  Albums _albums;
  Tracks _tracks;
  AudioFeatures _audioFeatures;

  Artists get artists => _artists;
  Albums get albums => _albums;
  Tracks get tracks => _tracks;
  AudioFeatures get audioFeatures => _audioFeatures;

  SpotifyApiBase(this._credentials) {
    _artists = new Artists(this);
    _albums = new Albums(this);
    _tracks = new Tracks(this);
    _audioFeatures = new AudioFeatures(this);
  }

  Future<Null> _refreshToken() async {
    if (_credentials.tokenRequest.canRefresh &&
        (_credentials.token == null || _credentials.token.isExpired)) {
      var headers = {'Authorization': 'Basic ${_credentials.basicAuth}'};
      var body = TokenRequestMapper.map(_credentials.tokenRequest);

      var responseJson = await _postImpl(_tokenRefreshUrl, headers, body);
      _credentials.token = ApiTokenMapper.fromJson(responseJson);
    }
  }

  Future<String> _get(String path) {
    return _requestWrapper(path,
        (url, headers) => _getImpl(url, headers));
  }

  Future<String> _post(String path, String body) {
    return _requestWrapper(
        path, (url, headers) => _postImpl(url, headers, body));
  }

  Future<String> _requestWrapper(String path,
      Future<String> req(String url, Map<String, String> headers)) async {
    await _refreshToken();
    var headers = {'Authorization': 'Bearer ${_credentials.token.accessToken}'};
    var url = '${_baseUrl}/$path';

    return req(url, headers);
  }

  Future<String> _getImpl(String url, Map<String, String> headers);
  Future<String> _postImpl(
      String url, Map<String, String> headers, dynamic body);
}
