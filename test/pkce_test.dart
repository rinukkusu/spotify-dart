import 'package:spotify/spotify.dart';
import 'package:test/test.dart';

void main() {
  group('PKCE Support', () {
    group('Code Verifier Generation', () {
      test('generates valid code verifier', () {
        final verifier = SpotifyApi.generateCodeVerifier();

        expect(verifier, isNotEmpty);
        expect(verifier.length, greaterThanOrEqualTo(43));
        expect(verifier.length, lessThanOrEqualTo(128));

        // Should only contain valid characters: [A-Za-z0-9\-._~]
        final validPattern = RegExp(r'^[A-Za-z0-9\-._~]+$');
        expect(verifier, matches(validPattern));
      });

      test('generates unique code verifiers', () {
        final verifier1 = SpotifyApi.generateCodeVerifier();
        final verifier2 = SpotifyApi.generateCodeVerifier();

        expect(verifier1, isNot(equals(verifier2)));
      });

      test('generates 128-character verifier', () {
        final verifier = SpotifyApi.generateCodeVerifier();
        expect(verifier.length, equals(128));
      });
    });

    group('SpotifyApiCredentials.pkce', () {
      test('creates PKCE credentials without client secret', () {
        final verifier = SpotifyApi.generateCodeVerifier();
        final credentials = SpotifyApiCredentials.pkce(
          'test-client-id',
          codeVerifier: verifier,
        );

        expect(credentials.clientId, equals('test-client-id'));
        expect(credentials.clientSecret, isNull);
        expect(credentials.codeVerifier, equals(verifier));
        expect(credentials.isPkce, isTrue);
      });

      test('PKCE credentials are not fully qualified without tokens', () {
        final verifier = SpotifyApi.generateCodeVerifier();
        final credentials = SpotifyApiCredentials.pkce(
          'test-client-id',
          codeVerifier: verifier,
        );

        expect(credentials.fullyQualified, isFalse);
      });

      test('PKCE credentials are fully qualified with all tokens', () {
        final verifier = SpotifyApi.generateCodeVerifier();
        final credentials = SpotifyApiCredentials.pkce(
          'test-client-id',
          codeVerifier: verifier,
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
          scopes: ['scope1', 'scope2'],
          expiration: DateTime.now().add(Duration(hours: 1)),
        );

        expect(credentials.fullyQualified, isTrue);
      });

      test('PKCE credentials have correct token endpoint', () {
        final verifier = SpotifyApi.generateCodeVerifier();
        final credentials = SpotifyApiCredentials.pkce(
          'test-client-id',
          codeVerifier: verifier,
        );

        expect(credentials.tokenEndpoint, isNotNull);
        expect(
          credentials.tokenEndpoint.toString(),
          equals('https://accounts.spotify.com/api/token'),
        );
      });
    });

    group('SpotifyApiCredentials with codeVerifier', () {
      test('traditional credentials with codeVerifier', () {
        final verifier = SpotifyApi.generateCodeVerifier();
        final credentials = SpotifyApiCredentials(
          'client-id',
          'client-secret',
          codeVerifier: verifier,
        );

        expect(credentials.codeVerifier, equals(verifier));
        expect(credentials.isPkce, isFalse); // Has secret, so not PKCE
      });

      test('fullyQualified works with client secret', () {
        final credentials = SpotifyApiCredentials(
          'client-id',
          'client-secret',
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
          scopes: ['scope1'],
          expiration: DateTime.now().add(Duration(hours: 1)),
        );

        expect(credentials.fullyQualified, isTrue);
      });

      test('fullyQualified works with code verifier only', () {
        final verifier = SpotifyApi.generateCodeVerifier();
        final credentials = SpotifyApiCredentials(
          'client-id',
          null, // No secret
          codeVerifier: verifier,
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
          scopes: ['scope1'],
          expiration: DateTime.now().add(Duration(hours: 1)),
        );

        expect(credentials.fullyQualified, isTrue);
      });

      test('fullyQualified fails without secret or verifier', () {
        final credentials = SpotifyApiCredentials(
          'client-id',
          null, // No secret, no verifier
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
          scopes: ['scope1'],
          expiration: DateTime.now().add(Duration(hours: 1)),
        );

        expect(credentials.fullyQualified, isFalse);
      });

      test('credentials with null values', () {
        final credentials = SpotifyApiCredentials(
          'client-id',
          null,
        );

        expect(credentials.clientId, equals('client-id'));
        expect(credentials.clientSecret, isNull);
        expect(credentials.codeVerifier, isNull);
        expect(credentials.isPkce, isFalse);
        expect(credentials.fullyQualified, isFalse);
      });
    });

    group('isPkce getter', () {
      test('returns true for PKCE-only credentials', () {
        final verifier = SpotifyApi.generateCodeVerifier();
        final credentials = SpotifyApiCredentials(
          'client-id',
          null,
          codeVerifier: verifier,
        );

        expect(credentials.isPkce, isTrue);
      });

      test('returns false when client secret exists', () {
        final verifier = SpotifyApi.generateCodeVerifier();
        final credentials = SpotifyApiCredentials(
          'client-id',
          'client-secret',
          codeVerifier: verifier,
        );

        expect(credentials.isPkce, isFalse);
      });

      test('returns false without code verifier', () {
        final credentials = SpotifyApiCredentials(
          'client-id',
          'client-secret',
        );

        expect(credentials.isPkce, isFalse);
      });

      test('returns false for credentials with only secret', () {
        final credentials = SpotifyApiCredentials(
          'client-id',
          'client-secret',
        );

        expect(credentials.isPkce, isFalse);
        expect(credentials.codeVerifier, isNull);
      });

      test('returns false for credentials with neither secret nor verifier', () {
        final credentials = SpotifyApiCredentials(
          'client-id',
          null,
        );

        expect(credentials.isPkce, isFalse);
        expect(credentials.codeVerifier, isNull);
        expect(credentials.clientSecret, isNull);
      });
    });

    group('Backward Compatibility', () {
      test('credentials without codeVerifier work as before', () {
        final credentials = SpotifyApiCredentials(
          'client-id',
          'client-secret',
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
          scopes: ['scope1', 'scope2'],
          expiration: DateTime.now().add(Duration(hours: 1)),
        );

        expect(credentials.fullyQualified, isTrue);
        expect(credentials.codeVerifier, isNull);
        expect(credentials.isPkce, isFalse);
      });

      test('withAccessToken constructor still works', () {
        final credentials = SpotifyApiCredentials.withAccessToken('test-token');

        expect(credentials.accessToken, equals('test-token'));
        expect(credentials.clientId, isNull);
        expect(credentials.clientSecret, isNull);
        expect(credentials.codeVerifier, isNull);
        expect(credentials.isPkce, isFalse);
      });
    });

    group('canRefresh getter', () {
      test('returns true with refresh token and endpoint', () {
        final credentials = SpotifyApiCredentials.pkce(
          'client-id',
          codeVerifier: SpotifyApi.generateCodeVerifier(),
          refreshToken: 'refresh-token',
        );

        expect(credentials.canRefresh, isTrue);
      });

      test('returns false without refresh token', () {
        final credentials = SpotifyApiCredentials.pkce(
          'client-id',
          codeVerifier: SpotifyApi.generateCodeVerifier(),
        );

        expect(credentials.canRefresh, isFalse);
      });
    });

    group('isExpired getter', () {
      test('returns true for expired credentials', () {
        final credentials = SpotifyApiCredentials.pkce(
          'client-id',
          codeVerifier: SpotifyApi.generateCodeVerifier(),
          expiration: DateTime.now().subtract(Duration(hours: 1)),
        );

        expect(credentials.isExpired, isTrue);
      });

      test('returns false for valid credentials', () {
        final credentials = SpotifyApiCredentials.pkce(
          'client-id',
          codeVerifier: SpotifyApi.generateCodeVerifier(),
          expiration: DateTime.now().add(Duration(hours: 1)),
        );

        expect(credentials.isExpired, isFalse);
      });

      test('returns false when expiration is null', () {
        final credentials = SpotifyApiCredentials.pkce(
          'client-id',
          codeVerifier: SpotifyApi.generateCodeVerifier(),
        );

        expect(credentials.isExpired, isFalse);
      });
    });
  });
}
