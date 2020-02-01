// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;


class SpotifyApi extends SpotifyApiBase {
  final Client client;

  SpotifyApi(this.client) : super();

  static Future<SpotifyApi> fromCredentials(SpotifyApiCredentials credentials) async {

    final client = await clientCredentialsGrant(
        Uri.parse(SpotifyApiBase._tokenUrl),
        credentials.clientId, credentials.clientSecret,
        httpClient: http.BrowserClient());
    return SpotifyApi(client);
  }

  static AuthorizationCodeGrant authorizationCodeGrant(
      String clientId, {String secret}) {
    return AuthorizationCodeGrant(
        clientId,
        Uri.parse(SpotifyApiBase._authorizationUrl),
        Uri.parse(SpotifyApiBase._tokenUrl),
        secret: secret,
        httpClient: http.BrowserClient()
    );
  }

  @override
  Future<String> _getImpl(String url, Map<String, String> headers) async {
    var response = await client.get(url, headers: headers);
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 400) {
      var jsonMap = json.decode(responseBody);
      throw new SpotifyException.fromSpotify(
          SpotifyError.fromJson(jsonMap['error']));
    }
    return responseBody;
  }

  @override
  Future<String> _postImpl(
      String url, Map<String, String> headers, dynamic body) async {
    var response = await client.post(url, headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 400) {
      var jsonMap = json.decode(responseBody);
      throw new SpotifyException.fromSpotify(
          SpotifyError.fromJson(jsonMap['error']));
    }
    return responseBody;
  }

  @override
  Future<String> _putImpl(
      String url, Map<String, String> headers, dynamic body) async {
    var response = await client.put(url, headers: headers, body: body);
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 400) {
      var jsonMap = json.decode(responseBody);
      throw new SpotifyException.fromSpotify(
          SpotifyError.fromJson(jsonMap['error']));
    }
    return responseBody;
  }

  @override
  Future<String> _deleteImpl(String url, Map<String, String> headers, body) {
    // TODO: implement _deleteImpl
    return null;
  }
}
