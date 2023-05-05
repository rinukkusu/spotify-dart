// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

Iterable<List<T>> batches<T>(Iterable<T> source, int size) sync* {
  List<T>? accumulator;
  for (var value in source) {
    (accumulator ??= []).add(value);
    if (accumulator.length == size) {
      yield accumulator;
      accumulator = null;
    }
  }
  if (accumulator != null) yield accumulator;
}
