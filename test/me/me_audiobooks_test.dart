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
      expect(firstItem!.id, 'savedbook');
      expect(firstItem.authors, hasLength(1));
      expect(firstItem.description, 'A saved audiobook');

      expect(firstItem.totalChapters, 12);
      expect(firstItem.name, 'Saved Audiobook');
      expect(firstItem.explicit, false);
      expect(firstItem.edition, 'Unabridged');
      expect(firstItem.uri, AudiobookUri('savedbook'));
    });
  });
}
