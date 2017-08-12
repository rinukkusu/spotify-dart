part of spotify;

@JsonClass()
class Image {
  /// The image height in pixels. If unknown: null or not returned.
  int height;

  /// The image width in pixels. If unknown: null or not returned.
  int width;
  
  /// The source URL of the image. 
  String url;
}