// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

@JsonClass()
class User implements UserPublic {
  /// The user's date-of-birth.
  ///
  /// This field is only available when the current user has granted access to
  /// the user-read-birthdate scope.
  String birthdate;

  /// The country of the user, as set in the user's account profile. An
  /// ISO 3166-1 alpha-2 country code. This field is only available when the
  /// current user has granted access to the user-read-private scope.
  String country;

  /// The name displayed on the user's profile. null if not available.
  @JsonField(key: 'display_name')
  String displayName;

  /// The user's email address, as entered by the user when creating their
  /// account.
  ///
  /// Important! This email address is unverified; there is no proof that it
  /// actually belongs to the user.
  ///
  /// This field is only available when the current user has granted access to
  /// the user-read-email scope.
  String email;

  // /// Known public external URLs for this user.
  //@JsonField(key: 'external_urls')
  //Map<String, String> externalUrls;

  /// Information about the followers of this user.
  Followers followers;

  /// A link to the Web API endpoint for this user.
  String href;

  /// The Spotify user ID for this user.
  String id;

  /// The user's profile image.
  List<Image> images;

  /// The user's Spotify subscription level: "premium", "free", etc. (The
  /// subscription level "open" can be considered the same as "free".)
  ///
  /// This field is only available when the current user has granted access to
  /// the user-read-private scope.
  String product;

  /// The object type: "user"
  String type;

  /// The Spotify URI for this user.
  String uri;
}

@JsonClass()
class UserPublic {
  /// The name displayed on the user's profile. null if not available.
  @JsonField(key: 'display_name')
  String displayName;

  // /// Known public external URLs for this user.
  //@JsonField(key: 'external_urls')
  //Map<String, String> externalUrls;

  /// Information about the followers of this user.
  Followers followers;

  /// A link to the Web API endpoint for this user.
  String href;

  /// The Spotify user ID for this user.
  String id;

  /// The user's profile image.
  List<Image> images;

  /// The object type: "user"
  String type;

  /// The Spotify URI for this user.
  String uri;
}
