import 'dart:async';

import '../spotify_mock.dart';
import 'package:test/test.dart';

import 'me_core.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('me/audiobooks', () {
    test('saved', () async {
      final albumsPage = spotify.me.audiobooks.saved();
      final firstPage = await (albumsPage.first());
      final firstItem = firstPage.items?.first;
      expect(firstItem, isNotNull);
      expect(firstItem!.audiobook, isNotNull);
      expect(firstItem.audiobook!.id, 'savedbook');
      expect(firstItem.audiobook!.authors, hasLength(1));
      expect(firstItem.audiobook!.description, 'A saved audiobook');

      expect(firstItem.audiobook!.totalChapters, 12);
      expect(firstItem.audiobook!.name, 'Saved Audiobook');
      expect(firstItem.audiobook!.publisher, 'Saved Publisher');
      expect(firstItem.audiobook!.explicit, false);
      expect(firstItem.audiobook!.edition, 'Unabridged');
      expect(firstItem.audiobook!.uri, 'spotify:show:savedbook');
    });

    test('save throws on empty ids', () async {
      testSaveThrowsOnEmptyIds(spotify.me.audiobooks);
    });

    test('saveOne', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url, contains('me/audiobooks?ids=1'));
        }
      };
      spotify.me.audiobooks.saveOne('1');
    });

    test('save throws on >50 ids', () async {
      testSaveThrowsOnGreaterThanN(spotify.me.audiobooks, 50);
    });

    test('save', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url, contains('me/audiobooks?ids=${Uri.encodeComponent('1,2,3')}'));
        }
      };
      spotify.me.audiobooks.save(['1', '2', '3']);
    });

    test('contains throws on empty ids', () async {
      testContainsThrowsOnEmptyIds(spotify.me.audiobooks);
    });

    test('contains throws on >50 ids', () async {
      testContainsThrowsOnGreaterThanN(spotify.me.audiobooks, 50);
    });

    test('contains', () async {
      final albumIds = [
        '382ObEPsp2rxGrESizN5TX',
        '1A2GTWGtFfWp7KSQTwWOyo',
        '2noRn2Aes5aoNVsU6iWThc',
      ];

      final list = await spotify.me.audiobooks.contains(albumIds);

      expect(list.length, 3);
      expect(list[albumIds[0]], isTrue);
      expect(list[albumIds[1]], isFalse);
      expect(list[albumIds[2]], isTrue);
    });

    test('remove throws on empty ids', () async {
      testRemoveThrowsOnEmptyIds(spotify.me.audiobooks);
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
