// Copyright (c) 2020 hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:spotify/spotify.dart';

const _scopes = [
  'user-read-playback-state',
  'user-follow-read',
  'playlist-modify-private',
  'user-modify-playback-state',
  'user-library-read',
  'user-read-recently-played'
];

void main() async {
  var keyJson = await File('example/.apikeys').readAsString();
  var keyMap = json.decode(keyJson);

  var credentials = SpotifyApiCredentials(keyMap['id'], keyMap['secret']);
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
  //await _createPrivatePlaylist(spotify);

  exit(0);
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
    await spotify.me.currentlyPlaying().then((Player? a) {
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
    await spotify.me.devices().then((Iterable<Device>? devices) {
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
  await spotify.me.shuffle(state).then((player) {
    print('Shuffle: ${player.isShuffling}');
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

Future<void> _createPrivatePlaylist(SpotifyApi spotify) async {
  var user = await spotify.me.get();
  await spotify.playlists
      .createPlaylist(
    user.id!,
    'Cool New Playlist 2',
    description: 'Songs to test by',
    public: false,
  )
      .then((playlist) {
    print('Private playlist created!');
  }).catchError(_prettyPrintError);
}

void _prettyPrintError(Object error) {
  if (error is SpotifyException) {
    print('${error.status} : ${error.message}');
  } else {
    print(error);
  }
}
