// Copyright (c) 2026, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

final _validUriTypes = _UriType.values.map((t) => t.name);

// ignore: prefer_interpolation_to_compose_strings
bool isValidUri(SpotifyUri uri) =>
    uri.toString().matchAsPrefix(r'spotify:(?:' + _validUriTypes.join('|') + '):*') != null;

/// Base class for a spotify uri of the format `spotify:<type>:<id>`
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
  String get type => _UriType.track.name;
}

final class AudiobookUri extends SpotifyUri {
  AudiobookUri(super.id);
  @override
  String get type => _UriType.audiobook.name;
}

final class UserUri extends SpotifyUri {
  UserUri(super.id);
  @override
  String get type => _UriType.user.name;
}

final class ShowUri extends SpotifyUri {
  ShowUri(super.id);

  @override
  String get type => _UriType.show.name;
}

final class PlaylistUri extends SpotifyUri {
  PlaylistUri(super.id);
  @override
  String get type => _UriType.playlist.name;
}

final class EpisodeUri extends SpotifyUri {
  EpisodeUri(super.id);
  @override
  String get type => _UriType.episode.name;
}

final class AlbumUri extends SpotifyUri {
  AlbumUri(super.id);

  @override
  String get type => _UriType.playlist.name;
}

enum _UriType {
  playlist('playlist'),
  episode('episode'),
  show('show'),
  user('user'),
  audiobook('audiobook'),
  track('track');

  final String name;

  const _UriType(this.name);
}
