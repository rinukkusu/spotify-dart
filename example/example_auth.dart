// Copyright (c) 2020 hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:spotify/spotify.dart';

final _scopes = [
  AuthorizationScope.playlist.modifyPrivate,
  AuthorizationScope.playlist.modifyPublic,
  AuthorizationScope.library.read,
  AuthorizationScope.library.modify,
  AuthorizationScope.connect.readPlaybackState,
  AuthorizationScope.connect.modifyPlaybackState,
  AuthorizationScope.listen.readRecentlyPlayed,
  AuthorizationScope.follow.read
];

void main() async {
  var keyMap = await _getApiKeys();

  var credentials = SpotifyApiCredentials(keyMap.key, keyMap.value);
  var spotify = await _getUserAuthenticatedSpotifyApi(credentials);
  if (spotify == null) {
    exit(0);
  }
  await _user(spotify);
  await _currentlyPlaying(spotify);
  await _devices(spotify);
  await _followingArtists(spotify);
  await _shuffle(true, spotify);
  await _shuffle(false, spotify);
  await _playlists(spotify);
  await _savedTracks(spotify);
  await _recentlyPlayed(spotify);
  await _getShow(spotify);
  await _listShows(spotify);
  await _savedShows(spotify);
  await _saveAndRemoveShow(spotify);
  await _getEpisode(spotify);
  await _listEpisodes(spotify);
  await _savedEpisodes(spotify);
  await _saveAndRemoveEpisode(spotify);
  await _clearPlaylist(spotify);
  await _reorderItemsInPlaylist(spotify);
  await _replaceItemsInPlaylist(spotify);

  exit(0);
}

Future<MapEntry<String, String>> _getApiKeys() async {
  var keyJson = await File('example/.apikeys').readAsString();
  var keyMap = json.decode(keyJson);
  return MapEntry(keyMap['id'], keyMap['secret']);
}

Future<SpotifyApi?> _getUserAuthenticatedSpotifyApi(
    SpotifyApiCredentials credentials) async {
  print(
      'Please paste your redirect url (from your spotify application\'s redirect url):');
  var redirect = stdin.readLineSync();

  var grant = SpotifyApi.authorizationCodeGrant(credentials);
  var authUri =
      grant.getAuthorizationUrl(Uri.parse(redirect!), scopes: _scopes);

  print(
      'Please paste this url \n\n$authUri\n\nto your browser and enter the redirected url:');
  var redirectUrl;
  var userInput = stdin.readLineSync();
  if (userInput == null || (redirectUrl = Uri.tryParse(userInput)) == null) {
    print('Invalid redirect url');
    return null;
  }

  var client =
      await grant.handleAuthorizationResponse(redirectUrl.queryParameters);
  return SpotifyApi.fromClient(client);
}

Future<void> _currentlyPlaying(SpotifyApi spotify) async =>
    await spotify.player.currentlyPlaying().then((PlaybackState? a) {
      if (a?.item == null) {
        print('Nothing currently playing.');
        return;
      }
      print('Currently playing: ${a?.item?.name}');
    }).catchError(_prettyPrintError);

Future<void> _user(SpotifyApi spotify) async {
  print('User\'s data:');
  await spotify.me.get().then((user) {
    var buffer = StringBuffer();
    buffer.write('id:');
    buffer.writeln(user.id);
    buffer.write('name:');
    buffer.writeln(user.displayName);
    buffer.write('email:');
    buffer.writeln(user.email);
    buffer.write('type:');
    buffer.writeln(user.type);
    buffer.write('birthdate:');
    buffer.writeln(user.birthdate);
    buffer.write('country:');
    buffer.writeln(user.country);
    buffer.write('followers:');
    buffer.writeln(user.followers?.href);
    buffer.write('country:');
    buffer.writeln(user.country);
    print(buffer.toString());
  });
}

Future<void> _devices(SpotifyApi spotify) async =>
    await spotify.player.devices().then((Iterable<Device>? devices) {
      if (devices == null || devices.isEmpty) {
        print('No devices currently playing.');
        return;
      }
      print('Listing ${devices.length} available devices:');
      print(devices.map((device) => device.name).join(', '));
    }).catchError(_prettyPrintError);

