import 'dart:async';
import 'package:spotify/src/spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  var spotify = SpotifyApiMock(SpotifyApiCredentials(
    'clientId',
    'clientSecret',
  ));

  group('Albums', () {
    test('get', () async {
      var album = await spotify.albums.get('4aawyAB9vmqN3uQ7FjRGTy');

      expect(album.albumType, 'album');
      expect(album.id, '4aawyAB9vmqN3uQ7FjRGTy');
      expect(album.images!.length, 3);
      expect(album.releaseDatePrecision, DatePrecision.day);
      expect(album.releaseDate, '2012-11-13');
    });

    test('album tracks', () async {
      var album = await spotify.albums.get('4aawyAB9vmqN3uQ7FjRGTy');
      var items = album.tracks;

      expect(items!.length, 3);
      var tracks = album.tracks;

      var trackOne = tracks!.first;
      expect(trackOne.discNumber, 1);
      expect(trackOne.durationMs, 85400);
      expect(trackOne.id, '6OmhkSOpvYBokMKQxpIGx2');
      expect(trackOne.isPlayable, true);
      expect(trackOne.type, 'track');
      expect(trackOne.uri, 'spotify:track:6OmhkSOpvYBokMKQxpIGx2');
      expect(trackOne.explicit, true);
      expect(trackOne.href,
          'https://api.spotify.com/v1/tracks/6OmhkSOpvYBokMKQxpIGx2');
      expect(trackOne.previewUrl,
          'https://p.scdn.co/mp3-preview/bf9e33b1bb53c281c5eea0da6c317f2cd7c3eb58?cid=8897482848704f2a8f8d7c79726a70d4');
      expect(trackOne.name, 'Global Warming');

      expect(trackOne.externalUrls != null, true);
      expect(trackOne.externalUrls!.spotify,
          'https://open.spotify.com/track/6OmhkSOpvYBokMKQxpIGx2');

      var artists = trackOne.artists;
      expect(artists!.length, 2);
      expect(artists[0].name, 'Pitbull');
      expect(artists[1].name, 'Sensato');
    });

    test('list', () async {
      var albums = await spotify.albums
          .list(['4aawyAB9vmqN3uQ7FjRGTy', '4aawyAB9vmqN3uQ7FjRGTy']);

      expect(albums.length, 2);
    });
  });

  group('Artists', () {
    test('get', () async {
      var artist = await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      expect(artist.type, 'artist');
      expect(artist.id, '0TnOYISbd1XYRBk9myaseg');
      expect(artist.images!.length, 3);
    });

    test('list', () async {
      var artists = await spotify.artists
          .list(['0TnOYISbd1XYRBk9myaseg', '0TnOYISbd1XYRBk9myaseg']);

      expect(artists.length, 2);
    });

    test('getError', () async {
      spotify.mockHttpErrors =
          [MockHttpError(statusCode: 401, message: 'Bad Request')].iterator;
      late SpotifyException ex;
      try {
        await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      } on SpotifyException catch (e) {
        expect(e, isA<SpotifyException>());
        ex = e;
      }
      expect(ex, isNotNull);
      expect(ex.status, 401);
      expect(ex.message, 'Bad Request');
    });
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
  });

  group('Shows', () {
    test('get', () async {
      var show = await spotify.shows.get('4AlxqGkkrqe0mfIx3Mi7Xt');

      expect(show.type, 'show');
      expect(show.id, '4AlxqGkkrqe0mfIx3Mi7Xt');
      expect(show.name, 'Universo Flutter');
    });

    test('list', () async {
      var shows = await spotify.shows
          .list(['4AlxqGkkrqe0mfIx3Mi7Xt', '4AlxqGkkrqe0mfIx3Mi7Xt']);

      expect(shows.length, 2);
    });
  });

  group('Show episodes', () {
    test('list', () async {
      var episodes = spotify.shows.episodes('4AlxqGkkrqe0mfIx3Mi7Xt');
      var firstEpisode = (await episodes.first()).items!.first;

      expect(firstEpisode.type, 'episode');
      expect(firstEpisode.explicit, false);
    });
  });

  group('Search', () {
    test('get', () async {
      var searchResult = await spotify.search.get('metallica').first();
      expect(searchResult.length, 2);
    });

    test('getError', () async {
      spotify.mockHttpErrors =
          [MockHttpError(statusCode: 401, message: 'Bad Request')].iterator;
      late SpotifyException ex;
      try {
        await spotify.search.get('metallica').first();
      } on SpotifyException catch (e) {
        expect(e, isA<SpotifyException>());
        ex = e;
      }
      expect(ex, isNotNull);
      expect(ex.status, 401);
      expect(ex.message, 'Bad Request');
    });
  });

  group('User', () {
    test('currentlyPlaying', () async {
      var result = await spotify.me.currentlyPlaying();

      expect(result.item!.name, 'So Voce');
    });

    test('devices', () async {
      var result = await spotify.me.devices();
      expect(result.length, 1);
      expect(result.first.id, '5fbb3ba6aa454b5534c4ba43a8c7e8e45a63ad0e');
      expect(result.first.isActive, true);
      expect(result.first.isRestricted, true);
      expect(result.first.isPrivateSession, true);
      expect(result.first.name, 'My fridge');
      expect(result.first.type, DeviceType.Computer);
      expect(result.first.volumePercent, 100);
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

      var second = result.last;
      expect(second.playedAt, DateTime.tryParse('2016-12-13T20:42:17.016Z'));
      expect(second.context!.uri, 'spotify:artist:5INjqkS1o8h1imAzPqGZBb');
    });

    test('getQueue', () async {
      var result = await spotify.me.queue();
      final currentlyPlaying = result.currentlyPlaying;
      final queue = result.queue;

      expect(currentlyPlaying != null, true);
      expect(queue != null, true);

      // Checking the currentlyPlaying data

      expect(currentlyPlaying!.name, 'string');

      // Checking the queue data

      expect(queue!.length == 1, true);
      expect(queue.first.name, 'string');
    });

    test('following', () async {
      var result = await spotify.me.following(FollowingType.artist);
      expect(result == null, false);

      var first = await result.first();
      expect(first.items!.length, 1);

      var firstArtist = first.items!.first;
      expect(firstArtist.name, 'Afasi & Filthy');
      expect(firstArtist.popularity, 54);
      expect(first.after, '0aV6DOiouImYTqrR5YlIqx');
    });

    test('isFollowing', () async {
      final result = await spotify.me.isFollowing(FollowingType.artist, [
        '2CIMQHirSU0MQqyYHq0eOx',
        '57dN52uHvrHOxijzpIgu3E',
        '1vCWHaC5f2uS3yhpwWbIA6'
      ]);
      expect(result.isNotEmpty, isTrue);
      expect(result.first, isTrue);
      expect(result[1], isFalse);
      expect(result.last, isTrue);
    });

    test('savedShows', () async {
      var pages = await spotify.me.savedShows();
      var result = await pages.first(2);
      expect(result == null, false);
      expect(result.items!.length, 2);

      var firstShow = result.items!.first;
      expect(firstShow.type, 'show');
      expect(firstShow.name != null, true);
      expect(firstShow.id, '4XPl3uEEL9hvqMkoZrzbx5');
    });

    test('savedAlbums', () async {
      final albums = await spotify.me.savedAlbums().getPage(10, 0);
      expect(albums.items?.length, 2);
      expect(albums.isLast, true);
      expect(albums.items?.every((item) => item is Album), isTrue);
    });

    test('isSavedAlbums', () async {
      final list = await spotify.me.isSavedAlbums([
        '382ObEPsp2rxGrESizN5TX',
        '1A2GTWGtFfWp7KSQTwWOyo',
        '2noRn2Aes5aoNVsU6iWThc'
      ]);
      expect(list.length, 3);
      expect(list.first, isTrue);
      expect(list[1], isFalse);
      expect(list.last, isTrue);
    });
  });

  group('Auth', () {
    test('getCredentials', () async {
      var result = await spotify.getCredentials();

      expect(result.clientId, 'clientId');
      expect(result.clientSecret, 'clientSecret');
      expect(result.accessToken, 'accessToken');
      expect(result.refreshToken, 'refreshToken');
      expect(result.tokenEndpoint!.path, 'tokenEndpoint.com');
      expect(result.scopes!.length, 2);
      expect(result.expiration!.millisecondsSinceEpoch, 8000);
      expect(result.canRefresh, true);
      expect(result.isExpired, true);
    });
  });
  group('Errors', () {
    test('apiRateErrorSuccess', () async {
      spotify.mockHttpErrors = List.generate(
          4,
          (i) => MockHttpError(
              statusCode: 429,
              message: 'API Rate exceeded',
              headers: {'retry-after': '1'})).iterator;
      var artist = await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      expect(artist.type, 'artist');
      expect(artist.id, '0TnOYISbd1XYRBk9myaseg');
      expect(artist.images!.length, 3);
    });
    test('apiRateErrorFail', () async {
      spotify.mockHttpErrors = List.generate(
          10,
          (i) => MockHttpError(
              statusCode: 429,
              message: 'API Rate exceeded',
              headers: {'retry-after': '1'})).iterator;
      late ApiRateException ex;
      try {
        await spotify.artists.get('0TnOYISbd1XYRBk9myaseg');
      } on ApiRateException catch (e) {
        expect(e, isA<ApiRateException>());
        ex = e;
      }
      expect(ex, isNotNull);
      expect(ex.status, 429);
    });
  });
}
