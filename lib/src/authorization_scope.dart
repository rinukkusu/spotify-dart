// Copyright (c) 2023, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// ignore_for_file: deprecated_member_use_from_same_package

part of '../spotify.dart';

/// Class holding all available authorization scopes.
/// See [Spotify scopes documentation](https://developer.spotify.com/documentation/web-api/concepts/scopes)
class AuthorizationScope {
  const AuthorizationScope();

  /// Scope regarding users
  static const UserAuthorizationScope user = UserAuthorizationScope();

  /// Scope regarding playback
  static PlaylistAuthorizationScope playlist = PlaylistAuthorizationScope();

  /// Scope regarding images (e.g. playlist images)
  static ImagesAuthorizationScope images = ImagesAuthorizationScope();

  /// Scope regarding Spotify Connect
  static ConnectAuthorizationScope connect = ConnectAuthorizationScope();

  /// Scope regarding the user's library
  static LibraryAuthorizationScope library = LibraryAuthorizationScope();

  /// Scope regarding the user's listening history
  static ListeningHistoryAuthorizationScope listen =
      ListeningHistoryAuthorizationScope();

  /// Scope regarding following artists or users
  static FollowAuthorizationScope follow = FollowAuthorizationScope();

  static final all = List.unmodifiable([
    ...user.all,
    ...playlist.all,
    ...images.all,
    ...connect.all,
    ...library.all,
    ...listen.all,
    ...follow.all
  ]);
}

abstract class _Scope {
  const _Scope();

  /// Contains all properties of this class
  List<String> get all;
}

class FollowAuthorizationScope extends _Scope {
  const FollowAuthorizationScope();

  /// Read access to the list of artists and other users that the user follows.
  ///
  /// Endpoints that require the `user-follow-read` scope:
  /// * [Me.containsFollowing]
  /// * [Me.following]
  String get read => 'user-follow-read';

  /// Write/delete access to the list of artists and other users that the user follows.
  ///
  /// Endpoints that require the `user-follow-modify` scope:
  /// * [Me.follow]
  /// * [Me.unfollow]
  String get modify => 'user-follow-modify';

  @override
  List<String> get all => List.unmodifiable([read, modify]);
}

class ListeningHistoryAuthorizationScope extends _Scope {
  const ListeningHistoryAuthorizationScope();

  /// Read access to a user’s playback position in a content.
  ///
  /// Endpoints that require the `user-read-playback-position` scope:
  /// * [Episodes.get]
  /// * [Episodes.list]
  /// * [Shows.get]
  /// * [Shows.list]
  /// * [Shows.episodes]
  String get readPlaybackPosition => 'user-read-playback-position';

  /// Read access to a user's top artists and tracks.
  ///
  /// Endpoints that require the `user-top-read` scope:
  /// * [Me.topTracks]
  /// * [Me.topArtists]
  String get readTop => 'user-top-read';

  /// Read access to a user’s recently played tracks.
  ///
  /// Endpoints that require the `user-read-recently-played` scope:
  /// * [PlayerEndpoint.currentlyPlaying]
  String get readRecentlyPlayed => 'user-read-recently-played';

  @override
  List<String> get all =>
      List.unmodifiable([readPlaybackPosition, readTop, readRecentlyPlayed]);
}

class ConnectAuthorizationScope extends _Scope {
  const ConnectAuthorizationScope();

  /// Read access to a user’s player state.
  ///
  /// Endpoints that require the `user-read-playback-state` scope:
  /// * [PlayerEndpoint.devices]
  /// * [PlayerEndpoint.currentlyPlaying]
  /// * [PlayerEndpoint.playbackState]
  String get readPlaybackState => 'user-read-playback-state';

  /// Write access to a user’s playback state.
  ///
  /// Endpoints that require the `user-modify-playback-state` scope:
  /// * [PlayerEndpoint.pause]
  /// * [PlayerEndpoint.previous]
  /// * [PlayerEndpoint.next]
  /// * [PlayerEndpoint.seek]
  /// * [PlayerEndpoint.volume]
  /// * [PlayerEndpoint.shuffle]
  /// * [PlayerEndpoint.repeat]
  /// * [PlayerEndpoint.startOrResume]
  /// * [PlayerEndpoint.addToQueue]
  String get modifyPlaybackState => 'user-modify-playback-state';

  /// Read access to a user’s currently playing content.
  ///
  /// Endpoints that require the `user-read-currently-playing` scope:
  /// * [PlayerEndpoint.currentlyPlaying]
  /// * [PlayerEndpoint.queue]
  String get readCurrentlyPlaying => 'user-read-currently-playing';

