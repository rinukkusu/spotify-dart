// Copyright (c) 2020 hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:spotify/spotify.dart';

void main() async {
  var keyJson = await File('example/.apikeys').readAsString();
  var keyMap = json.decode(keyJson);

  var credentials = SpotifyApiCredentials(keyMap['id'], keyMap['secret']);
  var spotify = await _getUserAuthenticatedSpotifyApi(credentials);
  if (spotify == null) {
    exit(0);
  }
  await _currentlyPlaying(spotify);
  await _devices(spotify);
  //await _createPrivatePlaylist(spotify);

  exit(0);
}

Future<SpotifyApi> _getUserAuthenticatedSpotifyApi(
    SpotifyApiCredentials credentials) async {
  print(
      'Please paste your redirect url (from your spotify application\'s redirect url):');
  var redirect = stdin.readLineSync();

  var grant = SpotifyApi.authorizationCodeGrant(credentials);
  var authUri = grant.getAuthorizationUrl(Uri.parse(redirect),
      scopes: ['user-read-playback-state', 'playlist-modify-private']);

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

void _currentlyPlaying(SpotifyApi spotify) async =>
    await spotify.me.currentlyPlaying().then((a) {
      if (a == null) {
        print('Nothing currently playing.');
        return;
      }
      print('Currently playing: ${a.item?.name}');
    }).catchError(_prettyPrintError);

void _devices(SpotifyApi spotify) async =>
    await spotify.me.devices().then((devices) {
      if (devices == null) {
        print('No devices currently playing.');
        return;
      }
      print('Listing ${devices.length} available devices:');
      print(devices.map((device) => device.name).join(', '));
    }).catchError(_prettyPrintError);

void _createPrivatePlaylist(SpotifyApi spotify) async {
  var user = await spotify.me.get();
  await spotify.playlists
      .createPlaylist(
    user.id,
    'Cool New Playlist 2',
    description: 'Songs to test by',
    public: false,
  )
      .then((playlist) {
    print('Private playlist created!');
  }).catchError(_prettyPrintError);
}

dynamic _prettyPrintError(Object error) {
  if (error is SpotifyException) {
    print('${error.status} : ${error.message}');
  } else {
    print(error);
  }
}
