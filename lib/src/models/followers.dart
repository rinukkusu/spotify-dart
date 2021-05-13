// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify.models;

@JsonSerializable(createToJson: false)
class Followers extends Object {
  Followers();

  factory Followers.fromJson(Map<String, dynamic> json) =>
      _$FollowersFromJson(json);

  /// A link to the Web API endpoint providing full details of the followers;
  /// null if not available.
  ///
  /// Please note that this will always be set to null, as the Web API does not
  /// support it at the moment.
  String? href;

  /// The total number of followers.
  int? total;
}
