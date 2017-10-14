// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class SpotifyApiCredentials {
  final String clientId;
  final String clientSecret;
  ApiToken token;
  TokenRequest _tokenRequest = new TokenRequest();

  SpotifyApiCredentials(this.clientId, this.clientSecret);

  SpotifyApiCredentials.withToken(this.token, GrantType grantType,
      [this.clientId = '', this.clientSecret = '']) {
    _tokenRequest = new TokenRequest(grantType);
  }

  TokenRequest get tokenRequest => _tokenRequest;
  String get basicAuth => BASE64.encode('$clientId:$clientSecret'.codeUnits);
}
