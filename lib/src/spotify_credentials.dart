part of spotify;

class SpotifyApiCredentials {
  final String clientId;
  final String clientSecret;

  SpotifyApiCredentials(this.clientId, this.clientSecret);

  String get basicAuth => BASE64.encode('$clientId:$clientSecret'.codeUnits);
}