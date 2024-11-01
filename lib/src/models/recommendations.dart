part of '_models.dart';

/// Json representation of the recommendations
@JsonSerializable()
class Recommendations extends Object {
  Recommendations();

  factory Recommendations.fromJson(Map<String, dynamic> json) =>
      _$RecommendationsFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationsToJson(this);

  /// A List of [RecommendationsSeed] objects.
  List<RecommendationsSeed>? seeds;

  /// A List of [Track] objects ordered according to the parameters
  /// supplied.
  List<Track>? tracks;
}

/// Json representation of the recommendation seed
@JsonSerializable()
class RecommendationsSeed extends Object {
  RecommendationsSeed();

  factory RecommendationsSeed.fromJson(Map<String, dynamic> json) =>
      _$RecommendationsSeedFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationsSeedToJson(this);

  /// The number of tracks available after min_* and max_* filters
  /// have been applied.
  @JsonKey(fromJson: convertToIntIfDoubleValue)
  int? afterFilteringSize;

  /// The number of tracks available after relinking for regional availability.
  @JsonKey(fromJson: convertToIntIfDoubleValue)
  int? afterRelinkingSize;

  /// A link to the full track or artist data for this seed.
  /// For tracks this will be a link to a Track Object.
  /// For artists a link to an Artist Object.
  /// For genre seeds, this value will be null.
  String? href;

  /// The id used to select this seed.
  /// This will be the same as the string used in the seed_artists,
  /// seed_tracks or seed_genres parameter.
  String? id;

  /// The number of recommended tracks available for this seed.
  @JsonKey(fromJson: convertToIntIfDoubleValue)
  int? initialPoolSize;

  /// The entity type of this seed. One of artist, track or genre.
  String? type;
}
