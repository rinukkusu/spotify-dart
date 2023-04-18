part of spotify;

class Markets extends EndpointBase {
  @override
  String get _path => 'v1/markets';

  Markets(SpotifyApiBase api) : super(api);

  /// Get the list of markets where Spotify is available.
  Future<Iterable<CountryCode>> get availableMarkets async {
    var jsonString = await _api._get(_path);
    var map = json.decode(jsonString);
    var markets = map['markets'] as Iterable<dynamic>;
    return markets.map((market) => CountryCode.ofAlpha(market));
  }
}
