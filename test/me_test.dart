import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  var spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('User', () {
    test('currentlyPlaying', () async {
      var result = await spotify.player.currentlyPlaying();

      expect(result.item!.name, 'As I Am');
    });

    test('Devices', () async {
      var result = await spotify.player.devices();
      expect(result.length, 2);
      expect(result.first.id, '5fbb3ba6aa454b5534c4ba43a8c7e8e45a63ad0e');
      expect(result.first.isActive, true);
      expect(result.first.isRestricted, true);
      expect(result.first.isPrivateSession, true);
      expect(result.first.name, 'My fridge');
      expect(result.first.type, DeviceType.Computer);
      expect(result.first.volumePercent, 100);

      // the second entry does not have a valid [DeviceType],
      // and should have `Unknown` instead.
      expect(result.last.type, DeviceType.Unknown);
    });

    test('recentlyPlayed', () async {
      // the parameters don't do anything. They are just dummies
      var result = await spotify.me
          .recentlyPlayed(limit: 3, before: DateTime.now())
          .all();
      expect(result.length, 2);
      var first = result.first;
      expect(first.track != null, true);

      // just testing some sample attributes
      var firstTrack = first.track;
      expect(firstTrack!.durationMs, 108546);
      expect(firstTrack.explicit, false);
      expect(firstTrack.id, '2gNfxysfBRfl9Lvi9T3v6R');
      expect(firstTrack.artists!.length, 1);
      expect(firstTrack.artists!.first.name, 'Tame Impala');

      // test album and popularity fields (Track instead of TrackSimple)
      expect(firstTrack.album != null, true);
      expect(firstTrack.album!.name, 'Currents');
      expect(firstTrack.album!.id, '79dL7FLiJFOO0EoehUHQBv');
      expect(firstTrack.popularity, 75);

      var second = result.last;
      expect(second.playedAt, DateTime.tryParse('2016-12-13T20:42:17.016Z'));
      expect(second.context!.uri, 'spotify:artist:5INjqkS1o8h1imAzPqGZBb');
    });

    test('getQueue', () async {
      var result = await spotify.player.queue();
      final currentlyPlaying = result.currentlyPlaying;
      final queue = result.queue;

      expect(currentlyPlaying, isNotNull);
      expect(queue, isNotNull);

      // Checking the currentlyPlaying data

      expect(currentlyPlaying!.name, 'string');

      // Checking the queue data

      expect(queue!.length == 1, true);
      expect(queue.first.name, 'string');
    });

    test('following', () async {
      var result = spotify.me.following(FollowingType.artist);

      var first = await result.first();
      expect(first.items!.length, 1);

      var firstArtist = first.items!.first;
      expect(firstArtist.name, 'Afasi & Filthy');
      expect(firstArtist.popularity, 54);
      expect(first.after, '0aV6DOiouImYTqrR5YlIqx');
    });

    test('checkFollowing', () async {
      final result = await spotify.me.checkFollowing(FollowingType.artist, [
        '2CIMQHirSU0MQqyYHq0eOx',
        '57dN52uHvrHOxijzpIgu3E',
        '1vCWHaC5f2uS3yhpwWbIA6'
      ]);
      expect(result.isNotEmpty, isTrue);
      expect(result['2CIMQHirSU0MQqyYHq0eOx'], isTrue);
      expect(result['57dN52uHvrHOxijzpIgu3E'], isFalse);
      expect(result['1vCWHaC5f2uS3yhpwWbIA6'], isTrue);
    });

    group('me/top', () {
      test('tracks', () async {
        final result = await spotify.me.topTracks().first();
        expect(result.items?.length, 2);

        var firstItem = result.items?.first;
        expect(firstItem?.album?.albumType, AlbumType.album);
        expect(firstItem?.album?.name, 'Ali');
        expect(firstItem?.album?.uri, 'spotify:album:4dfAJiDQHQf4dGX0ZdtxPh');
        expect(firstItem?.artists?.length, 2);
        expect(firstItem?.artists?.first.name, 'Vieux Farka Touré');
      });

      test('artists', () async {
        final result = await spotify.me.topArtists().first();
        expect(result.items?.length, 2);

        var firstItem = result.items?.first;
        expect(firstItem?.name, 'Porcupine Tree');
      });
    });

    group('me/shows', () {
      test('savedShows', () async {
        var pages = spotify.me.savedShows();
        var result = await pages.first(2);
        expect(result.items!.length, 2);

        var firstShow = result.items!.first;
        expect(firstShow.type, 'show');
        expect(firstShow.name != null, true);
        expect(firstShow.id, '4XPl3uEEL9hvqMkoZrzbx5');
      });

      test('containsShows', () async {
        var response = await spotify.me.containsSavedShows(['one', 'two']);
        expect(response.isNotEmpty, true);
        expect(response['one'], true);
        expect(response['two'], false);
      });
    });

    group('me/albums', () {
      test('savedAlbums', () async {
        final albums = await spotify.me.savedAlbums().getPage(10, 0);
        expect(albums.items?.length, 2);
        expect(albums.isLast, true);
        expect(albums.items?.every((item) => item is Album), isTrue);
      });

      test('containsSavedAlbums', () async {
        final albumIds = [
          '382ObEPsp2rxGrESizN5TX',
          '1A2GTWGtFfWp7KSQTwWOyo',
          '2noRn2Aes5aoNVsU6iWThc'
        ];

        final list = await spotify.me.containsSavedAlbums(albumIds);

        expect(list.length, 3);
        expect(list[albumIds[0]], isTrue);
        expect(list[albumIds[1]], isFalse);
        expect(list[albumIds[2]], isTrue);
      });
    });

    group('me/episodes', () {
      test('savedEpisodes', () async {
        var pages = spotify.me.savedEpisodes();
        var result = await pages.first(2);
        expect(result.items!.length, 1);

        var firstEpisode = result.items!.first;
        expect(firstEpisode.type, 'episode');
        expect(firstEpisode.name, isNotNull);
        expect(firstEpisode.id, '5Xt5DXGzch68nYYamXrNxZ');
        expect(firstEpisode.show, isNotNull);
      });

      test('containsSavedEpisodes', () async {
        final episodeIds = [
          '5Xt5DXGzch68nYYamXrNxZ',
          '1A2GTWGtFfWp7KSQTwWOyo',
          '2noRn2Aes5aoNVsU6iWThc'
        ];

        final list = await spotify.me.containsSavedEpisodes(episodeIds);

        expect(list.length, 3);
        expect(list[episodeIds[0]], isTrue);
        expect(list[episodeIds[1]], isFalse);
        expect(list[episodeIds[2]], isFalse);
      });
    });
  });
}