Future<void> _followingArtists(SpotifyApi spotify) async {
  var cursorPage = spotify.me.following(FollowingType.artist);
  await cursorPage.first().then((cursorPage) {
    print(cursorPage.items!.map((artist) => artist.name).join(', '));
  }).catchError((ex) => _prettyPrintError(ex));
}

Future<void> _shuffle(bool state, SpotifyApi spotify) async {
  await spotify.player.shuffle(state).then((player) {
    print('Shuffle: ${player?.isShuffling}');
  }).catchError((ex) => _prettyPrintError(ex));
}

Future<void> _playlists(SpotifyApi spotify) async {
  await spotify.playlists.me.all(1).then((playlists) {
    var lists = playlists.map((playlist) => playlist.name).join(', ');
    print('Playlists: $lists');
  }).catchError(_prettyPrintError);
}

Future<void> _savedTracks(SpotifyApi spotify) async {
  var stream = spotify.tracks.me.saved.stream();
  print('Saved Tracks:\n');
  await for (final page in stream) {
    var items = page.items?.map((e) => e.track?.name).join(', ');
    print(items);
  }
}

Future<void> _recentlyPlayed(SpotifyApi spotify) async {
  var stream = spotify.me.recentlyPlayed().stream();
  await for (final page in stream) {
    var items = page.items?.map((e) => e.track?.name).join(', ');
    print(items);
  }
}

Future<void> _getShow(SpotifyApi spotify) async {
  var response = await spotify.shows.get('3kbLJJLzRGsAKESODPSbiB');
  print(response.name);
}

Future<void> _listShows(SpotifyApi spotify) async {
  var response = await spotify.shows.list(['3kbLJJLzRGsAKESODPSbiB']);
  for (final show in response) {
    print(show.name);
  }
}

Future<void> _savedShows(SpotifyApi spotify) async {
  print('Users saved shows');
  var response = spotify.me.savedShows().stream();
  await for (final page in response) {
    var names = page.items?.map((e) => e.name).join(', ');
    print(names);
  }
}

Future<void> _saveAndRemoveShow(SpotifyApi spotify) async {
  print('Saving show with id 4XPl3uEEL9hvqMkoZrzbx5');
  await spotify.me.saveShows(['4XPl3uEEL9hvqMkoZrzbx5']);
  var saved = await spotify.me.containsSavedShows(['4XPl3uEEL9hvqMkoZrzbx5']);
  print('Checking is 4XPl3uEEL9hvqMkoZrzbx5 is in saved shows...');
  print(saved);
  print('Removing show wish id 4XPl3uEEL9hvqMkoZrzbx5');
  await spotify.me.removeShows(['4XPl3uEEL9hvqMkoZrzbx5']);
  print('Checking is 4XPl3uEEL9hvqMkoZrzbx5 is in saved shows...');
  saved = await spotify.me.containsSavedShows(['4XPl3uEEL9hvqMkoZrzbx5']);
  print(saved);
}

Future<void> _getEpisode(SpotifyApi spotify) async {
  print('\nRetriving Information about episode with id 2TkVS48EgJwFUMiH8UwqGL');
  var episode = await spotify.episodes.get('2TkVS48EgJwFUMiH8UwqGL');
  print('${episode.name} - ${episode.show?.name}');
}

Future<void> _listEpisodes(SpotifyApi spotify) async {
  print(
      '\nRetriving Information about episodes 2TkVS48EgJwFUMiH8UwqGL, 4Bje2xtE4VxqO2HO1PQdsG');
  var episodes = await spotify.episodes
      .list(['2TkVS48EgJwFUMiH8UwqGL', '4Bje2xtE4VxqO2HO1PQdsG']);
  for (final episode in episodes) {
    print('${episode.name} - ${episode.show?.name}');
  }
}

Future<void> _savedEpisodes(SpotifyApi spotify) async {
  print('Users saved episodes:');

  var episodes = spotify.me.savedEpisodes().stream();
  await for (final page in episodes) {
    var names = page.items?.map((e) => e.name).join(', ');
    print(names);
  }
}

