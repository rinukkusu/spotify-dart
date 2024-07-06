part of '_models.dart';

/// Json representation of the playback queue
@JsonSerializable()
class Queue extends Object {
  Queue();

  factory Queue.fromJson(Map<String, dynamic> json) => _$QueueFromJson(json);

  Map<String, dynamic> toJson() => _$QueueToJson(this);

  /// The currently playing track in the queue
  @JsonKey(name: 'currently_playing')
  Track? currentlyPlaying;

  /// All of the tracks that are added in the queue
  List<Track>? queue;
}
