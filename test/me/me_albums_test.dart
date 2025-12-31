import 'dart:async';

import '../spotify_mock.dart';
import 'package:test/test.dart';

import 'me_core_test.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('me/albums', () {
    test('saved', () async {
      final albumsPage = spotify.me.albums.saved();
      final firstPage = await (albumsPage.first());
      final firstItem = firstPage.items?.first;
      expect(firstItem, isNotNull);
      expect(firstItem!.id, '5Nwsra93UQYJ6xxcjcE10x');
      expect(firstItem.artists, hasLength(1));
      expect(firstItem.artists!.first.id, '6VuMaDnrHyPL1p4EHjYLi7');
      expect(firstItem.tracks, hasLength(13));
      expect(firstItem.releaseDate, '2016-01-29');
      expect(firstItem.uri, 'spotify:album:5Nwsra93UQYJ6xxcjcE10x');
    });

    test('save throws on empty ids', () async {
      testSaveThrowsOnEmptyIds(spotify.me.albums);
    });

    test('saveOne', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url, contains('me/albums?ids=1'));
        }
      };
      spotify.me.albums.saveOne('1');
    });

    test('save throws on >20 ids', () async {
      testSaveThrowsOnGreaterThanN(spotify.me.albums, 20);
    });

    test('save', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url, contains('me/albums?ids=${Uri.encodeComponent('1,2,3')}'));
        }
      };
      spotify.me.albums.save(['1', '2', '3']);
    });

    test('contains throws on empty ids', () async {
      testContainsThrowsOnEmptyIds(spotify.me.albums);
    });

    test('contains throws on >20 ids', () async {
      testContainsThrowsOnGreaterThanN(spotify.me.albums, 20);
    });

    test('contains', () async {
      final albumIds = [
        '382ObEPsp2rxGrESizN5TX',
        '1A2GTWGtFfWp7KSQTwWOyo',
        '2noRn2Aes5aoNVsU6iWThc',
      ];

      final list = await spotify.me.albums.contains(albumIds);

      expect(list.length, 3);
      expect(list[albumIds[0]], isTrue);
      expect(list[albumIds[1]], isFalse);
      expect(list[albumIds[2]], isTrue);
    });

    test('remove throws on empty ids', () async {
      testRemoveThrowsOnEmptyIds(spotify.me.albums);
    });

    test('remove throws on > 20 ids', () async {
      testRemoveThrowsOnGreaterThanN(spotify.me.albums, 20);
    });

    test('remove', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'DELETE') {
          expect(url, contains('me/albums?ids=${Uri.encodeComponent('1,2,3')}'));
        }
      };
      spotify.me.albums.remove(['1', '2', '3']);
    });
  });
}
