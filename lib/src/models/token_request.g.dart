// GENERATED CODE - DO NOT MODIFY BY HAND

part of spotify.token;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRequest _$TokenRequestFromJson(Map<String, dynamic> json) {
  return TokenRequest()..grantType = json['grant_type'] as String;
}

ApiToken _$ApiTokenFromJson(Map<String, dynamic> json) {
  return ApiToken()
    ..accessToken = json['access_token'] as String
    ..tokenType = json['token_type'] as String
    ..expiresIn = json['expires_in'] as int;
}
