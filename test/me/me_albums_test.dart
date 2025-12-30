import 'dart:async';

import '../spotify_mock.dart';
import 'package:test/test.dart';

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
      expect(() => spotify.me.albums.save(List.empty()), throwsA(isA<ArgumentError>()));
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
      final tooMany = List.generate(21, (i) => 'id$i');
      expect(() => spotify.me.albums.save(tooMany), throwsA(isA<RangeError>()));
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
      expect(() => spotify.me.albums.contains(List.empty()), throwsA(isA<ArgumentError>()));
    });

    test('contains throws on >20 ids', () async {
      final tooMany = List.generate(21, (i) => 'id$i');
      expect(() => spotify.me.albums.contains(tooMany), throwsA(isA<RangeError>()));
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
      expect(() => spotify.me.albums.remove(List.empty()), throwsA(isA<ArgumentError>()));
    });

    test('remove throws on > 20 ids', () async {
      final tooMany = List.generate(21, (i) => 'id$i');
      expect(() => spotify.me.albums.remove(tooMany), throwsA(isA<RangeError>()));
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
