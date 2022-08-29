// Copyright (c) 2017, 2020 rinukkusu, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:convert';
import 'package:spotify/spotify.dart';

void main() async {
  var keyJson = await File('example/.apikeys').readAsString();
  var keyMap = json.decode(keyJson);

  var credentials = SpotifyApiCredentials(keyMap['id'], keyMap['secret']);
  var spotify = SpotifyApi(credentials);

  print('\nPodcast:');
  await spotify.shows
      .get('4rOoJ6Egrf8K2IrywzwOMk')
      .then((podcast) => print(podcast.toString()))
      .onError(
          (error, stackTrace) => print((error as SpotifyException).message));

  print('\nPodcast episode:');
  var episodes = spotify.shows.episodes('4AlxqGkkrqe0mfIx3Mi7Xt');
  await episodes.first().then((first) => print(first.items!.first)).onError(
      (error, stackTrace) => print((error as SpotifyException).message));

  print('\nArtists:');
  var artists = await spotify.artists.list(['0OdUWJ0sBjDrqHygGUXeCF']);
  artists.forEach((Artist artist) => print(artist.toString()));

  print('\nAlbum:');
  var album = await spotify.albums.get('2Hog1V8mdTWKhCYqI5paph');
  print(album.toString());

  print('\nAlbum Tracks:');
  var tracks = await spotify.albums.getTracks(album.id!).all();
  tracks.forEach((TrackSimple track) => print(track.toString()));

  print('\nFeatured Playlist:');
  var featuredPlaylists = await spotify.playlists.featured.all();
  featuredPlaylists
      .forEach((PlaylistSimple playlist) => print(playlist.toString()));

  print('\nUser\'s playlists:');
  var usersPlaylists =
      await spotify.playlists.getUsersPlaylists('superinteressante').all();
  usersPlaylists
      .forEach((PlaylistSimple playlist) => print(playlist.toString()));

  print("\nSearching for \'Metallica\':");
  var search = await spotify.search
      .get('metallica')
      .first(2)
      .catchError((err) => print((err as SpotifyException).message));

  if (search == null) {
    return;
  }
  search.forEach((pages) {
    pages.items!.forEach((item) => print(item.toString()));
  });

  var relatedArtists =
      await spotify.artists.relatedArtists('0OdUWJ0sBjDrqHygGUXeCF');
  print('\nRelated Artists: ${relatedArtists.length}');

  credentials = await spotify.getCredentials();
  print('\nCredentials:');
  print(credentials.toString());
}
