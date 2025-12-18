// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../spotify.dart';

Iterable<List<T>> batches<T>(Iterable<T> source, int size) sync* {
  List<T>? accumulator;
  for (final value in source) {
    (accumulator ??= []).add(value);
    if (accumulator.length == size) {
      yield accumulator;
      accumulator = null;
    }
  }
  if (accumulator != null) yield accumulator;
}

/// Helper function to overcome the current
/// [spotify bug](https://community.spotify.com/t5/Spotify-for-Developers/The-response-type-of-artist-endpoint-is-marked-as-Integer-in/m-p/5800044#M12164)
int? convertToIntIfDoubleValue(dynamic jsonValue) {
  if (jsonValue is num) {
    return jsonValue.toInt();
  }
  return null;
}

int convertToIntIfDoubleValueWithoutNull(dynamic jsonValue) {
  return convertToIntIfDoubleValue(jsonValue) ?? 0;
}

/// Generates a cryptographically secure random code verifier for PKCE.
///
/// The code verifier is a high-entropy cryptographic random string using the
/// characters [A-Z] / [a-z] / [0-9] / "-" / "." / "_" / "~", with a minimum
/// length of 43 characters and a maximum length of 128 characters.
///
/// This implementation generates a 128-character verifier for maximum security.
///
/// Returns a random code verifier string suitable for PKCE flows.
///
/// Example:
/// ```dart
/// final verifier = generateCodeVerifier();
/// print(verifier); // e.g., "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk..."
/// ```
String generateCodeVerifier() {
  const charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
  final random = math.Random.secure();
  return List.generate(
    128,
    (_) => charset[random.nextInt(charset.length)],
  ).join();
}
