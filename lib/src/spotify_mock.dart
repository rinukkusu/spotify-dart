part of spotify;

class SpotifyApiMock extends SpotifyApiBase {
  SpotifyApiMock(SpotifyApiCredentials credentials)
      : super.fromClient(MockClient(credentials));

  MockHttpError _mockHttpError;

  MockHttpError get mockHttpError => _mockHttpError;

  set mockHttpError(MockHttpError value) => _mockHttpError = value;
}

class MockClient implements oauth2.Client {
  MockClient(SpotifyApiCredentials credentials, {MockHttpError mockHttpError}) {
    identifier = credentials.clientId;
    secret = credentials.clientSecret;
    _mockHttpError = mockHttpError;
  }

  @override
  String identifier;

  @override
  String secret;

  MockHttpError _mockHttpError;

  String _readPath(String url) {
    var regexString = url.contains('api.spotify.com')
        ? r'api.spotify.com\/([A-Za-z0-9/]+)\??'
        : r'api/([A-Za-z0-9/]+)\??';

    var regex = RegExp(regexString);
    var partialPath = regex.firstMatch(url).group(1);
    var file = File('test/data/$partialPath.json');

    return file.readAsStringSync();
  }

  @override
  void close() {
    throw 'Not implemented';
  }

  @override
  Future<http.Response> delete(url, {Map<String, String> headers}) {
    throw 'Not implemented';
  }

  @override
  Future<http.Response> get(url, {Map<String, String> headers}) async {
    if (_mockHttpError != null) {
      return createErrorResponse(_mockHttpError);
    }
    return createSuccessResponse(_readPath(url));
  }

  @override
  Future<http.Response> head(url, {Map<String, String> headers}) {
    throw 'Not implemented';
  }

  @override
  Future<http.Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    throw 'Not implemented';
  }

  @override
  Future<http.Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    if (_mockHttpError != null) {
      return createErrorResponse(_mockHttpError);
    }
    return createSuccessResponse(_readPath(url));
  }

  @override
  Future<http.Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    throw 'Not implemented';
  }

  @override
  Future<String> read(url, {Map<String, String> headers}) {
    throw 'Not implemented';
  }

  @override
  Future<Uint8List> readBytes(url, {Map<String, String> headers}) {
    throw 'Not implemented';
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw 'Not implemented';
  }

  @override
  oauth2.Credentials get credentials => oauth2.Credentials(
        'accessToken',
        refreshToken: 'refreshToken',
        tokenEndpoint: Uri.parse('tokenEndpoint.com'),
        scopes: ['scope1', 'scope2'],
        expiration: DateTime.fromMillisecondsSinceEpoch(8000),
      );

  @override
  Future<oauth2.Client> refreshCredentials([List<String> newScopes]) async {
    throw 'Not implemented';
  }

  http.Response createSuccessResponse(String body) {
    /// necessary due to using Latin-1 encoding per default.
    /// https://stackoverflow.com/questions/52990816/dart-json-encodedata-can-not-accept-other-language
    return http.Response(body, 200,
        headers: {'Content-Type': 'application/json; charset=utf-8'});
  }

  http.Response createErrorResponse(MockHttpError error) {
    return http.Response(
        _wrapMessageToJson(error.statusCode, error.message), error.statusCode,
        headers: {'Content-Type': 'application/json; charset=utf-8'});
  }

  String _wrapMessageToJson(int statusCode, String message) =>
      '{ \"error\": {\"status\":$statusCode,\"message\": \"$message\"}}';
}

class MockHttpError {
  int statusCode;
  String message;

  MockHttpError({this.statusCode, this.message});
}
