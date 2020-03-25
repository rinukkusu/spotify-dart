part of spotify;

class Recommendations extends EndpointBase{
  @override
  String get _path => "v1/recommendations";

  Recommendations(SpotifyApiBase api) : super(api);


}
