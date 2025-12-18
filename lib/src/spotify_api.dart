// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../spotify.dart';

/// Accesspoint for the spotify api
///
/// Example usage:
/// ```dart
///   var credentials = SpotifyApiCredentials('my_id', 'my_secret');
///   var spotify = SpotifyApi(credentials);
///   var shows = spotify.shows.get('id);
///   ...
/// ```
class SpotifyApi extends SpotifyApiBase {
  SpotifyApi(
    SpotifyApiCredentials credentials, {
    Function(SpotifyApiCredentials)? onCredentialsRefreshed,
  }) : super(credentials, http.Client(), onCredentialsRefreshed);

  SpotifyApi.fromClient(super.client) : super.fromClient();

  SpotifyApi.fromAuthCodeGrant(super.grant, super.responseUri) : super.fromAuthCodeGrant();

  SpotifyApi.withAccessToken(super.accessToken) : super._withAccessToken();

  static Future<SpotifyApi> asyncFromCredentials(
    SpotifyApiCredentials credentials, {
    Function(SpotifyApiCredentials)? onCredentialsRefreshed,
  }) {
    return SpotifyApiBase._asyncFromCredentials(
      credentials,
      http.Client(),
      onCredentialsRefreshed,
    );
  }

  static oauth2.AuthorizationCodeGrant authorizationCodeGrant(
    SpotifyApiCredentials credentials, {
    String? codeVerifier,
    Function(SpotifyApiCredentials)? onCredentialsRefreshed,
  }) {
    return SpotifyApiBase.authorizationCodeGrant(
      credentials,
      http.Client(),
      codeVerifier: codeVerifier,
      onCredentialsRefreshed: onCredentialsRefreshed,
    );
  }

  /// Generates a cryptographically secure code verifier for PKCE flows.
  ///
  /// Use this when implementing OAuth authorization code flow with PKCE
  /// (Proof Key for Code Exchange) for public clients that cannot securely
  /// store client secrets.
  ///
  /// Example:
  /// ```dart
  /// final verifier = SpotifyApi.generateCodeVerifier();
  /// final credentials = SpotifyApiCredentials.pkce(
  ///   'my-client-id',
  ///   codeVerifier: verifier,
  /// );
  /// final grant = SpotifyApi.authorizationCodeGrant(credentials);
  /// ```
  ///
  /// See also:
  /// - [SpotifyApiCredentials.pkce] for creating PKCE credentials
  /// - [authorizationCodeGrant] for initiating the OAuth flow
  static String generateCodeVerifier() {
    const charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
    final random = math.Random.secure();
    return List.generate(
      128,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }
}
