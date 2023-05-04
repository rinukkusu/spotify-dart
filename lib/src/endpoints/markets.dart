part of spotify;

/// Endpoint for `v1/markets`
class Markets extends EndpointBase {
  @override
  String get _path => 'v1/markets';

  Markets(SpotifyApiBase api) : super(api);

  /// Get the list of markets where Spotify is available.
  /// A result of `null` means that the country is not mapped 
  /// in this library. 
  Future<Iterable<Market?>> get availableMarkets async {
    var jsonString = await _api._get(_path);
    var map = json.decode(jsonString);
    var markets = map['markets'] as Iterable<dynamic>;
    var marketsMap = Market.values.asNameMap();
    return markets.map((market) => marketsMap[market]);
  }
}
