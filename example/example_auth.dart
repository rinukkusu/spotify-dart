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
  AuthorizationScope.follow.read,
];

void main() async {
  final keyMap = await _getApiKeys();

  final credentials = SpotifyApiCredentials(keyMap.key, keyMap.value);
  final spotify = await _getUserAuthenticatedSpotifyApi(credentials);
  if (spotify == null) {
    exit(0);
  }
  await _user(spotify);
  await _play(spotify);
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
  final keyJson = await File('example/.apikeys').readAsString();
  final keyMap = json.decode(keyJson);
  return MapEntry(keyMap['id'], keyMap['secret']);
}

Future<SpotifyApi?> _getUserAuthenticatedSpotifyApi(
  SpotifyApiCredentials credentials,
) async {
  print(
    'Please paste your redirect url (from your spotify application\'s '
    'redirect URL):',
  );
  final redirect = stdin.readLineSync();

  // Note: For public clients (mobile/web apps), use PKCE instead:
  // final verifier = SpotifyApi.generateCodeVerifier();
  // final pkceCredentials = SpotifyApiCredentials.pkce(
  //   clientId,
  //   codeVerifier: verifier,
  // );
  // final grant = SpotifyApi.authorizationCodeGrant(pkceCredentials);
  // See example/example_pkce.dart for a complete PKCE example.

  final grant = SpotifyApi.authorizationCodeGrant(credentials);
  final authUri = grant.getAuthorizationUrl(Uri.parse(redirect!), scopes: _scopes);

  print(
    'Please paste this URL \n\n$authUri\n\nto your browser and enter the '
    'redirected URL:',
  );

  Uri? redirectUrl;
  final userInput = stdin.readLineSync();
  if (userInput == null || (redirectUrl = Uri.tryParse(userInput)) == null) {
    print('Invalid redirect url');
    return null;
  }

  final client = await grant.handleAuthorizationResponse(redirectUrl!.queryParameters);
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
    final buffer = StringBuffer();
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

Future<void> _devices(SpotifyApi spotify) async => await spotify.player.devices().then((Iterable<Device>? devices) {
      if (devices == null || devices.isEmpty) {
        print('No devices currently playing.');
        return;
      }
      print('Listing ${devices.length} available devices:');
      print(devices.map((device) => device.name).join(', '));
    }).catchError(_prettyPrintError);

Future<void> _followingArtists(SpotifyApi spotify) async {
  final cursorPage = spotify.me.following(FollowingType.artist);
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
    final lists = playlists.map((playlist) => playlist.name).join(', ');
    print('Playlists: $lists');
  }).catchError(_prettyPrintError);
}

Future<void> _savedTracks(SpotifyApi spotify) async {
  final stream = spotify.me.tracks.saved().stream();
  print('Saved Tracks:\n');
  await for (final page in stream) {
    final items = page.items?.map((e) => e.track?.name).join(', ');
    print(items);
  }
}

Future<void> _recentlyPlayed(SpotifyApi spotify) async {
  final stream = spotify.me.recentlyPlayed().stream();
  await for (final page in stream) {
    final items = page.items?.map((e) => e.track?.name).join(', ');
    print(items);
  }
}

Future<void> _getShow(SpotifyApi spotify) async {
  const showId = '3kbLJJLzRGsAKESODPSbiB';
  final response = await spotify.shows.get(showId);
  print(response.name);
}

Future<void> _listShows(SpotifyApi spotify) async {
  const showId = '3kbLJJLzRGsAKESODPSbiB';
  final response = await spotify.shows.list([showId]);
  for (final show in response) {
    print(show.name);
  }
}

Future<void> _savedShows(SpotifyApi spotify) async {
  print('Users saved shows');
  final response = spotify.me.savedShows().stream();
  await for (final page in response) {
    final names = page.items?.map((e) => e.name).join(', ');
    print(names);
  }
}

Future<void> _saveAndRemoveShow(SpotifyApi spotify) async {
  const showId = '4XPl3uEEL9hvqMkoZrzbx5';

  print('Saving show with id $showId');
  await spotify.me.saveShows([showId]);
  var saved = await spotify.me.containsSavedShows([showId]);
  print('Checking is $showId is in saved shows...');
  print(saved);
  print('Removing show wish id $showId');
  await spotify.me.removeShows([showId]);
  print('Checking is $showId is in saved shows...');
  saved = await spotify.me.containsSavedShows([showId]);
  print(saved);
}

Future<void> _getEpisode(SpotifyApi spotify) async {
  const episodeId = '2TkVS48EgJwFUMiH8UwqGL';

  print('\nRetriving Information about episode with id $episodeId');
  final episode = await spotify.episodes.get(episodeId);
  print('${episode.name} - ${episode.show?.name}');
}

Future<void> _listEpisodes(SpotifyApi spotify) async {
  const episodeIds = ['2TkVS48EgJwFUMiH8UwqGL', '4Bje2xtE4VxqO2HO1PQdsG'];

  print('\nRetriving Information about episodes $episodeIds');
  final episodes = await spotify.episodes.list(episodeIds);
  for (final episode in episodes) {
    print('${episode.name} - ${episode.show?.name}');
  }
}

Future<void> _savedEpisodes(SpotifyApi spotify) async {
  print('Users saved episodes:');

  final episodes = spotify.me.savedEpisodes().stream();
  await for (final page in episodes) {
    final names = page.items?.map((e) => e.name).join(', ');
    print(names);
  }
}

