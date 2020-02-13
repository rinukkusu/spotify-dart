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
  var search = await spotify.search
      .get("metallica")
      .first(2)
      .catchError((err) => print((err as SpotifyException).message));
  if (search == null) {
    return;
  }
  search.forEach((pages) {
    pages.items.forEach((item) {
      if (item is PlaylistSimple) {
        print('Playlist: \n'
            'id: ${item.id}\n'
            'name: ${item.name}:\n'
            'collaborative: ${item.collaborative}\n'
            'href: ${item.href}\n'
            'trackslink: ${item.tracksLink.href}\n'
            'owner: ${item.owner}\n'
            'public: ${item.owner}\n'
            'snapshotId: ${item.snapshotId}\n'
            'type: ${item.type}\n'
            'uri: ${item.uri}\n'
            'images: ${item.images.length}\n'
            '-------------------------------');
      }
      if (item is Artist) {
        print('Artist: \n'
            'id: ${item.id}\n'
            'name: ${item.name}\n'
            'href: ${item.href}\n'
            'type: ${item.type}\n'
            'uri: ${item.uri}\n'
            '-------------------------------');
      }
      if (item is TrackSimple) {
        print('Track:\n'
            'id: ${item.id}\n'
            'name: ${item.name}\n'
            'href: ${item.href}\n'
            'type: ${item.type}\n'
            'uri: ${item.uri}\n'
            'isPlayable: ${item.isPlayable}\n'
            'artists: ${item.artists.length}\n'
            'availableMarkets: ${item.availableMarkets.length}\n'
            'discNumber: ${item.discNumber}\n'
            'trackNumber: ${item.trackNumber}\n'
            'explicit: ${item.explicit}\n'
            '-------------------------------');
      }
      if (item is AlbumSimple) {
        print('Album:\n'
            'id: ${item.id}\n'
            'name: ${item.name}\n'
            'href: ${item.href}\n'
            'type: ${item.type}\n'
            'uri: ${item.uri}\n'
            'albumType: ${item.albumType}\n'
            'artists: ${item.artists.length}\n'
            'availableMarkets: ${item.availableMarkets.length}\n'
            'images: ${item.images.length}\n'
            '-------------------------------');
      }
    });
  });

  var relatedArtists = await spotify.artists.relatedArtists('0OdUWJ0sBjDrqHygGUXeCF');
  print('related Artists: ${relatedArtists.length}');

  print('\nRefresh Token:');
  credentials = new SpotifyApiCredentials(keyMap['id'], keyMap['secret'], keyMap['refreshToken'] ?? null);
  spotify = new SpotifyApi(credentials);
  var recent = await spotify.users.recentlyPlayed(limit: 5);
  recent.forEach((history) {
    print('Played At: ${history.playedAt}\n'
        'Track:\n'
        'id: ${history.track.id}\n'
        'name: ${history.track.name}\n'
        'href: ${history.track.href}\n'
        'type: ${history.track.type}\n'
        'uri: ${history.track.uri}\n'
        'isPlayable: ${history.track.isPlayable}\n'
        'artists: ${history.track.artists.length}\n'
        'availableMarkets: ${history.track.availableMarkets.length}\n'
        'discNumber: ${history.track.discNumber}\n'
        'trackNumber: ${history.track.trackNumber}\n'
        'explicit: ${history.track.explicit}\n'
        '-------------------------------');
  });

  exit(0);
}
