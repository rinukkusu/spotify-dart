// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class SpotifyApi extends SpotifyApiBase {
  SpotifyApi(SpotifyApiCredentials credentials, {Function(SpotifyApiCredentials) onCredentialsRefreshed})
      : super(credentials, http.Client(), onCredentialsRefreshed);
  
  SpotifyApi.fromClient(FutureOr<oauth2.Client> client)
      : super.fromClient(client);

  SpotifyApi.fromAuthCodeGrant(
      oauth2.AuthorizationCodeGrant grant, String responseUri)
      : super.fromAuthCodeGrant(grant, responseUri);

  static oauth2.AuthorizationCodeGrant authorizationCodeGrant(
      SpotifyApiCredentials credentials, {Function(SpotifyApiCredentials) onCredentialsRefreshed}) {
    return SpotifyApiBase.authorizationCodeGrant(credentials, http.Client(), onCredentialsRefreshed);
  }

   
}
