import 'dart:async';
import 'spotify_mock.dart';
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

      expect(album.albumType, AlbumType.album);
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

  group('Audio Analysis', () {
    test('get', () async {
      var result = await spotify.audioAnalysis.get('xyz123');

      expect(result.track, isNotNull);
      expect(result.bars?.isEmpty, isFalse);
      expect(result.beats?.isEmpty, isFalse);
      expect(result.sections?.isEmpty, isFalse);
      expect(result.segments?.isEmpty, isFalse);
      expect(result.tatums?.isEmpty, isFalse);

      var firstSection = result.sections?.first;
      expect(firstSection?.start, 0);
      expect(firstSection?.duration, 6.97092);
      expect(firstSection?.confidence, 1);
      expect(firstSection?.loudness, -14.938);
      expect(firstSection?.tempo, 113.178);
      expect(firstSection?.tempoConfidence, 0.647);
      expect(firstSection?.key, 9);
      expect(firstSection?.keyConfidence, 0.297);
      expect(firstSection?.mode, 1);
      expect(firstSection?.modeConfidence, 0.471);
      expect(firstSection?.timeSignature, 4);
      expect(firstSection?.timeSignatureConfidence, 1);

      var firstSegment = result.segments?.first;
      expect(firstSegment?.start, 0);
      expect(firstSegment?.duration, 0.24317);
      expect(firstSegment?.confidence, 1);
      expect(firstSegment?.loudnessStart, -59.656);
      expect(firstSegment?.loudnessMaxTime, 0.21478);
      expect(firstSegment?.loudnessMax, -36.317);
      expect(firstSegment?.loudnessEnd, 0);
      expect(firstSegment?.pitches?.isEmpty, isFalse);
      expect(firstSegment?.timbre?.isEmpty, isFalse);

      var track = result.track;
      expect(track?.numSamples, 4585515);
      expect(track?.duration, 207.95985);
      expect(track?.analysisSampleRate, 22050);
      expect(track?.analysisChannels, 1);
      expect(track?.endOfFadeIn, 0);
      expect(track?.startOfFadeOut, 201.13705);
      expect(track?.loudness, -2.743);
      expect(track?.tempo, 114.944);
      expect(track?.tempoConfidence, 0.74);
      expect(track?.timeSignature, 4);
      expect(track?.timeSignatureConfidence, 0.994);
      expect(track?.key, 2);
      expect(track?.keyConfidence, 0.408);
      expect(track?.mode, 1);
      expect(track?.codeString, 'eJxVmgl2LDcOBK_SR-');
      expect(track?.codeVersion, 3.15);
      expect(track?.synchString, 'eJxNWglyHDEI_I');
      expect(track?.synchVersion, 1);
      expect(track?.rhythmString, 'eJx1XFmW4zgOvIqPwJ3g_S');
      expect(track?.rhythmVersion, 1);
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

  group('Browse', () {
    test('Get New Releases', () async {
      var newReleases = spotify.browse.getNewReleases();
      var firstPage = await newReleases.first();
      expect(firstPage.items!.length, 3);

      var firstItem = firstPage.items!.first;
      expect(firstItem.id, '50MeziN5Do8zDtN4wINTTS');
      expect(firstItem.name, '11:11');
      expect(firstItem.releaseDate, '2022-08-11');
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
  });

  group('Shows', () {
    test('get', () async {
      var show = await spotify.shows.get('4AlxqGkkrqe0mfIx3Mi7Xt');

      expect(show.type, 'show');
      expect(show.id, '4AlxqGkkrqe0mfIx3Mi7Xt');
      expect(show.name, 'Universo Flutter');
      expect(show.totalEpisodes, 26);
      expect(show.availableMarkets, isNotEmpty);
      expect(show.availableMarkets?.first, Market.AD);
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
      var result = await spotify.player.currentlyPlaying();

      expect(result.item!.name, 'As I Am');
    });

    test('Devices', () async {
      var result = await spotify.player.devices();
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

  group('Episodes', () {
    test('getEpisode', () async {
      var result = await spotify.episodes.get('5Xt5DXGzch68nYYamXrNxZ');

      expect(result.durationMs, 1686230);
      expect(result.explicit, true);
      expect(result.audioPreviewUrl,
          'https://p.scdn.co/mp3-preview/2f37da1d4221f40b9d1a98cd191f4d6f1646ad17');
      expect(result.href,
          'https://api.spotify.com/v1/episodes/5Xt5DXGzch68nYYamXrNxZ');
      expect(result.name,
          'Starting Your Own Podcast: Tips, Tricks, and Advice From Anchor Creators');
      expect(result.releaseDate, DateTime(1981, 12, 15));
      expect(result.type, 'episode');
      expect(result.description,
          'A Spotify podcast sharing fresh insights on important topics of the moment—in a way only Spotify can. You’ll hear from experts in the music, podcast and tech industries as we discover and uncover stories about our work and the world around us.');
      expect(result.show == null, false);

      var show = result.show;
      expect(show?.copyrights?.first.type, CopyrightType.C);
      expect(show?.isExternallyHosted, true);
      expect(show?.name, 'The No-Show');
      expect(show?.totalEpisodes, 1);
    });
  });

  group('Player', () {
    test('player', () async {
      var result = await spotify.player.playbackState();
      expect(result.isShuffling, true);
      expect(result.isPlaying, true);
      expect(result.currentlyPlayingType, CurrentlyPlayingType.track);
      expect(result.repeatState, RepeatState.off);
      expect(result.actions?.resuming, false);
      expect(result.actions?.pausing, true);
    });
  });

  group('Tracks', () {
    test('containsTracks', () async {
      var result = await spotify.tracks.me.containsTracks(['1', '2', '3']);

      expect(result.length, 3);
      expect(result['1'], isTrue);
      expect(result['2'], isFalse);
      expect(result['3'], isTrue);
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

  group('markets', () {
    test('getAvailableMarkets', () async {
      var result = await spotify.markets.availableMarkets;
      expect(result.isEmpty, false);
      expect(result.first, Market.AD);
      expect(result.elementAt(1), Market.AE);
      expect(result.last, Market.ZW);
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
