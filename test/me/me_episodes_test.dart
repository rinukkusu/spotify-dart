import 'dart:async';

import '../spotify_mock.dart';
import 'package:test/test.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('me/episodes', () {
    test('saved', () async {
      final episodesPage = spotify.me.episodes.saved();
      final firstPage = await (episodesPage.first());
      final firstItem = firstPage.items?.first;
      expect(firstItem, isNotNull);
      expect(firstItem!.name, 'Starting Your Own Podcast: Tips, Tricks, and Advice From Anchor Creators');
      expect(
        firstItem.description,
        'A Spotify podcast sharing fresh insights on important topics of the moment—in a way only Spotify can. You’ll hear from experts in the music, podcast and tech industries as we discover and uncover stories about our work and the world around us.\n',
      );
      expect(firstItem.explicit, true);
      expect(firstItem.isPlayable, true);
      expect(firstItem.durationMs, 1686230);
      expect(firstItem.languages, ['en']);
    });
  });
}
