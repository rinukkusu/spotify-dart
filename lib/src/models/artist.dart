part of spotify;

@JsonClass()
class Artist implements ArtistSimple {
  // /// Known external URLs for this artist.
  //@JsonField(key: 'external_urls')
  //Map<String, String> externalUrls;

  /// A link to the Web API endpoint providing full details of the artist.
  String href;

  /// The Spotify ID for the artist. 
  String id;

  /// The name of the artist
  String name;

  /// The object type: "artist"
  String type;

  /// The Spotify URI for the artist.
  String uri;

  /// Information about the followers of the artist.
  Followers followers;

  /**
   * A list of the genres the artist is associated with. 
   * For example: 
   *    "Prog Rock", "Post-Grunge". 
   * 
   * (If not yet classified, the array is empty.) 
   */
  List<String> genres;

  /// Images of the artist in various sizes, widest first.
  List<Image> images;

  /**
   * The popularity of the artist. The value will be between 0 and 100, with 100
   * being the most popular. The artist's popularity is calculated from the 
   * popularity of all the artist's tracks.
   */
  int popularity;
}

@JsonClass()
class ArtistSimple {
  // /// Known external URLs for this artist.
  //@JsonField(key: 'external_urls')
  //Map<String, String> externalUrls;

  /// A link to the Web API endpoint providing full details of the artist.
  String href;

  /// The Spotify ID for the artist. 
  String id;

  /// The name of the artist
  String name;

  /// The object type: "artist"
  String type;

  /// The Spotify URI for the artist.
  String uri;
}