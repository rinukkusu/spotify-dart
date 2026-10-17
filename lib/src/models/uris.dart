// Copyright (c) 2026, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '_models.dart';

/// Checks whethes thi given [uri] has the valid format of `spotify:<type>:<id>`
final _invalidIdCharacters = RegExp(r'[\s:/?#,\\\x00-\x1F\x7F]');

bool isValidUri(SpotifyUri uri) => uri.id.isNotEmpty && !_invalidIdCharacters.hasMatch(uri.id);

/// Base class for a spotify uri of the format `spotify:<type>:<id>`.
///
/// See [UriType] for valid types.
abstract class SpotifyUri {
  final String id;

  final UriType _type;

  SpotifyUri(this.id, this._type);

  @override
  String toString() => 'spotify:${_type.name}:$id';

  @override
  bool operator ==(Object other) {
    if (other is! SpotifyUri) {
      return false;
    }
    final SpotifyUri otherUri = other;
    if (id == otherUri.id && _type == otherUri._type) {
      return true;
    }
    return false;
  }

  @override
  int get hashCode => id.hashCode ^ _type.name.hashCode;
}

final class ArtistUri extends SpotifyUri {
  ArtistUri(String id) : super(id, UriType.artist);
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
  artist,
  playlist,
  episode,
  show,
  user,
  audiobook,
  track,
  album;
}
