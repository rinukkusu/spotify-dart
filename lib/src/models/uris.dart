// Copyright (c) 2026, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

final _validUriTypes = UriType.values.map((t) => t.name);

// ignore: prefer_interpolation_to_compose_strings
/// Checks whethes thi given [uri] has the valid format of `spotify:<type>:<id>`
bool isValidUri(SpotifyUri uri) =>
    uri.toString().matchAsPrefix(r'spotify:(?:' + _validUriTypes.join('|') + '):*') != null;

/// Base class for a spotify uri of the format `spotify:<type>:<id>`.
/// 
/// See [UriType] for valid types.
abstract class SpotifyUri {
  final String id;

  final UriType _type;

  SpotifyUri(this.id, this._type);

  @override
  String toString() => 'spotify:${_type.name}:$id';
}

final class TrackUri extends SpotifyUri {
  TrackUri(String id) : super(id, UriType.track);
}

final class AudiobookUri extends SpotifyUri {
  AudiobookUri(String id) : super(id, UriType.audiobook);
}

final class UserUri extends SpotifyUri {
  UserUri(String id) : super(id, UriType.user);
}

final class ShowUri extends SpotifyUri {
  ShowUri(String id) : super(id, UriType.show);
}

final class PlaylistUri extends SpotifyUri {
  PlaylistUri(String id) : super(id, UriType.playlist);
}

final class EpisodeUri extends SpotifyUri {
  EpisodeUri(String id) : super(id, UriType.episode);
}

final class AlbumUri extends SpotifyUri {
  AlbumUri(String id) : super(id, UriType.album);
}

/// Enum of valid types a [SpotifyUri] can have
enum UriType {
  playlist('playlist'),
  episode('episode'),
  show('show'),
  user('user'),
  audiobook('audiobook'),
  track('track'),
  album('album');

  final String name;

  const UriType(this.name);
}
