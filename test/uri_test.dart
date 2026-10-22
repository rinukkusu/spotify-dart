import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Uri', () {
    test('parses every supported type and preserves its string value', () {
      final uris = <SpotifyUri>[
        ArtistUri('artist'),
        TrackUri('track'),
        AudiobookUri('book'),
        UserUri('user'),
        ShowUri('show'),
        PlaylistUri('playlist'),
        EpisodeUri('episode'),
        AlbumUri('album'),
      ];
      for (final uri in uris) {
        final parsed = SpotifyUri.parse(uri.toString());
        expect(parsed, uri);
        expect(parsed.runtimeType, uri.runtimeType);
        expect(parsed.toString(), uri.toString());
      }
    });

    test('rejects malformed and unsupported strings without truncating them', () {
      for (final value in [
        '',
        'https:track:id',
        'spotify:track',
        'spotify:track:',
        'spotify:unknown:id',
        'spotify:track:id:extra',
        'spotify:track:two words',
        'spotify:track:id/path',
        'spotify:local:artist:album:track:123',
      ]) {
        expect(SpotifyUri.tryParse(value), isNull, reason: value);
        expect(() => SpotifyUri.parse(value), throwsFormatException, reason: value);
      }
    });

    test('URI parsing tolerates invalid JSON values', () {
      for (final value in <Object?>[null, '', 'bad', 'spotify:unknown:id', 12, true, {}, []]) {
        expect(SpotifyUri.tryParse(value), isNull);
      }
      expect(SpotifyUri.tryParse('spotify:track:id'), TrackUri('id'));
    });

    test('model decoding retains other fields when the URI is invalid', () {
      for (final value in <Object?>['bad', 'spotify:unknown:id', 42, {}]) {
        final track = Track.fromJson({'uri': value, 'name': 'Still available'});
        expect(track.uri, isNull);
        expect(track.name, 'Still available');
        expect(track.toJson(), isNot(contains('uri')));
      }
      final track = Track.fromJson({'uri': 'spotify:track:id'});
      expect(track.uri, TrackUri('id'));
      expect(track.toJson(), isNot(contains('uri')));
    });

    test('validate_correct', () {
      final uris = [
        AudiobookUri('1'),
        ShowUri('id'),
        TrackUri('id'),
        EpisodeUri('id'),
        AlbumUri('id'),
        UserUri('id'),
      ];
      for (final uri in uris) {
        expect(isValidUri(uri), true);
      }
    });
  });
}
