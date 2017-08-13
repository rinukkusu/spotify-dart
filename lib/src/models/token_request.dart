// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library spotify.token;

import 'package:owl/annotation/json.dart';

@JsonClass()
class TokenRequest {
  @JsonField(key: 'grant_type')
  String grantType = 'client_credentials';
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
}