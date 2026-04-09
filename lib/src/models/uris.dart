// Copyright (c) 2026, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

final _validUriTypes = [
  'track',
  'audiobook',
  'album',
  'user',
  'show',
  'playlist',
  'episode',
];

// ignore: prefer_interpolation_to_compose_strings
bool isValidUri(SpotifyUri uri) =>
    uri.toString().matchAsPrefix(r'spotify:(?:' + _validUriTypes.join('|') + '):*') != null;

abstract class SpotifyUri {
  final String id;

  String get type;

  SpotifyUri(this.id);

  @override
  String toString() => 'spotify:$type:$id';
}

final class TrackUri extends SpotifyUri {
  TrackUri(super.id);

  @override
  String get type => 'track';
}

final class AudiobookUri extends SpotifyUri {
  AudiobookUri(super.id);
  @override
  String get type => 'audiobook';
}

final class UserUri extends SpotifyUri {
  UserUri(super.id);
  @override
  String get type => 'user';
}

final class ShowUri extends SpotifyUri {
  ShowUri(super.id);

  @override
  String get type => 'show';
}

final class PlaylistUri extends SpotifyUri {
  PlaylistUri(super.id);
  @override
  String get type => 'playlist';
}

final class EpisodeUri extends SpotifyUri {
  EpisodeUri(super.id);
  @override
  String get type => 'episode';
}

final class AlbumUri extends SpotifyUri {
  AlbumUri(super.id);

  @override
  String get type => 'album';
}
