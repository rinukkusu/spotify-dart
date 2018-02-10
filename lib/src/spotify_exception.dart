// Copyright (c) 2018, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class SpotifyException implements Exception {
  int status;
  String message;

  SpotifyException([this.message]);

  SpotifyException.fromSpotify(SpotifyError error) {
    status = error.status;
    message = error.message;
  }
}
