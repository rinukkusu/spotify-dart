// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class SpotifyApiCredentials {
  /// The client identifier for this Spotify client.
  ///
  /// Spotify issues each client a separate client identifier and secret,
  /// which allows the server to tell which client is accessing it.
  String? clientId;

  /// The client secret for this Spotify client.
  ///
  /// Spotify issues each client a separate client identifier and secret,
  /// which allows the server to tell which client is accessing it.
  String? clientSecret;

  /// The token that is sent to Spotify to prove the authorization of a client.
  String? accessToken;

  /// The token that is sent to Spotify to refresh the credentials.
  ///
  /// This may be `null`, indicating that the credentials can't be refreshed.
  String? refreshToken;

  /// The URL of the Spotify endpoint that's used to refresh the credentials.
  ///
  /// This may be `null`, indicating that the credentials can't be refreshed.
  Uri? tokenEndpoint;

  /// The specific permissions being requested from Spotify.
  ///
  /// See https://developer.spotify.com/documentation/general/guides/scopes/
  /// for a full list of available scopes.
  List<String>? scopes;

  /// The date at which these credentials will expire, stored in the user's
  /// local time.
  ///
  /// This is likely to be a few seconds earlier than the server's idea of the
  /// expiration date.
  DateTime? expiration;

  SpotifyApiCredentials(
    this.clientId,
    this.clientSecret, {
    this.accessToken,
    this.refreshToken,
    this.scopes,
    this.expiration,
  }) : tokenEndpoint = Uri.parse(SpotifyApiBase._tokenUrl);

  SpotifyApiCredentials.withAccessToken(this.accessToken);

  SpotifyApiCredentials._fromClient(oauth2.Client client) {
    clientId = client.identifier;
    clientSecret = client.secret;

    accessToken = client.credentials.accessToken;
    refreshToken = client.credentials.refreshToken;
    tokenEndpoint = client.credentials.tokenEndpoint;
    scopes = client.credentials.scopes;
    expiration = client.credentials.expiration;
  }

  /// Whether or not these credentials have expired.
  ///
  /// Note that it's possible the credentials will expire shortly after this is
  /// called. However, since the client's expiration date is kept a few seconds
  /// earlier than the server's, there should be enough leeway to rely on this.
  bool get isExpired =>
      expiration != null && DateTime.now().isAfter(expiration!);

  /// Whether it's possible to refresh these credentials.
  bool get canRefresh => refreshToken != null && tokenEndpoint != null;

  String get basicAuth => base64.encode('$clientId:$clientSecret'.codeUnits);

  /// Whether or not these credentials contain all of the required information
  /// to create a client with access to a user's private data.
  bool get fullyQualified =>
      clientId != null &&
      clientSecret != null &&
      accessToken != null &&
      refreshToken != null &&
      tokenEndpoint != null &&
      scopes != null &&
      expiration != null;

  oauth2.Credentials _toOauth2Credentials() => oauth2.Credentials(
        accessToken!,
        refreshToken: refreshToken,
        tokenEndpoint: tokenEndpoint,
        scopes: scopes,
        expiration: expiration,
      );
}
