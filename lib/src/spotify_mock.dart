part of spotify;

class SpotifyApiMock extends SpotifyApiBase {
  SpotifyApiMock(SpotifyApiCredentials credentials) : super(credentials);

  @override
  Future<String> _getImpl(String url, Map<String, String> headers) async {
    var client = new MockClient();
    var response = await client.get(url, headers: headers);

    return UTF8.decode(response.bodyBytes);
  }

  @override
  Future<String> _postImpl(
      String url, Map<String, String> headers, dynamic body) async {
    var client = new MockClient();
    var response = await client.post(url, headers: headers, body: body);
    return UTF8.decode(response.bodyBytes);
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
    // TODO: implement close
  }

  @override
  Future<http.Response> delete(url, {Map<String, String> headers}) {
    // TODO: implement delete
  }

  @override
  Future<http.Response> get(url, {Map<String, String> headers}) async {
    return new http.Response(_readPath(url), 200);
  }

  @override
  Future<http.Response> head(url, {Map<String, String> headers}) {
    // TODO: implement head
  }

  @override
  Future<http.Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    // TODO: implement patch
  }

  @override
  Future<http.Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    return new http.Response(_readPath(url), 200);
  }

  @override
  Future<http.Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    // TODO: implement put
  }

  @override
  Future<String> read(url, {Map<String, String> headers}) {
    // TODO: implement read
  }

  @override
  Future<Uint8List> readBytes(url, {Map<String, String> headers}) {
    // TODO: implement readBytes
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // TODO: implement send
  }
}
