import 'package:spotify/spotify.dart';

void main() async {
  var credentials = SpotifyApiCredentials(
    'clientId',
    'clientSecret',
  );

  try {
    var spotify = await SpotifyApi.asyncFromCredentials(credentials);
    var search = await spotify.search.get(
      'Against The Current - weapon',
      types: [SearchType.track],
    ).first(1);

    print(search);
  } on AuthorizationException {
    print('Invalid credentials!');
  }
}
