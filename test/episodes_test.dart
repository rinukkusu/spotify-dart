import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Episodes', () {
    test('getEpisode', () async {
      final result = await spotify.episodes.get('5Xt5DXGzch68nYYamXrNxZ');

      expect(result.durationMs, 1686230);
      expect(result.duration, const Duration(milliseconds: 1686230));
      expect(result.explicit, true);
      expect(
        result.href,
        'https://api.spotify.com/v1/episodes/5Xt5DXGzch68nYYamXrNxZ',
      );
      expect(
        result.name,
        'Starting Your Own Podcast: Tips, Tricks, '
        'and Advice From Anchor Creators',
      );
      expect(result.releaseDate, '1981-12-15');
      expect(result.type, SpotifyContentType.episode);
      expect(result.description, contains('A Spotify podcast'));
      expect(result.show == null, false);

      final show = result.show;
      expect(show?.copyrights?.first.type, CopyrightType.C);
      expect(show?.isExternallyHosted, true);
      expect(show?.name, 'The No-Show');
      expect(show?.totalEpisodes, 1);
    });
  });
}
