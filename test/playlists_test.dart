import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

// ignore_for_file: deprecated_member_use_from_same_package

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Playlists', () {
    test('addTrack returns snapshot ID', () async {
      await expectLater(
        spotify.playlists.addTrack('spotify:track:track-1', '1XIAxOGAEK2h4ravpNTmYF'),
        completion('updated-snapshot-id'),
      );
    });

    test('addTracks returns snapshot ID', () async {
      await expectLater(
        spotify.playlists.addTracks(['spotify:track:track-1'], '1XIAxOGAEK2h4ravpNTmYF'),
        completion('updated-snapshot-id'),
      );
    });

    test('removeTrack returns snapshot ID', () async {
      await expectLater(
        spotify.playlists.removeTrack('spotify:track:track-1', '1XIAxOGAEK2h4ravpNTmYF'),
        completion('updated-snapshot-id'),
      );
    });

    test('removeTracks returns snapshot ID', () async {
      await expectLater(
        spotify.playlists.removeTracks(['spotify:track:track-1'], '1XIAxOGAEK2h4ravpNTmYF'),
        completion('updated-snapshot-id'),
      );
    });

    test('replace returns snapshot ID', () async {
      await expectLater(
        spotify.playlists.replace('1XIAxOGAEK2h4ravpNTmYF', ['spotify:track:track-1']),
        completion('updated-snapshot-id'),
      );
    });

    test('clear returns snapshot ID', () async {
      await expectLater(
        spotify.playlists.clear('1XIAxOGAEK2h4ravpNTmYF'),
        completion('updated-snapshot-id'),
      );
    });

    test('reorder returns snapshot ID', () async {
      await expectLater(
        spotify.playlists.reorder('1XIAxOGAEK2h4ravpNTmYF', rangeStart: 0, insertBefore: 2),
        completion('updated-snapshot-id'),
      );
    });

    test('Get Playlist images', () async {
      final images = await spotify.playlists.images('1XIAxOGAEK2h4ravpNTmYF');
      expect(images.length, 1);
      final firstImage = images.first;
      expect(
        firstImage.url,
        'https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228',
      );
      expect(firstImage.height, 300);
      expect(firstImage.width, 300);
    });

    test('getPlaylistTracks', () async {
      final tracks = await spotify.playlists.getPlaylistTracks('1XIAxOGAEK2h4ravpNTmYF').all();
      expect(tracks, hasLength(2));
      expect(
        tracks.elementAt(0),
        isA<PlaylistTrack>().having(
          (p) => p.item,
          'item',
          isA<Track>().having((t) => t.id, 'id', 'track-1'),
        ),
      );
      expect(
        tracks.elementAt(1),
        isA<PlaylistTrack>().having(
          (p) => p.item,
          'item',
          isA<Track>().having((t) => t.id, 'id', 'track-3'),
        ),
      );
    });
  });
}
