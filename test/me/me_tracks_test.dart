import 'dart:async';

import '../spotify_mock.dart';
import 'package:test/test.dart';

import 'me_core_test.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('me/tracks', () {
    test('saved', () async {
      final albumsPage = spotify.me.tracks.saved();
      final firstPage = await (albumsPage.first());
      final firstItem = firstPage.items?.first;
      expect(firstItem, isNotNull);
      expect(firstItem!.track, isNotNull);
      expect(firstItem.track!.id, '4DMKwE2E2iYDKY01C335Uw');
      expect(firstItem.track!.artists, hasLength(1));
      expect(firstItem.track!.artists!.first.id, '2hl0xAkS2AIRAu23TVMBG1');

      expect(firstItem.track!.duration, const Duration(milliseconds: 323000));
      expect(firstItem.track!.popularity, 76);
      expect(firstItem.track!.trackNumber, 1);
      expect(firstItem.track!.isPlayable, true);
      expect(firstItem.track!.explicit, false);
      expect(firstItem.track!.uri, 'spotify:track:4DMKwE2E2iYDKY01C335Uw');
    });

    test('save throws on empty ids', () async {
      testSaveThrowsOnEmptyIds(spotify.me.tracks);
    });

    test('saveOne', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url, contains('me/tracks?ids=1'));
        }
      };
      spotify.me.tracks.saveOne('1');
    });

    test('save throws on >50 ids', () async {
      testSaveThrowsOnGreaterThanN(spotify.me.tracks, 50);
    });

    test('save', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url, contains('me/tracks?ids=${Uri.encodeComponent('1,2,3')}'));
        }
      };
      spotify.me.tracks.save(['1', '2', '3']);
    });

    test('contains throws on empty ids', () async {
      testContainsThrowsOnEmptyIds(spotify.me.tracks);
    });

    test('contains throws on >50 ids', () async {
      testContainsThrowsOnGreaterThanN(spotify.me.tracks, 50);
    });

    test('contains', () async {
      final albumIds = [
        '382ObEPsp2rxGrESizN5TX',
        '1A2GTWGtFfWp7KSQTwWOyo',
        '2noRn2Aes5aoNVsU6iWThc',
      ];

      final list = await spotify.me.tracks.contains(albumIds);

      expect(list.length, 3);
      expect(list[albumIds[0]], isTrue);
      expect(list[albumIds[1]], isFalse);
      expect(list[albumIds[2]], isTrue);
    });

    test('remove throws on empty ids', () async {
      testRemoveThrowsOnEmptyIds(spotify.me.tracks);
    });

    test('remove throws on > 20 ids', () async {
      testRemoveThrowsOnGreaterThanN(spotify.me.tracks, 50);
    });

    test('remove', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'DELETE') {
          expect(url, contains('me/tracks?ids=${Uri.encodeComponent('1,2,3')}'));
        }
      };
      spotify.me.tracks.remove(['1', '2', '3']);
    });
  });
}
