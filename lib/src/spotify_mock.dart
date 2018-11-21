part of spotify;

class SpotifyApiMock extends SpotifyApiBase {
  SpotifyApiMock(SpotifyApiCredentials credentials) : super(credentials);

  @override
  Future<String> _getImpl(String url, Map<String, String> headers) async {
    var client = new MockClient();
    var response = await client.get(url, headers: headers);

    return utf8.decode(response.bodyBytes);
  }

  @override
  Future<String> _postImpl(
      String url, Map<String, String> headers, dynamic body) async {
    var client = new MockClient();
    var response = await client.post(url, headers: headers, body: body);
    return utf8.decode(response.bodyBytes);
  }

  @override
  Future<String> _putImpl(String url, Map<String, String> headers, body) async {
    var client = new MockClient();
    var response = await client.put(url, headers: headers, body: body);
    return utf8.decode(response.bodyBytes);
  }
}

class MockClient implements http.BaseClient {
  String _readPath(String url) {
    var regexString = url.contains('api.spotify.com')
        ? r'api.spotify.com\/([A-Za-z0-9/]+)\??'
        : r'api/([A-Za-z0-9/]+)\??';

    var regex = new RegExp(regexString);
    var partialPath = regex.firstMatch(url).group(1);
    var file = new File('test/data/$partialPath.json');

    return file.readAsStringSync();
  }

  @override
  void close() {
    throw "Not implemented";
  }

  @override
  Future<http.Response> delete(url, {Map<String, String> headers}) {
    throw "Not implemented";
  }

  @override
  Future<http.Response> get(url, {Map<String, String> headers}) async =>
      createSuccessResponse(_readPath(url));

  @override
  Future<http.Response> head(url, {Map<String, String> headers}) {
    throw "Not implemented";
  }

  @override
  Future<http.Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    throw "Not implemented";
  }

  @override
  Future<http.Response> post(url,
          {Map<String, String> headers, body, Encoding encoding}) async =>
      createSuccessResponse(_readPath(url));

  @override
  Future<http.Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    throw "Not implemented";
  }

  @override
  Future<String> read(url, {Map<String, String> headers}) {
    throw "Not implemented";
  }

  @override
  Future<Uint8List> readBytes(url, {Map<String, String> headers}) {
    throw "Not implemented";
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw "Not implemented";
  }

  http.Response createSuccessResponse(String body) {
    /// necessary due to using Latin-1 encoding per default.
    /// https://stackoverflow.com/questions/52990816/dart-json-encodedata-can-not-accept-other-language
    return new http.Response(body, 200,
        headers: {'Content-Type': 'application/json; charset=utf-8'});
  }
}
