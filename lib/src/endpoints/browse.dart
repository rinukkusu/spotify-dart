part of spotify;

class Browse extends EndpointPaging {
  Browse(SpotifyApiBase api) : super(api);

  @override
  String get _path => 'v1/browse';

  /// Returns the new releases.
  ///
  /// [country] - a country: an ISO 3166-1 alpha-2 country code. Provide this
  /// parameter if you want to narrow the list of returned new releases to those
  /// relevant to a particular country. If omitted, the returned items will be
  /// globally relevant.
  Pages<AlbumSimple> getNewReleases({String? country}) {
    var params = _buildQuery({'country': country});

    return _getPages(
        '$_path/new-releases?$params',
        (json) => AlbumSimple.fromJson(json),
        'albums',
        (json) => AlbumSimple.fromJson(json));
  }
}
