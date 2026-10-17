// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of a user
@JsonSerializable()
class User extends Object implements UserPublic {
  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// The user's date-of-birth.
  ///
  /// This field is only available when the current user has granted access to
  /// the user-read-birthdate scope.
  String? birthdate;

  /// The name displayed on the user's profile. null if not available.
  @JsonKey(name: 'display_name')
  @override
  String? displayName;

  /// A link to the Web API endpoint for this user.
  @override
  String? href;

  /// The Spotify user ID for this user.
  @override
  String? id;

  /// The user's profile image.
  @override
  List<Image>? images;

  /// The object type: "user"
  @override
  String? type;

  /// The Spotify URI for this user.
  @override
  String? uri;
}

/// Json representation of a publicly displayed user
@JsonSerializable()
class UserPublic extends Object {
  UserPublic();

  factory UserPublic.fromJson(Map<String, dynamic> json) => _$UserPublicFromJson(json);

  Map<String, dynamic> toJson() => _$UserPublicToJson(this);

  /// The name displayed on the user's profile. null if not available.
  @JsonKey(name: 'display_name')
  String? displayName;

  /// A link to the Web API endpoint for this user.
  String? href;

  /// The Spotify user ID for this user.
  String? id;

  /// The user's profile image.
  List<Image>? images;

  /// The object type: "user"
  String? type;

  /// The Spotify URI for this user.
  String? uri;
}

/// Json representation of the playback history
@JsonSerializable()
class PlayHistory extends Object {
  PlayHistory();

  factory PlayHistory.fromJson(Map<String, dynamic> json) => _$PlayHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$PlayHistoryToJson(this);

  /// The track the user listened to.
  Track? track;

  /// The date and time the track was played.
  @JsonKey(name: 'played_at')
  DateTime? playedAt;

  /// The context the track was played from.
  PlayerContext? context;
}
