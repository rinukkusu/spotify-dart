import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Audiobooks', () {
    test('get', () async {
      final audiobook = await spotify.audiobooks.get('7iHfbu1YPACw6oZPAFJtqe');

      expect(audiobook.id, '7iHfbu1YPACw6oZPAFJtqe');
      expect(audiobook.name, 'Sample Audiobook');
      expect(audiobook.type, 'audiobook');
      expect(audiobook.authors, isNotNull);
      expect(audiobook.authors!.length, 1);
      expect(audiobook.authors!.first.name, 'J.K. Rowling');
      expect(audiobook.narrators, isNotNull);
      expect(audiobook.narrators!.length, 1);
      expect(audiobook.narrators!.first.name, 'Stephen Fry');
      expect(audiobook.totalChapters, 25);
      expect(audiobook.publisher, 'Audible Studios');
      expect(audiobook.edition, 'Unabridged');
      expect(audiobook.explicit, false);
      expect(audiobook.description, 'A thrilling audiobook adventure');
    });

    test('list', () async {
      final audiobooks = await spotify.audiobooks.list(['audiobook1', 'audiobook2']);

      expect(audiobooks.length, 2);
      expect(audiobooks.first.id, 'audiobook1');
      expect(audiobooks.first.name, 'Audiobook 1');
      expect(audiobooks.elementAt(1).id, 'audiobook2');
      expect(audiobooks.elementAt(1).name, 'Audiobook 2');
    });

    test('chapters', () async {
      final chaptersPage = spotify.audiobooks.chapters('7iHfbu1YPACw6oZPAFJtqe');
      final firstPage = await chaptersPage.first();

      expect(firstPage.items, isNotNull);
      expect(firstPage.items!.length, 2);

      final chapter = firstPage.items!.first;
      expect(chapter.id, 'chapter1');
      expect(chapter.name, 'Chapter 1: The Beginning');
      expect(chapter.chapterNumber, 1);
      expect(chapter.durationMs, 360000);
      expect(chapter.type, 'episode');
      expect(chapter.resumePoint, isNotNull);
      expect(chapter.resumePoint!.fullyPlayed, false);
      expect(chapter.resumePoint!.resumePositionMs, 12000);
    });

    test('get throws on empty id', () async {
      expect(
        () => spotify.audiobooks.get(''),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Chapters', () {
    test('get', () async {
      final chapter = await spotify.chapters.get('0IsXVP0JmcB2adSE338GkK');

      expect(chapter.id, '0IsXVP0JmcB2adSE338GkK');
      expect(chapter.name, 'Chapter 5: The Climax');
      expect(chapter.type, 'episode');
      expect(chapter.chapterNumber, 5);
      expect(chapter.durationMs, 480000);
      expect(chapter.audiobook, isNotNull);
      expect(chapter.audiobook!.id, 'parentbook');
      expect(chapter.audiobook!.name, 'Parent Audiobook');
      expect(chapter.resumePoint, isNotNull);
      expect(chapter.resumePoint!.fullyPlayed, false);
      expect(chapter.resumePoint!.resumePositionMs, 150000);
      expect(chapter.releaseDate, '2023-03-15');
      expect(chapter.releaseDatePrecision, DatePrecision.day);
    });

    test('list', () async {
      final chapters = await spotify.chapters.list(['chap1', 'chap2']);

      expect(chapters.length, 2);
      expect(chapters.first.id, 'chap1');
      expect(chapters.first.name, 'Chapter 1');
      expect(chapters.first.chapterNumber, 1);
      expect(chapters.elementAt(1).id, 'chap2');
      expect(chapters.elementAt(1).name, 'Chapter 2');
      expect(chapters.elementAt(1).chapterNumber, 2);
    });

    test('get throws on empty id', () async {
      expect(
        () => spotify.chapters.get(''),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
