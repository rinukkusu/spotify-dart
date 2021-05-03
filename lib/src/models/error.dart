// Copyright (c) 2018, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(explicitToJson: true)
class SpotifyError extends Object {
  SpotifyError();

  factory SpotifyError.fromJson(Map<String, dynamic> json) =>
      _$SpotifyErrorFromJson(json);

  Map<String, dynamic> toJson() => _$SpotifyErrorToJson(this);

  /// The HTTP status code (also returned in the response header; see Response
  /// Status Codes for more information).
  int status;

  /// A short description of the cause of the error.
  String message;
}
