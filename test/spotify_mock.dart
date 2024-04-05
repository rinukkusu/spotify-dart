import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:spotify/spotify.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;

/// Mock class for making requests
class SpotifyApiMock extends SpotifyApiBase {
  SpotifyApiMock(SpotifyApiCredentials credentials)
      : super.fromClient(MockClient(credentials));

  set mockHttpErrors(Iterator<MockHttpError> errors) =>
      (client as MockClient)._mockHttpErrors = errors;

  set interceptor(
          Function(String method, String url, Map<String, String>? headers,
                  [String? body])?
              interceptor) =>
      (client as MockClient).interceptFunction = interceptor;
}

class MockClient implements oauth2.Client {
  MockClient(SpotifyApiCredentials credentials,
      {Iterator<MockHttpError>? mockHttpErrors}) {
    identifier = credentials.clientId;
    secret = credentials.clientSecret;
    _mockHttpErrors = mockHttpErrors;
  }

  Function(String method, String url, Map<String, String>? headers,
      [String? body])? interceptFunction;

  void _intercept(String method, String url, Map<String, String>? headers,
      [String? body]) {
    if (interceptFunction != null) {
      interceptFunction!(method, url, headers, body);
    }
  }

  @override
  String? identifier;

  @override
  String? secret;

  Iterator<MockHttpError>? _mockHttpErrors;

  MockHttpError? _getMockError() {
    if (_mockHttpErrors != null && _mockHttpErrors!.moveNext()) {
      return _mockHttpErrors!.current;
    } else {
      return null;
    }
  }

  String _readPath(Uri url) {
    var regexString = url.host.contains('api.spotify.com')
        ? r'api.spotify.com\/([A-Za-z0-9/\-]+)\??'
        : r'api/([A-Za-z0-9/\-]+)\??';

    var regex = RegExp(regexString);
    var urlString = url.toString();
    var partialPath = regex.firstMatch(urlString)!.group(1);
    var file = File('test/data/$partialPath.json');
    return file.readAsStringSync();
  }

  @override
  void close() {
    throw 'Not implemented';
  }

  @override
  Future<http.Response> delete(url,
      {Object? body, Encoding? encoding, Map<String, String>? headers}) {
    throw 'Not implemented';
  }

  @override
  Future<http.Response> get(url, {Map<String, String>? headers}) async {
    _intercept('GET', url.toString(), headers);
    final err = _getMockError();
    if (err != null) {
      return createErrorResponse(err);
    }
    return createSuccessResponse(_readPath(url));
  }

  @override
  Future<http.Response> head(url, {Map<String, String>? headers}) async {
    _intercept('HEAD', url.toString(), headers);
    return createSuccessResponse();
  }

  @override
  Future<http.Response> patch(url,
      {Map<String, String>? headers, body, Encoding? encoding}) {
    throw 'Not implemented';
  }

  @override
  Future<http.Response> post(url,
      {Map<String, String>? headers, body, Encoding? encoding}) async {
    _intercept('POST', url.toString(), headers, body.toString());
    final err = _getMockError();
    if (err != null) {
      return createErrorResponse(err);
    }
    return createSuccessResponse(_readPath(url));
  }

  @override
  Future<http.Response> put(url,
      {Map<String, String>? headers, body, Encoding? encoding}) async {
    _intercept('PUT', url.toString(), headers, body.toString());
    return createSuccessResponse(_readPath(url));
  }

  @override
  Future<String> read(url, {Map<String, String>? headers}) {
    throw 'Not implemented';
  }

  @override
  Future<Uint8List> readBytes(url, {Map<String, String>? headers}) {
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
  Future<oauth2.Client> refreshCredentials([List<String>? newScopes]) async {
    throw 'Not implemented';
  }

  http.Response createSuccessResponse([String body = ""]) {
    /// necessary due to using Latin-1 encoding per default.
    /// https://stackoverflow.com/questions/52990816/dart-json-encodedata-can-not-accept-other-language
    return http.Response(body, 200, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    });
  }

  http.Response createErrorResponse(MockHttpError error) {
    return http.Response(_wrapMessageToJson(error.statusCode!, error.message!),
        error.statusCode!,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        }..addAll(error.headers ?? {}));
  }

  String _wrapMessageToJson(int statusCode, String message) =>
      '{ "error": {"status":$statusCode,"message": "$message"}}';
}

class MockHttpError {
  int? statusCode;
  String? message;
  Map<String, String>? headers;

  MockHttpError({this.statusCode, this.message, this.headers}) {
    headers;
  }
}
