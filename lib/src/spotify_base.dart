// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

abstract class SpotifyApiBase {
  static const String _baseUrl = 'https://api.spotify.com';
  static const String _tokenUrl = 'https://accounts.spotify.com/api/token';
  static const String _authorizationUrl = 'https://accounts.spotify.com/authorize';


  FutureOr<http_all.BaseClient> _client;
  Artists _artists;
  Albums _albums;
  Tracks _tracks;
  Playlists _playlists;
  Users _users;
  Search _search;
  AudioFeatures _audioFeatures;
  Categories _categories;


  Artists get artists => _artists;

  Albums get albums => _albums;

  Tracks get tracks => _tracks;

  Playlists get playlists => _playlists;

  Users get users => _users;

  Search get search => _search;

  AudioFeatures get audioFeatures => _audioFeatures;
  Categories get categories => _categories;

  SpotifyApiBase.fromClient(FutureOr<http_all.BaseClient> client) {
    _client = client;
    _artists = new Artists(this);
    _albums = new Albums(this);
    _tracks = new Tracks(this);
    _playlists = new Playlists(this);
    _users = new Users(this);
    _search = new Search(this);
    _audioFeatures = new AudioFeatures(this);
    _categories = Categories(this);
  }

  SpotifyApiBase(SpotifyApiCredentials credentials,
                 [http_all.Client httpClient]):
        this.fromClient(clientCredentialsGrant(
          Uri.parse(SpotifyApiBase._tokenUrl),
          credentials.clientId, credentials.clientSecret, httpClient: httpClient));

  SpotifyApiBase.fromAuthCodeGrant(AuthorizationCodeGrant grant, String responseUri) :
      this.fromClient(grant.handleAuthorizationResponse(Uri.parse(responseUri).queryParameters));

    static AuthorizationCodeGrant authorizationCodeGrant(
      SpotifyApiCredentials credentials, http_all.BaseClient httpClient) {
    return AuthorizationCodeGrant(
        credentials.clientId,
        Uri.parse(SpotifyApiBase._authorizationUrl),
        Uri.parse(SpotifyApiBase._tokenUrl),
        secret: credentials.clientSecret,
        httpClient: httpClient);
  }

  Future<String> _get(String path) {
    return _getImpl('${_baseUrl}/$path', const {});
  }

  Future<String> _post(String path, [String body='']) {
    return _postImpl('${_baseUrl}/$path', const {}, body);
  }

  Future<String> _delete(String path, [String body='']) {
    return _deleteImpl('${_baseUrl}/$path', const {}, body);
  }

  Future<String> _put(String path, [String body='']) {
    return _putImpl('${_baseUrl}/$path', const {}, body);
  }

  Future<String> _getImpl(String url, Map<String, String> headers) async {
      final response = await (await _client).get(url, headers: headers);
      return handleErrors(response);
  }

    Future<String> _postImpl(
      String url, Map<String, String> headers, dynamic body) async {
    var response = await (await _client).post(url, headers: headers, body: body);
    return handleErrors(response);
  }

    Future<String> _deleteImpl(String url, Map<String, String> headers, body) async {
    final request = http_all.Request("DELETE", Uri.parse(url));
    request.headers.addAll(headers);
    request.body = body;
    final response = await http_all.Response.fromStream(await (await _client).send(request));
    return handleErrors(response);
  }

  Future<String> _putImpl(
      String url, Map<String, String> headers, dynamic body) async {
    var response = await (await _client).put(url, headers: headers, body: body);
    return handleErrors(response);
  }


  String handleErrors(http_all.Response response) {
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 400) {
      var jsonMap = json.decode(responseBody);
      throw new SpotifyException.fromSpotify(
        SpotifyError.fromJson(jsonMap['error']),
      );
    }
    return responseBody;
  }
}