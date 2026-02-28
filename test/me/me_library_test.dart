import 'dart:async';

import 'package:spotify/spotify.dart';

import '../spotify_mock.dart';
import 'package:test/test.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('me/library', () {
    test('saveOne', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url, contains('me/library?uris=${Uri.encodeComponent('spotify:track:1')}'));
        }
      };
      spotify.me.library.saveOne(TrackUri('1'));
    });

    test('save throws on empty uris', () async {
      testThrowsOnEmptyUris(spotify.me.library.save);
    });

    test('save throws on >50 ids', () async {
      testThrowsOnGreaterThanN(spotify.me.library.save, 50);
    });

    test('save', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'PUT') {
          expect(url,
              contains('me/library?uris=${Uri.encodeComponent('spotify:track:1,spotify:album:2,spotify:episode:3')}'));
        }
      };
      spotify.me.library.save([TrackUri('1'), AlbumUri('2'), EpisodeUri('3')]);
    });

    test('contains throws on empty ids', () async {
      testThrowsOnEmptyUris(spotify.me.library.contains);
    });

    test('contains throws on >50 ids', () async {
      testThrowsOnGreaterThanN(spotify.me.library.contains, 50);
    });

    test('contains', () async {
      final uris = [
        AlbumUri('382ObEPsp2rxGrESizN5TX'),
        TrackUri('1A2GTWGtFfWp7KSQTwWOyo'),
        ShowUri('2noRn2Aes5aoNVsU6iWThc'),
      ];

      final list = await spotify.me.library.contains(uris);

      expect(list.length, 3);
      expect(list[uris[0]], isTrue);
      expect(list[uris[1]], isFalse);
      expect(list[uris[2]], isTrue);
    });

    test('remove throws on empty ids', () async {
      testThrowsOnEmptyUris(spotify.me.library.remove);
    });

    test('remove throws on >50 ids', () async {
      testThrowsOnGreaterThanN(spotify.me.library.remove, 50);
    });

    test('remove', () async {
      spotify.interceptor = (method, url, headers, [body]) {
        if (method == 'DELETE') {
          expect(url,
              contains('me/library?uris=${Uri.encodeComponent('spotify:album:1,spotify:track:2,spotify:show:3')}'));
        }
      };
      spotify.me.library.remove([
        AlbumUri('1'),
        TrackUri('2'),
        ShowUri('3'),
      ]);
    });
  });
}

Future<void> testThrowsOnEmptyUris(Function(List<SpotifyUri>) f) async {
  expect(() => f(List.empty()), throwsA(isA<ArgumentError>()));
}

Future<void> testThrowsOnGreaterThanN(Function(List<SpotifyUri>) f, int n) async {
  final tooMany = List.generate(n + 1, (i) => TrackUri('id$i'));
  expect(() => f(tooMany), throwsA(isA<RangeError>()));
}
