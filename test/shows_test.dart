import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Shows', () {
    test('get', () async {
      final show = await spotify.shows.get('4AlxqGkkrqe0mfIx3Mi7Xt');

      expect(show.type, 'show');
      expect(show.id, '4AlxqGkkrqe0mfIx3Mi7Xt');
      expect(show.name, 'Universo Flutter');
      expect(show.totalEpisodes, 26);
    });

    test('list', () async {
      final shows = await spotify.shows.list(['4AlxqGkkrqe0mfIx3Mi7Xt', '4AlxqGkkrqe0mfIx3Mi7Xt']);

      expect(shows.length, 2);
    });
  });

  group('Show episodes', () {
    test('list', () async {
      final episodes = spotify.shows.episodes('4AlxqGkkrqe0mfIx3Mi7Xt');
      final firstEpisode = (await episodes.first()).items!.first;

      expect(firstEpisode.type, 'episode');
      expect(firstEpisode.explicit, false);
    });
  });
}
