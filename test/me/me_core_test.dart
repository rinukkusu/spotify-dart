// ignore_for_file: unused_element

import 'dart:async';

import 'package:spotify/spotify.dart';

import 'package:test/test.dart';

Future main() async {
  Future<void> testSaveThrowsOnEmptyIds(LibraryModifiable m) async {
    expect(() => m.save(List.empty()), throwsA(isA<ArgumentError>()));
  }

  Future<void> testSaveThrowsOnGreaterThanN(LibraryModifiable m, int n) async {
    final tooMany = List.generate(n + 1, (i) => 'id$i');
    expect(() => m.save(tooMany), throwsA(isA<RangeError>()));
  }

  Future<void> testContainsThrowsOnEmptyIds(LibraryModifiable m) async {
    expect(() => m.contains(List.empty()), throwsA(isA<ArgumentError>()));
  }

  Future<void> testContainsThrowsOnGreaterThanN(LibraryModifiable m, int n) async {
    final tooMany = List.generate(n + 1, (i) => 'id$i');
    expect(() => m.contains(tooMany), throwsA(isA<RangeError>()));
  }

  Future<void> testRemoveThrowsOnEmptyIds(LibraryModifiable m) async {
    expect(() => m.remove(List.empty()), throwsA(isA<ArgumentError>()));
  }

  Future<void> testRemoveThrowsOnGreaterThanN(LibraryModifiable m, int n) async {
    final tooMany = List.generate(n + 1, (i) => 'id$i');
    expect(() => m.remove(tooMany), throwsA(isA<RangeError>()));
  }
}
