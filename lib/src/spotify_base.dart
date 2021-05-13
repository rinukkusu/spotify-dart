// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

abstract class SpotifyApiBase {
  static const String _baseUrl = 'https://api.spotify.com';
  static const String _tokenUrl = 'https://accounts.spotify.com/api/token';
  static const String _authorizationUrl =
      'https://accounts.spotify.com/authorize';

  bool _shouldWait = false;
  FutureOr<oauth2.Client> _client;
  Artists _artists;
  Artists get artists => _artists;
  Albums _albums;
  Albums get albums => _albums;
  Tracks _tracks;
  Tracks get tracks => _tracks;
  Playlists _playlists;
  Playlists get playlists => _playlists;
  RecommendationsEndpoint _recommendations;
  RecommendationsEndpoint get recommendations => _recommendations;
  Users _users;
  Users get users => _users;
  Search _search;
  Search get search => _search;
  AudioFeatures _audioFeatures;
  AudioFeatures get audioFeatures => _audioFeatures;
  Categories _categories;
  Categories get categories => _categories;
  Me _me;
  Me get me => _me;
  Shows _shows;
  Shows get shows => _shows;
  oauth2.Client get client => _client;

  SpotifyApiBase.fromClient(FutureOr<http.BaseClient> client) {
    _client = client;

    _artists = Artists(this);
    _albums = Albums(this);
    _tracks = Tracks(this);
    _playlists = Playlists(this);
    _recommendations = RecommendationsEndpoint(this);
    _me = Me(this);
    _users = Users(this, _me);
    _search = Search(this);
    _audioFeatures = AudioFeatures(this);
    _categories = Categories(this);
    _shows = Shows(this);
  }

  SpotifyApiBase(SpotifyApiCredentials credentials,
      [http.BaseClient httpClient, Function(SpotifyApiCredentials) callBack])
      : this.fromClient(_getOauth2Client(credentials, httpClient, callBack));

  SpotifyApiBase.fromAuthCodeGrant(
      oauth2.AuthorizationCodeGrant grant, String responseUri)
      : this.fromClient(grant.handleAuthorizationResponse(
            Uri.parse(responseUri).queryParameters));

  static oauth2.AuthorizationCodeGrant authorizationCodeGrant(
      SpotifyApiCredentials credentials, http.BaseClient httpClient,
      [Function(SpotifyApiCredentials) callBack]) {
    if (callBack == null)
      return oauth2.AuthorizationCodeGrant(
          credentials.clientId,
          Uri.parse(SpotifyApiBase._authorizationUrl),
          Uri.parse(SpotifyApiBase._tokenUrl),
          secret: credentials.clientSecret,
          httpClient: httpClient);

    return oauth2.AuthorizationCodeGrant(
        credentials.clientId,
        Uri.parse(SpotifyApiBase._authorizationUrl),
        Uri.parse(SpotifyApiBase._tokenUrl),
        secret: credentials.clientSecret,
        httpClient: httpClient,
        onCredentialsRefreshed: (oauth2.Credentials cred) {
      SpotifyApiCredentials newCredentials = SpotifyApiCredentials(
          credentials.clientId, credentials.clientSecret,
          accessToken: cred.accessToken,
          expiration: cred.expiration,
          refreshToken: cred.refreshToken,
          scopes: cred.scopes);
      callBack(newCredentials);
    });
  }

  static FutureOr<oauth2.Client> _getOauth2Client(
      SpotifyApiCredentials credentials, http.BaseClient httpClient,
      [Function(SpotifyApiCredentials) callBack]) async {
    if (credentials.fullyQualified) {
      var oauthCredentials = credentials._toOauth2Credentials();

      if (oauthCredentials.isExpired) {
        oauthCredentials = await oauthCredentials.refresh(
          identifier: credentials.clientId,
          secret: credentials.clientSecret,
          httpClient: httpClient,
        );
      }

      return oauth2.Client(
        oauthCredentials,
        identifier: credentials.clientId,
        onCredentialsRefreshed: callBack == null
            ? null
            : (oauth2.Credentials cred) {
                SpotifyApiCredentials newCredentials = SpotifyApiCredentials(
                    credentials.clientId, credentials.clientSecret,
                    accessToken: cred.accessToken,
                    expiration: cred.expiration,
                    refreshToken: cred.refreshToken,
                    scopes: cred.scopes);
                callBack(newCredentials);
              },
        secret: credentials.clientSecret,
      );
    }

    return oauth2.clientCredentialsGrant(
      Uri.parse(SpotifyApiBase._tokenUrl),
      credentials.clientId,
      credentials.clientSecret,
      httpClient: httpClient,
    );
  }

  Future<String> _get(String path) {
    return _getImpl('${_baseUrl}/$path', const {});
  }

  Future<String> _post(String path, [String body = '']) {
    return _postImpl('${_baseUrl}/$path', const {}, body);
  }

  Future<String> _delete(String path, [String body = '']) {
    return _deleteImpl('${_baseUrl}/$path', const {}, body);
  }

  Future<String> _put(String path, [String body = '']) {
    return _putImpl('${_baseUrl}/$path', const {}, body);
  }

  Future<String> _getImpl(String url, Map<String, String> headers) async {
    return await _requestWrapper(() async =>
        await (await _client).get(Uri.parse(url), headers: headers));
  }

  Future<String> _postImpl(
      String url, Map<String, String> headers, dynamic body) async {
    return await _requestWrapper(() async => await (await _client)
        .post(Uri.parse(url), headers: headers, body: body));
  }

  Future<String> _deleteImpl(
      String url, Map<String, String> headers, body) async {
    return await _requestWrapper(() async {
      final request = http.Request('DELETE', Uri.parse(url));
      request.headers.addAll(headers);
      request.body = body;
      return await http.Response.fromStream(
          await (await _client).send(request));
    });
  }

  Future<String> _putImpl(
      String url, Map<String, String> headers, dynamic body) async {
    return await _requestWrapper(() async => await (await _client)
        .put(Uri.parse(url), headers: headers, body: body));
  }

  Future<String> _requestWrapper(Future<http.Response> Function() request,
      {retryLimit = 5}) async {
    for (var i = 0; i < retryLimit; i++) {
      while (_shouldWait) {
        await Future.delayed(Duration(milliseconds: 500));
      }
      try {
        return handleErrors(await request());
      } on ApiRateException catch (ex) {
        if (i == retryLimit - 1) rethrow;
        print(
            'Spotify API rate exceeded. waiting for ${ex.retryAfter} seconds');
        _shouldWait = true;
        unawaited(Future.delayed(Duration(seconds: ex.retryAfter))
            .then((v) => _shouldWait = false));
      }
    }
    throw SpotifyException('Could not complete request');
  }

  Future<SpotifyApiCredentials> getCredentials() async {
    return await SpotifyApiCredentials._fromClient(await _client);
  }

  String handleErrors(http.Response response) {
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 400) {
      final jsonMap = json.decode(responseBody);
      final error = SpotifyError.fromJson(jsonMap['error']);
      if (response.statusCode == 429) {
        throw ApiRateException.fromSpotify(
            error, num.parse(response.headers['retry-after']));
      }
      throw SpotifyException.fromSpotify(
        error,
      );
    }
    return responseBody;
  }
}
