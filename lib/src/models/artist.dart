part of spotify;

@JsonClass()
class Artist implements ArtistSimple {
  //@JsonField(key: 'external_urls')
  //Map<String, String> externalUrls;
  String href;
  String id;
  String name;
  String type;
  String uri;
  Followers followers;
  List<String> genres;
  List<Image> images;
  int popularity;
}

@JsonClass()
class ArtistSimple {
  //@JsonField(key: 'external_urls')
  //Map<String, String> externalUrls;
  String href;
  String id;
  String name;
  String type;
  String uri;
}