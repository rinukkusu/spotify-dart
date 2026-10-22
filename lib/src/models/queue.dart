part of '_models.dart';

/// Json representation of the playback queue
@JsonSerializable()
class Queue extends Object {
  Queue();

  factory Queue.fromJson(Map<String, dynamic> json) => _$QueueFromJson(json);

  Map<String, dynamic> toJson() => _$QueueToJson(this);

  static List<PlayableContent>? _queueFromJson(List<dynamic>? items) {
    return items
        ?.map((item) => _playableContentFromJson(item as Map<String, dynamic>?))
        .whereType<PlayableContent>()
        .toList();
  }

  /// The currently playing track or episode in the queue
  @JsonKey(name: 'currently_playing', fromJson: _playableContentFromJson)
  PlayableContent? currentlyPlaying;

  /// The queued tracks and episodes, in playback order.
  /// Unavailable items and unrecognized item types are omitted.
  @JsonKey(fromJson: _queueFromJson)
  List<PlayableContent>? queue;
}
