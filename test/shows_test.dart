import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';


Future main() async {
  var spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
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
}
