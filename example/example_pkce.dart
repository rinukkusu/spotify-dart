// Copyright (c) 2024. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:spotify/spotify.dart';

/// Example demonstrating PKCE (Proof Key for Code Exchange) authentication
/// for public clients (mobile/web apps without client secrets).
///
/// PKCE is the recommended flow for:
/// - Mobile applications
/// - Single-page applications (SPAs)
/// - Any client that cannot securely store a client secret
///
/// This example shows:
/// 1. Generating a code verifier
/// 2. Creating PKCE credentials
/// 3. Completing the OAuth flow
/// 4. Saving and restoring credentials
/// 5. Automatic token refresh

final _scopes = [
  AuthorizationScope.playlist.readPrivate,
  AuthorizationScope.library.read,
  AuthorizationScope.connect.readPlaybackState,
];

void main() async {
  print('=== Spotify PKCE Authentication Example ===\n');

  print('Enter your Spotify Client ID:');
  final clientId = stdin.readLineSync();
  if (clientId == null || clientId.isEmpty) {
    print('Client ID is required');
    exit(1);
  }

  print('\nGenerating secure code verifier...');
  final codeVerifier = SpotifyApi.generateCodeVerifier();
  print('Code verifier generated (length: ${codeVerifier.length})');

  final credentials = SpotifyApiCredentials.pkce(
    clientId,
    codeVerifier: codeVerifier,
  );

  print('\nEnter your redirect URI (from Spotify app settings):');
  final redirectInput = stdin.readLineSync();
  if (redirectInput == null || redirectInput.isEmpty) {
    print('Redirect URI is required');
    exit(1);
  }
  final redirectUri = Uri.parse(redirectInput);

  print('\nInitializing OAuth authorization grant...');
  final grant = SpotifyApi.authorizationCodeGrant(
    credentials,
    onCredentialsRefreshed: (newCreds) {
      print('📝 Credentials refreshed!');
      _saveCredentials(newCreds);
    },
  );

  final authUri = grant.getAuthorizationUrl(redirectUri, scopes: _scopes);

  print('\n=== Authorization Required ===');
  print('Please open this URL in your browser:\n');
  print(authUri);
  print('\nAfter authorizing, you will be redirected.');
  print('Copy the COMPLETE redirect URL and paste it here:');

  final responseInput = stdin.readLineSync();
  if (responseInput == null || responseInput.isEmpty) {
    print('Redirect URL is required');
    exit(1);
  }

  final responseUri = Uri.parse(responseInput);

  print('\nExchanging authorization code for tokens...');
  final client = await grant.handleAuthorizationResponse(
    responseUri.queryParameters,
  );

  final spotify = SpotifyApi.fromClient(client);

  print('✅ Authentication successful!\n');

  final savedCredentials = await spotify.getCredentials();
  _saveCredentials(savedCredentials);
  print('💾 Credentials saved to .credentials_pkce\n');

  print('=== Testing API Access ===\n');
  await _testApi(spotify);

  print('\n=== Demonstrating Credential Restoration ===');
  print('Loading credentials from file...');
  final restoredCredentials = _loadCredentials();

  if (restoredCredentials != null) {
    print('Creating new Spotify client from saved credentials...');
    final restoredSpotify = await SpotifyApi.asyncFromCredentials(
      restoredCredentials,
      onCredentialsRefreshed: (newCreds) {
        print('📝 Credentials refreshed automatically!');
        _saveCredentials(newCreds);
      },
    );

    print('✅ Restored client created successfully!\n');
    await _testApi(restoredSpotify);
  }

  exit(0);
}

Future<void> _testApi(SpotifyApi spotify) async {
  try {
    print('Fetching your profile...');
    final user = await spotify.me.get();
    print('👤 Hello, ${user.displayName ?? user.id}!');

    if (user.email != null) {
      print('📧 Email: ${user.email}');
    }

    print('\nFetching your top artists...');
    final artists = await spotify.me.following(FollowingType.artist).first();
    if (artists.items != null && artists.items!.isNotEmpty) {
      print('🎵 You follow ${artists.items!.length} artists, including:');
      for (final artist in artists.items!.take(5)) {
        print('  • ${artist.name}');
      }
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}

void _saveCredentials(SpotifyApiCredentials credentials) {
  final credentialsJson = {
    'clientId': credentials.clientId,
    'clientSecret': credentials.clientSecret,
    'accessToken': credentials.accessToken,
    'refreshToken': credentials.refreshToken,
    'tokenEndpoint': credentials.tokenEndpoint?.toString(),
    'scopes': credentials.scopes,
    'expiration': credentials.expiration?.toIso8601String(),
    'codeVerifier': credentials.codeVerifier,
  };

  File('.credentials_pkce').writeAsStringSync(
    json.encode(credentialsJson),
  );
}

SpotifyApiCredentials? _loadCredentials() {
  try {
    final file = File('.credentials_pkce');
    if (!file.existsSync()) return null;

    final credentialsJson = json.decode(file.readAsStringSync());
    final codeVerifier = credentialsJson['codeVerifier'] as String?;

    if (codeVerifier != null) {
      return SpotifyApiCredentials.pkce(
        credentialsJson['clientId'],
        codeVerifier: codeVerifier,
        accessToken: credentialsJson['accessToken'],
        refreshToken: credentialsJson['refreshToken'],
        scopes: List<String>.from(credentialsJson['scopes'] ?? []),
        expiration: credentialsJson['expiration'] != null ? DateTime.parse(credentialsJson['expiration']) : null,
      );
    } else {
      return SpotifyApiCredentials(
        credentialsJson['clientId'],
        credentialsJson['clientSecret'],
        accessToken: credentialsJson['accessToken'],
        refreshToken: credentialsJson['refreshToken'],
        scopes: List<String>.from(credentialsJson['scopes'] ?? []),
        expiration: credentialsJson['expiration'] != null ? DateTime.parse(credentialsJson['expiration']) : null,
      );
    }
  } catch (e) {
    print('Warning: Could not load credentials: $e');
    return null;
  }
}
