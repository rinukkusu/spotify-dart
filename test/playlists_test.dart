import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

// ignore_for_file: deprecated_member_use_from_same_package

Future main() async {
  var spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Playlists', () {
    test('getUsersPlaylists', () async {
      var playlists = spotify.playlists.getUsersPlaylists('X123Y');
      var firstPage = (await playlists.first());
      expect(firstPage.metadata.href,
          'https://api.spotify.com/v1/users/superinteressante/playlists?offset=0&limit=20');
      var items = firstPage.items!;
      expect(items.length, 2);
      expect(items.first.id, '1XIAxOGAEK2h4ravpNTmYF');
      expect(items.first.href,
          'https://api.spotify.com/v1/playlists/1XIAxOGAEK2h4ravpNTmYF');
      expect(items.first.name, 'Hot News @ Melhores Eletrônicas 2022');
    });

    test('Get Playlist images', () async {
      var images = await spotify.playlists.images('1XIAxOGAEK2h4ravpNTmYF');
      expect(images.length, 1);
      var firstImage = images.first;
      expect(firstImage.url,
          'https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228');
      expect(firstImage.height, 300);
      expect(firstImage.width, 300);
    });

    test('followedByUsers', () async {
      var result = await spotify.playlists
          .followedByUsers('1XIAxOGAEK2h4ravpNTmYF', ['1', '2', '3']);

      expect(result.length, 3);
      expect(result['1'], isTrue);
      expect(result['2'], isFalse);
      expect(result['3'], isTrue);
    });

    test('getTracksByPlaylistId', () async {
      final tracks = await spotify.playlists
          .getTracksByPlaylistId('1XIAxOGAEK2h4ravpNTmYF')
          .all();

      expect(tracks, hasLength(2));
      expect(
        tracks.elementAt(0),
        isA<Track>().having((t) => t.id, 'id', 'track-1'),
      );
      expect(
        tracks.elementAt(1),
        isA<Track>().having((t) => t.id, 'id', 'track-3'),
      );
    });

    test('getPlaylistTracks', () async {
      final tracks = await spotify.playlists
          .getPlaylistTracks('1XIAxOGAEK2h4ravpNTmYF')
          .all();
      expect(tracks, hasLength(2));
      expect(
        tracks.elementAt(0),
        isA<PlaylistTrack>().having(
          (p) => p.track,
          'track',
          isA<Track>().having((t) => t.id, 'id', 'track-1'),
        ),
      );
      expect(
        tracks.elementAt(1),
        isA<PlaylistTrack>().having((p) => p.track, 'track',
            isA<Track>().having((t) => t.id, 'id', 'track-3')),
      );
    });
  });
}
