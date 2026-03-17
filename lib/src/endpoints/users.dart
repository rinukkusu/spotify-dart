// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../../spotify.dart';

class Users extends EndpointPaging {
  @override
  // ignore: unused_element
  String get _path => 'v1/users';

  Users(super.api);

  @Deprecated('This endpoint is now removed by spotify and throws an UnsupportedError.'
      'Use [spotify.me] for current user instead.')
  Future<UserPublic> get(String userId) async => throw UnsupportedError(
        'This endpoint is now removd by spotify. Use [spotify.me] instead.',
      );

  @Deprecated('This endpoint is now removed by spotify and throws an UnsupportedError.'
      'Use [spotify.me.playlists.saved] for current user instead.')
  Pages<PlaylistSimple> playlists(String userId) => throw UnsupportedError(
        'This endpoint is now removd by spotify. Use [spotify.me.playlists.saved] instead.',
      );

  @Deprecated('This endpoint is now removed by spotify and throws an UnsupportedError.'
      'Use [spotify.me.playlists.saved] for current user instead.')
  Future<Playlist> playlist(String userId, String playlistId) async => throw UnsupportedError(
        'This endpoint is now removed by spotify. Use [spotify.me.playlists.saved] for current user instead.',
      );

  @Deprecated('This endpoint is now removed by spotify and throws an UnsupportedError.')
  Pages<PlaylistTrack> playlistTracks(String userId, String playlistId) => throw UnsupportedError(
        'This endpoint is now removed by spotify',
      );
}
