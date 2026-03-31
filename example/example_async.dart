import 'package:spotify/spotify.dart';

void main() async {
  final credentials = SpotifyApiCredentials(
    'clientId',
    'clientSecret',
  );

  try {
    final spotify = await SpotifyApi.asyncFromCredentials(credentials);
    defaultLimit = 1;
    final search = await spotify.search.get(
      'Against The Current - weapon',
      types: [SearchType.track],
    ).first();

    print(search);
  } on AuthorizationException {
    print('Invalid credentials!');
  }
}
