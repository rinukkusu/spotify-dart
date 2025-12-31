import 'dart:async';

import 'package:spotify/spotify.dart';

import '../spotify_mock.dart';
import 'package:test/test.dart';

import 'me_core.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('me/shows', () {
    test('saved', () async {
      final albumsPage = spotify.me.shows.saved();
      final firstPage = await (albumsPage.first());
      final firstItem = firstPage.items?.first;
      expect(firstItem, isNotNull);
      expect(firstItem!.explicit, false);
      expect(firstItem.id, '4XPl3uEEL9hvqMkoZrzbx5');
      expect(firstItem.name, 'Darknet Diaries');
      expect(firstItem.languages, hasLength(1));
      expect(firstItem.mediaType, 'audio');
      expect(firstItem.publisher, 'Jack Rhysider');

      expect(firstItem.uri, 'spotify:show:4XPl3uEEL9hvqMkoZrzbx5');
    });

    test('save throws on empty ids', () async {
      testSaveThrowsOnEmptyIds(spotify.me.shows);
    });

    test('saveOne', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url, contains('me/shows?ids=1'));
        }
      };
      spotify.me.shows.saveOne('1');
    });

    test('save throws on >50 ids', () async {
      testSaveThrowsOnGreaterThanN(spotify.me.shows, 50);
    });

    test('save', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url, contains('me/shows?ids=${Uri.encodeComponent('1,2,3')}'));
        }
      };
      spotify.me.shows.save(['1', '2', '3']);
    });

    test('contains throws on empty ids', () async {
      testContainsThrowsOnEmptyIds(spotify.me.shows);
    });

    test('contains throws on >50 ids', () async {
      testContainsThrowsOnGreaterThanN(spotify.me.shows, 50);
    });

    test('contains', () async {
      final showIds = [
        '382ObEPsp2rxGrESizN5TX',
        '1A2GTWGtFfWp7KSQTwWOyo',
      ];

      final list = await spotify.me.shows.contains(showIds);

      expect(list.length, 2);
      expect(list[showIds[0]], isTrue);
      expect(list[showIds[1]], isFalse);
    });

    test('remove throws on empty ids', () async {
      testRemoveThrowsOnEmptyIds(spotify.me.shows);
    });

    test('remove throws on >50 ids', () async {
      testRemoveThrowsOnGreaterThanN(spotify.me.shows, 50);
    });

    test('remove', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'DELETE') {
          expect(url, contains('me/shows?ids=${Uri.encodeComponent('1,2,3')}&market=AD'));
        }
      };
      spotify.me.shows.remove(['1', '2', '3'], Market.AD);
    });
  });
}
