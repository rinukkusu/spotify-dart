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
  SpotifyApi(SpotifyApiCredentials credentials,
      {Function(SpotifyApiCredentials)? onCredentialsRefreshed})
      : super(credentials, http.Client(), onCredentialsRefreshed);

  SpotifyApi.fromClient(FutureOr<oauth2.Client> super.client)
      : super.fromClient();

  SpotifyApi.fromAuthCodeGrant(super.grant, super.responseUri)
      : super.fromAuthCodeGrant();

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
      SpotifyApiCredentials credentials,
      {String? codeVerifier,
      Function(SpotifyApiCredentials)? onCredentialsRefreshed}) {
    return SpotifyApiBase.authorizationCodeGrant(credentials, http.Client(),
        codeVerifier: codeVerifier,
        onCredentialsRefreshed: onCredentialsRefreshed);
  }
}
