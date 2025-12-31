import 'dart:async';

import '../spotify_mock.dart';
import 'package:test/test.dart';

import 'me_core.dart';

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
      expect(firstItem.description, 'A Spotify podcast sharing fresh insights on important topics of the moment—in a way only Spotify can. You’ll hear from experts in the music, podcast and tech industries as we discover and uncover stories about our work and the world around us.\n');
      expect(firstItem.explicit, true);
      expect(firstItem.isPlayable, true);
      expect(firstItem.durationMs, 1686230);
      expect(firstItem.language, 'en');
    });

    test('save throws on empty ids', () async {
      testSaveThrowsOnEmptyIds(spotify.me.episodes);
    });

    test('saveOne', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url, contains('me/episodes?ids=1'));
        }
      };
      spotify.me.episodes.saveOne('1');
    });

    test('save throws on >50 ids', () async {
      testSaveThrowsOnGreaterThanN(spotify.me.episodes, 50);
    });

    test('save', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url, contains('me/episodes?ids=${Uri.encodeComponent('1,2,3')}'));
        }
      };
      spotify.me.episodes.save(['1', '2', '3']);
    });

    test('contains throws on empty ids', () async {
      testContainsThrowsOnEmptyIds(spotify.me.episodes);
    });

    test('contains throws on >50 ids', () async {
      testContainsThrowsOnGreaterThanN(spotify.me.episodes, 50);
    });

    test('contains', () async {
      final albumIds = [
        '382ObEPsp2rxGrESizN5TX',
        '1A2GTWGtFfWp7KSQTwWOyo',
        '2noRn2Aes5aoNVsU6iWThc',
      ];

      final list = await spotify.me.episodes.contains(albumIds);

      expect(list.length, 3);
      expect(list[albumIds[0]], isTrue);
      expect(list[albumIds[1]], isFalse);
      expect(list[albumIds[2]], isFalse);
    });

    test('remove throws on empty ids', () async {
      testRemoveThrowsOnEmptyIds(spotify.me.episodes);
    });

    test('remove throws on > 50 ids', () async {
      testRemoveThrowsOnGreaterThanN(spotify.me.audiobooks, 50);
    });

    test('remove', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'DELETE') {
          expect(url, contains('me/audiobooks?ids=${Uri.encodeComponent('1,2,3')}'));
        }
      };
      spotify.me.audiobooks.remove(['1', '2', '3']);
    });
  });
}