  @override
  List<String> get all => List.unmodifiable(
      [readCurrentlyPlaying, readPlaybackState, modifyPlaybackState]);
}

class LibraryAuthorizationScope extends _Scope {
  /// Read access to a user's library.
  ///
  /// Endpoints that require the `user-library-read` scope:
  /// * [Me.savedEpisodes]
  /// * [Me.containsSavedEpisodes]
  /// * [Me.savedAlbums]
  /// * [Me.containsSavedAlbums]
  /// * [TracksMe.containsTracks]
  /// * [TracksMe.containsOne]
  /// * [TracksMe.saved]
  String get read => 'user-library-read';

  /// Write/delete access to a user's "Your Music" library.
  ///
  /// Endpoints that require the `user-library-modify` scope:
  /// * [Me.removeAlbums]
  /// * [Me.removeEpisodes]
  /// * [Me.saveEpisodes]
  /// * [Me.saveAlbums]
  /// * [TracksMe.saveOne]
  /// * [TracksMe.save]
  /// * [TracksMe.remove]
  /// * [TracksMe.removeOne]
  String get modify => 'user-library-modify';

  @override
  List<String> get all => List.unmodifiable([read, modify]);
}

class UserAuthorizationScope extends _Scope {
  const UserAuthorizationScope() : super();

  /// Read access to user’s subscription details (type of user account).
  ///
  /// Endpoints that require the `user-read-profile` scope:
  /// * [Search.get]
  /// * [Me.get]
  String get readFollow => 'user-read-profile';

  /// Read access to user’s email address.
  ///
  /// Endpoints that require the `user-read-email` scope:
  /// * [Me.get]
  String get readEmail => 'user-read-email';

  /// Contains all properties of [AuthorizationScope.user]
  @override
  List<String> get all => List.unmodifiable([readFollow, readEmail]);
}

class PlaylistAuthorizationScope extends _Scope {
  const PlaylistAuthorizationScope();

  /// Read access to user's private playlists.
  ///
  /// Endpoints that require the `playlist-read-private` scope:
  /// * [Playlists.followedByUsers]
  /// * [Playlists.me]
  /// * [Users.playlist]
  String get readPrivate => 'playlist-read-private';

  /// Write access to a user's private playlists.
  ///
  /// Endpoints that require the `playlist-modify-private` scope:
  /// * [Playlists.followPlaylist]
  /// * [Playlists.unfollowPlaylist]
  /// * [Playlists.addTrack]
  /// * [Playlists.addTracks]
  /// * [Playlists.createPlaylist]
  /// * [Playlists.updatePlaylist]
  /// * [Playlists.removePlaylist]
  /// * [Playlists.createPlaylist]
  /// * [Playlists.removeTrack]
  /// * [Playlists.removeTracks]
  /// * [Playlists.replace]
  /// * [Playlists.reorder]
  /// * [Playlists.updatePlaylistImage]
  String get modifyPrivate => 'playlist-modify-private';

  /// Include collaborative playlists when requesting a user's playlists.
  ///
  /// Endpoints that require the `playlist-read-collaborative` scope:
  /// * [Playlists.me]
  /// * [Users.playlist]
  String get readCollaborative => 'playlist-read-collaborative';

  /// Write access to a user's public playlists.
  ///
  /// Endpoints that require the `playlist-modify-public` scope:
  /// * [Playlists.followPlaylist]
  /// * [Playlists.unfollowPlaylist]
  /// * [Playlists.addTrack]
  /// * [Playlists.addTracks]
  /// * [Playlists.createPlaylist]
  /// * [Playlists.updatePlaylist]
  /// * [Playlists.removePlaylist]
  /// * [Playlists.createPlaylist]
  /// * [Playlists.removeTrack]
  /// * [Playlists.removeTracks]
  /// * [Playlists.replace]
  /// * [Playlists.reorder]
  /// * [Playlists.updatePlaylistImage]
  String get modifyPublic => 'playlist-modify-public';

  /// Contains all properties of [AuthorizationScope.playlist]
  @override
  List<String> get all => List.unmodifiable(
      [readPrivate, readCollaborative, modifyPrivate, modifyPublic]);
}

class ImagesAuthorizationScope extends _Scope {
  const ImagesAuthorizationScope();

  /// Write access to user-provided images.
  ///
  /// Endpoints that require the `ugc-image-upload` scope:
  /// * [Playlists.updatePlaylistImage]
  String get imageUpload => 'ugc-image-upload';

  @override
  List<String> get all => [imageUpload];
}
