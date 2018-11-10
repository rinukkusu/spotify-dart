// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:convert';
import '../lib/spotify_io.dart';

main() async {
  var keyJson = await new File('example/.apikeys').readAsString();
  var keyMap = json.decode(keyJson);

  var credentials = new SpotifyApiCredentials(keyMap['id'], keyMap['secret']);
  var spotify = new SpotifyApi(credentials);

  print("Artists:");
  var artists = await spotify.artists.list(['0OdUWJ0sBjDrqHygGUXeCF']);
  artists.forEach((x) => print(x.name));

  print("\nAlbum:");
  var album = await spotify.albums.get('2Hog1V8mdTWKhCYqI5paph');
  print(album.name);

  print("\nAlbum Tracks:");
  var tracks = await spotify.albums.getTracks(album.id).all();
  tracks.forEach((track) {
    print(track.name);
  });

  print("\nFeatured Playlist:");
  var featuredPlaylists = await spotify.playlists.featured.all();
  featuredPlaylists.forEach((playlist) {
    print(playlist.name);
  });

  print("\nSearching for \'Metallica\':");
  var search = await spotify.search.get("metallica", SearchType.all).firsts();
  search.forEach((pages) {
    pages.items.forEach((item) {
      if (item is PlaylistSimple) {
        print("Playlist: ${item.name}");
      }
      if (item is ArtistSimple) {
        print("Artist ${item.name}");
      }
      if (item is Track) {
        print("Track ${item.name}");
      }
      if (item is Album) {
        print("Album ${item.name}");
      }
    });
  });
  exit(0);
}
