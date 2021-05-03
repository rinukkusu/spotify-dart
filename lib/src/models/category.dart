part of spotify.models;

@JsonSerializable(explicitToJson: true)
class Category extends Object {
  Category();

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  /// A link to the Web API endpoint returning full details of the category.
  String href;

  /// The category icon, in various sizes.
  List<Image> icons;

  /// The Spotify category ID of the category.
  String id;

  /// The name of the category.
  String name;
}
