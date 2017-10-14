// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:convert';
import '../lib/spotify_io.dart';

main() async {
  var keyJson = await new File('example/.apikeys').readAsString();
  var keyMap = JSON.decode(keyJson);

  var credentials = new SpotifyApiCredentials(keyMap['id'], keyMap['secret']);
  var spotify = new SpotifyApi(credentials);

  var artists = await spotify.artists.list(['0OdUWJ0sBjDrqHygGUXeCF']);

  artists.forEach((x) => print(x.name));

  var album = await spotify.albums.get('6PEYvIrLYHJ8BvpE5uUChz');
  print(album.name);
}
