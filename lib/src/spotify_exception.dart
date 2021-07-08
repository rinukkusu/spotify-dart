// Copyright (c) 2018, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class SpotifyException implements Exception {
  int? status;
  String? message;

  SpotifyException([this.message]);

  SpotifyException.fromSpotify(SpotifyError error) {
    status = error.status;
    message = error.message;
  }

  @override
  String toString() => 'Error Code: $status\r\n$message';
}

class ApiRateException extends SpotifyException {
  final num retryAfter;

  ApiRateException.fromSpotify(SpotifyError error, this.retryAfter)
      : super.fromSpotify(error);
}
