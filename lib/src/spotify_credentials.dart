// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class SpotifyApiCredentials {
  String clientId;
  String clientSecret;

  /// The token that is sent to the resource server to prove the authorization
  /// of a client.
  String accessToken;

  /// The token that is sent to the authorization server to refresh the
  /// credentials.
  ///
  /// This may be `null`, indicating that the credentials can't be refreshed.
  String refreshToken;

  /// The token that is received from the authorization server to enable
  /// End-Users to be Authenticated, contains Claims, represented as a
  /// JSON Web Token (JWT).
  ///
  /// This may be `null`, indicating that the 'openid' scope was not
  /// requested (or not supported).
  ///
  /// [spec]: https://openid.net/specs/openid-connect-core-1_0.html#IDToken
  String idToken;

  /// The URL of the authorization server endpoint that's used to refresh the
  /// credentials.
  ///
  /// This may be `null`, indicating that the credentials can't be refreshed.
  Uri tokenEndpoint;

  /// The specific permissions being requested from the authorization server.
  ///
  /// The scope strings are specific to the authorization server and may be
  /// found in its documentation.
  List<String> scopes;

  /// The date at which these credentials will expire.
  ///
  /// This is likely to be a few seconds earlier than the server's idea of the
  /// expiration date.
  DateTime expiration;

  SpotifyApiCredentials(this.clientId, this.clientSecret);

  SpotifyApiCredentials.fromClient(oauth2.Client client) {
    clientId = client.identifier;
    clientSecret = client.secret;

    if (client.credentials != null) {
      accessToken = client.credentials.accessToken;
      refreshToken = client.credentials.refreshToken;
      idToken = client.credentials.idToken;
      tokenEndpoint = client.credentials.tokenEndpoint;
      scopes = client.credentials.scopes;
      expiration = client.credentials.expiration;
    }
  }

  /// Whether or not these credentials have expired.
  ///
  /// Note that it's possible the credentials will expire shortly after this is
  /// called. However, since the client's expiration date is kept a few seconds
  /// earlier than the server's, there should be enough leeway to rely on this.
  bool get isExpired =>
      expiration != null && DateTime.now().isAfter(expiration);

  /// Whether it's possible to refresh these credentials.
  bool get canRefresh => refreshToken != null && tokenEndpoint != null;

  String get basicAuth => base64.encode('$clientId:$clientSecret'.codeUnits);
}
