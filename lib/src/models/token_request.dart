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