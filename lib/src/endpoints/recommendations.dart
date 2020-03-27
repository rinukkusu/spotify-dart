part of spotify;

class RecommendationsEndpoint extends EndpointBase{
  @override
  String get _path => "v1/recommendations";

  RecommendationsEndpoint(SpotifyApiBase api) : super(api);

  /// Generates a list of size [limit] of tracks based on
  /// [seedArtists], [seedGenres], [seedTracks] spotify IDs
  /// [min] [max] and [target] sets Tunable Track attributes limitations
  /// (see https://developer.spotify.com/documentation/web-api/reference/browse/get-recommendations/)
  Future<Recommendations> get({
    Iterable<String> seedArtists,
    Iterable<String> seedGenres,
    Iterable<String> seedTracks,
    int limit = 20,
    String market,
    Map<String, num> max,
    Map<String, num> min,
    Map<String, num> target
    }) async {
    assert(limit >= 1 && limit >= 100, "limit should be 1 <= limit <= 100");
    final seedsNum = seedArtists.length + seedGenres.length + seedTracks.length;
    assert(seedsNum >= 1 && seedsNum <= 5,
      "Up to 5 seed values may be provided in any combination of seed_artists,"
          " seed_tracks and seed_genres.");
    final parameters = <String, String>{'limit': limit.toString()};
    if (seedArtists?.length ?? 0 > 0)
      parameters['seed_artists'] = seedArtists.join(',');
    if (seedGenres?.length ?? 0 > 0)
      parameters['seed_genres'] = seedGenres.join(',');
    if (seedTracks?.length ?? 0 > 0)
      parameters['seed_tracks'] = seedTracks.join(',');
    if (market != null)
      parameters['market'] = market;
    // TODO: add max min target
    final pathQuery = Uri(path: _path, queryParameters: parameters).toString();
    final result = jsonDecode(await _api._get(pathQuery));
    return Recommendations.fromJson(result);

  }
}
