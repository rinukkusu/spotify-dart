// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class SpotifyApiCredentials {
  final String clientId;
  final String clientSecret;
  final String refreshToken;

  SpotifyApiCredentials(this.clientId, this.clientSecret, [this.refreshToken = null]);

  String get basicAuth => base64.encode('$clientId:$clientSecret'.codeUnits);

  bool get hasRefreshToken => refreshToken != null;
}
