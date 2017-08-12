// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:convert';
import '../lib/spotify_io.dart';
import '../lib/spotify_io.json.g.dart';

main() async {
  var keyJson = await new File('.apikeys').readAsString();
  var keyMap = JSON.decode(keyJson);

  var credentials = new SpotifyApiCredentials(keyMap['id'], keyMap['secret']);
  var spotify = new SpotifyApi(credentials);

  var artist = await spotify.artists.get('0OdUWJ0sBjDrqHygGUXeCF');

  print(ArtistMapper.toJson(artist));
}
