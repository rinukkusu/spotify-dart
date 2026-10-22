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

  /// Parses a URI of the form `spotify:<type>:<id>`.
  ///
  /// Throws [FormatException] for malformed or unsupported URI formats.
  factory SpotifyUri.parse(String value) {
    final uri = SpotifyUri.tryParse(value);
    if (uri == null) {
      throw FormatException('Malformed or unsupported Spotify URI', value);
    }
    return uri;
  }

  /// Parses a supported URI, returning `null` for malformed, unsupported,
  /// or non-string values.
  static SpotifyUri? tryParse(Object? value) {
    if (value is! String || !value.startsWith('spotify:')) {
      return null;
    }
    final separator = value.indexOf(':', 8);
    if (separator < 0) {
      return null;
    }
    final type = UriType.values.asNameMap()[value.substring(8, separator)];
    final id = value.substring(separator + 1);
    if (type == null || id.isEmpty || _invalidIdCharacters.hasMatch(id)) {
      return null;
    }
    return switch (type) {
      UriType.album => AlbumUri(id),
      UriType.artist => ArtistUri(id),
      UriType.audiobook => AudiobookUri(id),
      UriType.episode => EpisodeUri(id),
      UriType.playlist => PlaylistUri(id),
      UriType.show => ShowUri(id),
      UriType.track => TrackUri(id),
      UriType.user => UserUri(id),
    };
  }

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
