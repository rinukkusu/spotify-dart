// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of spotify;

abstract class SpotifyApiBase {
  final SpotifyApiCredentials _credentials;
  ApiToken _apiToken;

  static const String _baseUrl = 'https://api.spotify.com';
  static const String _tokenRefreshUrl =
      'https://accounts.spotify.com/api/token';

  Artists artists;

  String _getForecastUrl(
          double lat, double lon, String excludes, String lang, String units) =>
      '$_baseUrl/forecast/$_apiToken/$lat,$lon' +
      '?exclude=$excludes' +
      '&lang=$lang' +
      '&units=$units';

  SpotifyApiBase(this._credentials) {
    artists = new Artists(this);
  }

  Future<Null> _refreshToken() async {
    if (_apiToken == null || _apiToken.isExpired) {
      var headers = {'Authorization': 'Basic ${_credentials.basicAuth}'};
      var body = {'grant_type': 'client_credentials'};

      var responseJson = await _postImpl(_tokenRefreshUrl, headers, body);
      _apiToken = ApiTokenMapper.fromJson(responseJson);
    }
  }

  Future<String> _get(String path) async {
    await _refreshToken();
    var headers = {'Authorization': 'Bearer ${_apiToken.accessToken}'};
    var url = '${_baseUrl}/$path';
    return _getImpl(url, headers);
  }

  Future<String> _post(String path, String body) async {
    await _refreshToken();
    var headers = {'Authorization': 'Bearer ${_apiToken.accessToken}'};
    var url = '${_baseUrl}/$path';
    return _postImpl(url, headers, body);
  }

  Future<String> _getImpl(String url, Map<String, String> headers);
  Future<String> _postImpl(
      String url, Map<String, String> headers, dynamic body);
}
