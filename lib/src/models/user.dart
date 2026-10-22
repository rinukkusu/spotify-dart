// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Json representation of a user
@JsonSerializable()
class User extends UserPublic {
  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// A public, immutable, pseudoanonymous identifier for the user's account.
  @JsonKey(name: 'account_id')
  String? accountId;

  /// The user's date-of-birth.
  ///
  /// This field is only available when the current user has granted access to
  /// the user-read-birthdate scope.
  String? birthdate;
}

/// Json representation of a publicly displayed user
@JsonSerializable()
class UserPublic extends SpotifyContent {
  UserPublic();

  factory UserPublic.fromJson(Map<String, dynamic> json) => _$UserPublicFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserPublicToJson(this);

  /// The name displayed on the user's profile. null if not available.
  @JsonKey(name: 'display_name')
  String? displayName;

  /// The user's profile image.
  List<Image>? images;
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
