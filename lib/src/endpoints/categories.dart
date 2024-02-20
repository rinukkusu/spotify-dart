part of '../../spotify.dart';

/// Endpoint of browsing the categories `v1/browse/categories`
class Categories extends Browse {
  @override
  String get _path => '${super._path}/categories';

  Categories(super.api);

  /// [country] - a country: an ISO 3166-1 alpha-2 country code. Provide this
  /// parameter if you want to narrow the list of returned categories to those
  /// relevant to a particular country. If omitted, the returned items will be
  /// globally relevant.
  ///
  /// [locale] - the desired language, consisting of an ISO 639-1 language
  /// code and an ISO 3166-1 alpha-2 country code, joined by an underscore.
  /// For example: es_MX, meaning “Spanish (Mexico)”. Provide this parameter
  /// if you want the category metadata returned in a particular language. Note
  /// that, if locale is not supplied, or if the specified language is not
  /// available, all strings will be returned in the Spotify default language
  /// (American English). The locale parameter, combined with the country
  /// parameter, may give odd results if not carefully matched. For example
  /// country=SE&locale=de_DE will return a list of categories relevant to
  /// Sweden but as German language strings.
  Pages<Category> list({Market? country, String? locale}) {
    final query = _buildQuery({'country': country?.name, 'locale': locale});

    return _getPages(
      '$_path?$query',
      (json) => Category.fromJson(json),
      'categories',
      (json) => Category.fromJson(json),
    );
  }

  /// [country] - a country: an ISO 3166-1 alpha-2 country code. Provide this
  /// parameter to ensure that the category exists for a particular country.
  ///
  /// [locale] - the desired language, consisting of an ISO 639-1 language code
  /// and an ISO 3166-1 alpha-2 country code, joined by an underscore. For
  /// example: es_MX, meaning "Spanish (Mexico)". Provide this parameter if you
  /// want the category strings returned in a particular language. Note that,
  /// if locale is not supplied, or if the specified language is not available,
  /// the category strings returned will be in the Spotify default language
  /// (American English).
  ///
  /// [categoryId] - the Spotify category ID for the category.
  Future<Category> get(String categoryId,
      {Market? country, String? locale}) async {
    final query = _buildQuery({'country': country?.name, 'locale': locale});

    var jsonString = await _api._get('$_path/$categoryId?$query');
    var map = json.decode(jsonString);

    return Category.fromJson(map);
  }
}