Future<void> _saveAndRemoveEpisode(SpotifyApi spotify) async {
  const episodeId = '4Bje2xtE4VxqO2HO1PQdsG';

  print('Saving episode with id $episodeId');
  await spotify.me.saveShows([episodeId]);
  var saved = await spotify.me.containsSavedShows([episodeId]);
  print('Checking is $episodeId is in saved shows...');
  print(saved);
  print('Removing show wish id $episodeId');
  await spotify.me.removeShows([episodeId]);
  print('Checking is $episodeId is in saved shows...');
  saved = await spotify.me.containsSavedShows([episodeId]);
  print(saved);
}

Future<Playlist> _createPrivatePlaylist(SpotifyApi spotify) async {
  const name = 'My awesome playlist';
  const trackIds = ['34HKskUook8LY2JFy6e4Ob', '0F0MA0ns8oXwGw66B2BSXm'];

  final userId = (await spotify.me.get()).id;
  print('Creating dummy Playlist with name \'$name\'');

  final playlist = await spotify.playlists.createPlaylist(
    userId ?? '',
    name,
    public: false,
  );

  await spotify.playlists.addTracks(
    [for (final trackId in trackIds) 'spotify:track:$trackId'],
    playlist.id ?? '',
  );
  return playlist;
}

Future<void> _removePrivatePlaylist(
  SpotifyApi spotify,
  String playlistId,
) async {
  print('Removing playlist $playlistId');
  await spotify.playlists.unfollowPlaylist(playlistId);
}

Future<void> _clearPlaylist(SpotifyApi spotify) async {
  print('Clearing Playlist');
  final playlist = await _createPrivatePlaylist(spotify);
  var playlistTracks = await _getPlaylistTracks(spotify, playlist.id ?? '');
  print('Tracks before: ${playlistTracks.map((e) => e.track!.name)}');

  await spotify.playlists.clear(playlist.id ?? '');

  playlistTracks = await _getPlaylistTracks(spotify, playlist.id ?? '');
  print('Tracks after: ${playlistTracks.map((e) => e.track!.name)}');

  await _removePrivatePlaylist(spotify, playlist.id ?? '');
}

Future<void> _reorderItemsInPlaylist(SpotifyApi spotify) async {
  print('Reordering Playlist');
  final playlist = await _createPrivatePlaylist(spotify);
  final playlistId = playlist.id ?? '';
  var playlistTracks = await _getPlaylistTracks(spotify, playlistId);
  print('Tracks before: ${playlistTracks.map((e) => e.track!.name)}');

  // reorders the first element to the end of the playlist
  await spotify.playlists.reorder(playlistId, rangeStart: 0, insertBefore: playlistTracks.length);

  playlistTracks = await _getPlaylistTracks(spotify, playlistId);
  print('Tracks after: ${playlistTracks.map((e) => e.track!.name)}');

  await _removePrivatePlaylist(spotify, playlist.id ?? '');
}

Future<void> _replaceItemsInPlaylist(SpotifyApi spotify) async {
  print('Replacing Playlist');
  final playlist = await _createPrivatePlaylist(spotify);
  final playlistId = playlist.id ?? '';
  var playlistTracks = await _getPlaylistTracks(spotify, playlistId);
  print('Tracks before: ${playlistTracks.map((e) => e.track!.name)}');

  // replaces the whole playlist with only the first item
  await spotify.playlists.replace(playlistId, [playlistTracks.first.track!.uri ?? '']);

  playlistTracks = await _getPlaylistTracks(spotify, playlistId);
  print('Tracks after: ${playlistTracks.map((e) => e.track!.name)}');

  await _removePrivatePlaylist(spotify, playlist.id ?? '');
}

Future<Iterable<PlaylistTrack>> _getPlaylistTracks(
  SpotifyApi spotify,
  String playlistId,
) async {
  final tracksPage = spotify.playlists.getPlaylistTracks(playlistId);
  return (await tracksPage.first()).items ?? [];
}

Future<PlaybackState?> _play(SpotifyApi spotify) async {
  const trackIds = ['6zW80jVqLtgSF1yCtGHiiD', '4VnDmjYCZkyeqeb0NIKqdA'];
  const albumId = '0rwbMKjNkp4ehQTwf9V2Jk';

  var track = await spotify.tracks.get(trackIds.first);
  print(
    'Playing "${track.name} - ${track.artists?.first.name}" '
    'with track context for 10 s',
  );
  var result = await spotify.player.startWithTracks(
    ['spotify:track:${trackIds.first}?si=99fd66ccb2464bad'],
    positionMs: 10000,
  );
  sleep(const Duration(seconds: 10));
  print('Pausing...');
  spotify.player.pause();
  final album = await spotify.albums.get(albumId);
  track = await spotify.tracks.get(trackIds.last);
  print(
    'Playing album "${album.name} - ${album.artists?.first.name}" '
    'with uri context',
  );
  print(
    'and offset to "${track.name} - ${track.artists?.first.name}" for 10 s',
  );
  result = await spotify.player.startWithContext(
    'spotify:album:$albumId?si=HA-mX2mPQ1CUp7ExfdDt2g',
    offset: UriOffset('spotify:track:${trackIds.last}'),
  );
  sleep(const Duration(seconds: 10));

  return result;
}

FutureOr<Null> _prettyPrintError(Object error) {
  if (error is SpotifyException) {
    print('${error.status} : ${error.message}');
  } else {
    print(error);
  }
}
