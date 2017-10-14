// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library spotify.token;

import 'package:owl/annotation/json.dart';

enum GrantType {
  authorizationCode,
  refreshToken,
  clientCredentials,
  implicitGrant
}

@JsonClass()
class TokenRequest {
  TokenRequest([this._grantType = GrantType.clientCredentials]) {
    grantTypeString = this.toString();
  }

  @JsonField(key: 'grant_type')
  String grantTypeString;

  @Transient()
  GrantType _grantType;

  @Transient()
  bool get canRefresh => _grantType == GrantType.clientCredentials ||
      _grantType == GrantType.authorizationCode;

  @override
  String toString() {
    switch (_grantType) {
      case GrantType.authorizationCode:
        return 'authorization_code';
      case GrantType.refreshToken:
        return 'refresh_token';
      case GrantType.clientCredentials:
        return 'client_credentials';
      default:
        throw new UnsupportedError(
            'Unsupported grant type: ${_grantType.toString()}'
        );
    }
  }
}

@JsonClass()
class ApiToken {
  @JsonField(key: 'access_token')
  String accessToken;

  @JsonField(key: 'token_type')
  String tokenType;

  @JsonField(key: 'expires_in')
  int expiresIn;

  @Transient()
  DateTime _createdOn = new DateTime.now();
  bool get isExpired =>
      _createdOn.difference(new DateTime.now()).inSeconds.abs() > expiresIn;

  ApiToken();

  ApiToken.implicitGrant(String accessToken, int expiresIn) {
    this.accessToken = accessToken;
    this.tokenType = 'Bearer';
    this.expiresIn = expiresIn;
  }
}
