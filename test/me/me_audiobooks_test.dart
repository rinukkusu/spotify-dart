import 'dart:async';

import 'package:spotify/spotify.dart';

import '../spotify_mock.dart';
import 'package:test/test.dart';

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
      expect(firstItem.audiobook!.explicit, false);
      expect(firstItem.audiobook!.edition, 'Unabridged');
      expect(firstItem.audiobook!.uri, AudiobookUri('savedbook').toString());
    });
  });
}