Future<void> _saveAndRemoveEpisode(spotify) async {
  print('Saving episode with id 4Bje2xtE4VxqO2HO1PQdsG');
  await spotify.me.saveShows(['4Bje2xtE4VxqO2HO1PQdsG']);
  var saved = await spotify.me.containsSavedShows(['4Bje2xtE4VxqO2HO1PQdsG']);
  print('Checking is 4Bje2xtE4VxqO2HO1PQdsG is in saved shows...');
  print(saved);
  print('Removing show wish id 4Bje2xtE4VxqO2HO1PQdsG');
  await spotify.me.removeShows(['4Bje2xtE4VxqO2HO1PQdsG']);
  print('Checking is 4Bje2xtE4VxqO2HO1PQdsG is in saved shows...');
  saved = await spotify.me.containsSavedShows(['4Bje2xtE4VxqO2HO1PQdsG']);
  print(saved);
}

Future<Playlist> _createPrivatePlaylist(SpotifyApi spotify) async {
  var userId = (await spotify.me.get()).id;
  var name = 'My awesome playlist';
  print('Creating dummy Playlist with name \'$name\'');

  var playlist =
      await spotify.playlists.createPlaylist(userId ?? '', name, public: false);
  await spotify.playlists.addTracks([
    'spotify:track:34HKskUook8LY2JFy6e4Ob',
    'spotify:track:0F0MA0ns8oXwGw66B2BSXm'
  ], playlist.id ?? '');
  return playlist;
}

Future<void> _removePrivatePlaylist(
    SpotifyApi spotify, String playlistId) async {
  print('Removing playlist $playlistId');
  await spotify.playlists.unfollowPlaylist(playlistId);
}

Future<void> _clearPlaylist(SpotifyApi spotify) async {
  print('Clearing Playlist');
  var playlist = await _createPrivatePlaylist(spotify);
  var tracks = await _getPlaylistTracks(spotify, playlist.id ?? '');
  print('Tracks before: ${tracks.map((e) => e.name)}');

  await spotify.playlists.clear(playlist.id ?? '');

  tracks = await _getPlaylistTracks(spotify, playlist.id ?? '');
  print('Tracks after: ${tracks.map((e) => e.name)}');

  await _removePrivatePlaylist(spotify, playlist.id ?? '');
}

Future<void> _reorderItemsInPlaylist(SpotifyApi spotify) async {
  print('Reordering Playlist');
  var playlist = await _createPrivatePlaylist(spotify);
  var playlistId = playlist.id ?? '';
  var tracks = await _getPlaylistTracks(spotify, playlistId);
  print('Tracks before: ${tracks.map((e) => e.name)}');

  // reorders the first element to the end of the playlist
  await spotify.playlists
      .reorder(playlistId, rangeStart: 0, insertBefore: tracks.length);

  tracks = await _getPlaylistTracks(spotify, playlistId);
  print('Tracks after: ${tracks.map((e) => e.name)}');

  await _removePrivatePlaylist(spotify, playlist.id ?? '');
}

Future<void> _replaceItemsInPlaylist(SpotifyApi spotify) async {
  print('Replacing Playlist');
  var playlist = await _createPrivatePlaylist(spotify);
  var playlistId = playlist.id ?? '';
  var tracks = await _getPlaylistTracks(spotify, playlistId);
  print('Tracks before: ${tracks.map((e) => e.name)}');

  // replaces the whole playlist with only the first item
  await spotify.playlists.replace(playlistId, [tracks.first.uri ?? '']);

  tracks = await _getPlaylistTracks(spotify, playlistId);
  print('Tracks after: ${tracks.map((e) => e.name)}');

  await _removePrivatePlaylist(spotify, playlist.id ?? '');
}

Future<Iterable<Track>> _getPlaylistTracks(
    SpotifyApi spotify, String playlistId) async {
  var tracksPage = spotify.playlists.getTracksByPlaylistId(playlistId);
  return (await tracksPage.first()).items ?? [];
}

FutureOr<Null> _prettyPrintError(Object error) {
  if (error is SpotifyException) {
    print('${error.status} : ${error.message}');
  } else {
    print(error);
  }
}
