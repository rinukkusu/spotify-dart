// GENERATED CODE - DO NOT MODIFY BY HAND

part of spotify.token;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRequest _$TokenRequestFromJson(Map<String, dynamic> json) {
  return TokenRequest()..grantType = json['grant_type'] as String;
}

Map<String, dynamic> _$TokenRequestToJson(TokenRequest instance) =>
    <String, dynamic>{'grant_type': instance.grantType};

ApiToken _$ApiTokenFromJson(Map<String, dynamic> json) {
  return ApiToken()
    ..accessToken = json['access_token'] as String
    ..tokenType = json['token_type'] as String
    ..expiresIn = json['expires_in'] as int;
}

Map<String, dynamic> _$ApiTokenToJson(ApiToken instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn
    };
