part of spotify;

class RecommendationsEndpoint extends EndpointBase {
  @override
  String get _path => "v1/recommendations";

  RecommendationsEndpoint(SpotifyApiBase api) : super(api);

  /// Generates a list of size [limit] of tracks based on
  /// [seedArtists], [seedGenres], [seedTracks] spotify IDs
  /// [min] [max] and [target] sets Tunable Track attributes limitations
  /// (see https://developer.spotify.com/documentation/web-api/reference/browse/get-recommendations/)
  Future<Recommendations> get(
      {Iterable<String> seedArtists,
      Iterable<String> seedGenres,
      Iterable<String> seedTracks,
      int limit = 20,
      String market,
      Map<String, num> max,
      Map<String, num> min,
      Map<String, num> target}) async {
    assert(limit >= 1 && limit <= 100, "limit should be 1 <= limit <= 100");
    final seedsNum = (seedArtists?.length ?? 0) + (seedGenres?.length ?? 0) + (seedTracks?.length ?? 0);
    assert(
        seedsNum >= 1 && seedsNum <= 5,
        "Up to 5 seed values may be provided in any combination of seed_artists,"
        " seed_tracks and seed_genres.");
    final parameters = <String, String>{'limit': limit.toString()};
    final _ = {
      'seed_artists': seedArtists,
      'seed_genres': seedGenres,
      'seed_tracks': seedTracks
    }.forEach((key, list) => _addList(parameters, key, list));
    if (market != null) parameters['market'] = market;
    [min, max, target].forEach((map) => _addTunableTrackMap(parameters, map));
    final pathQuery = Uri(path: _path, queryParameters: parameters).toString().replaceAll(RegExp(r'%2C'), ',');
    final result = jsonDecode(await _api._get(pathQuery));
    return Recommendations.fromJson(result);
  }

  /// gets [parameters], a map of the request's uri parameters,
  /// and [tunableTrackMap] a map of tunable Track Attributes.
  /// adds the attributes to [parameters]
  _addTunableTrackMap(
      Map<String, String> parameters, Map<String, num> tunableTrackMap) {
    if (tunableTrackMap != null)
      parameters.addAll(tunableTrackMap.map<String, String>((k, v) =>
          MapEntry(k, v is int ? v.toString() : v.toStringAsFixed(2))));
  }

  /// gets [parameters], a map of the request's uri parameters and
  /// adds an entry with [key] and value of [paramList] as comma separated list
  _addList(
      Map<String, String> parameters, String key, Iterable<String> paramList) {
    if ((paramList?.length ?? 0) > 0) parameters[key] = paramList.join(',');
  }
}
