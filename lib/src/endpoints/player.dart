// Copyright (c) 2022, 2023, chances, rinukkusu, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

/// Endpoint of the player
class PlayerEndpoint extends _MeEndpointBase {
  @override
  String get _path => '${super._path}/player';

  PlayerEndpoint(SpotifyApiBase api) : super(api);

  /// Toggle Shuffle For User's Playback.
  ///
  /// Use [state] to toggle the shuffle. `true` to turn shuffle on and `false`
  /// to turn it off respectively.
  /// [retrievePlaybackState] is optional. If true, the current playback state
  /// will be retrieved after setting the volume. Defaults to true.
  Future<PlaybackState?> shuffle(bool state,
      {String? deviceId, bool retrievePlaybackState = true}) async {
    await _api._put('$_path/shuffle?' +
        _buildQuery({'state': state, 'deviceId': deviceId}));

    return retrievePlaybackState ? playbackState() : null;
  }

  /// Returns the current playback state, including progress, track
  /// and active device.
  @Deprecated('Use [playbackState] instead')
  Future<PlaybackState> player([String? market]) async {
    return playbackState(market);
  }

  /// Returns the current playback state, including progress, track
  /// and active device.
  Future<PlaybackState> playbackState([String? market]) async {
    var jsonString =
        await _api._get('$_path?' + _buildQuery({'market': market}));
    final map = json.decode(jsonString);
    return PlaybackState.fromJson(map);
  }

  /// Get the object currently being played on the user’s Spotify account.
  Future<PlaybackState> currentlyPlaying() async {
    final jsonString = await _api._get('$_path/currently-playing');

    if (jsonString.isEmpty) {
      return PlaybackState();
    }

    return PlaybackState.fromJson(json.decode(jsonString));
  }

  // Get the currently playing as well as the queued objects.
  Future<Queue> queue() async {
    final jsonString = await _api._get('$_path/queue');

    if (jsonString.isEmpty) {
      return Queue();
    }

    final map = json.decode(jsonString);
    return Queue.fromJson(map);
  }

  // Add an object to the queue with a trackId.
  Future<void> addToQueue(String trackId) async {
    await _api._post('$_path/queue?uri=$trackId');
  }

  /// Get information about a user’s available devices.
  Future<Iterable<Device>> devices() async {
    return _api._get('$_path/devices').then(_parseDeviceJson);
  }

  Iterable<Device> _parseDeviceJson(String jsonString) {
    final map = json.decode(jsonString);

    final items = map['devices'] as Iterable<dynamic>;
    return items.map((item) => Device.fromJson(item));
  }

  /// Start a new context or resume current playback on the user's active device.
  /// [deviceId] is optional. If not provided, the user's currently active device
  /// is the target.
  /// [options] is optional. If not provided, playback will start
  /// from the context's current track.
  /// [retrievePlaybackState] is optional. If true, the current playback state
  /// will be retrieved. Defaults to true.
  Future<PlaybackState?> startOrResume(
      {String? deviceId,
      StartOrResumeOptions? options,
      bool retrievePlaybackState = true}) async {
    var body = options?.toJson();
    var json = jsonEncode(body ?? '');

    await _api._put(
        '$_path/play?' + _buildQuery({'device_id': deviceId}), json);

    return retrievePlaybackState ? playbackState() : null;
  }

  /// Pause playback on the user's account.
  /// [deviceId] is optional. If not provided, the user's currently active device
  /// is the target.
  /// [retrievePlaybackState] is optional. If true, the current playback state
  /// will be retrieved. Defaults to true.
  Future<PlaybackState?> pause(
      {String? deviceId, bool retrievePlaybackState = true}) async {
    await _api._put('$_path/pause?' + _buildQuery({'device_id': deviceId}));

    return retrievePlaybackState ? playbackState() : null;
  }

  /// Skips to previous track in the user’s queue.
  /// [deviceId] is optional. If not provided, the user's currently active device
  /// is the target.
  /// [retrievePlaybackState] is optional. If true, the current playback state
  /// will be retrieved. Defaults to true.
  Future<PlaybackState?> previous(
      {String? deviceId, bool retrievePlaybackState = true}) async {
    await _api._post('$_path/previous?' + _buildQuery({'device_id': deviceId}));

    return retrievePlaybackState ? playbackState() : null;
  }

  /// Skips to next track in the user’s queue.
  /// [deviceId] is optional. If not provided, the user's currently active device
  /// is the target.
  /// [retrievePlaybackState] is optional. If true, the current playback state
  /// will be retrieved. Defaults to true.
  Future<PlaybackState?> next(
      {String? deviceId, bool retrievePlaybackState = true}) async {
    await _api._post('$_path/next?' + _buildQuery({'device_id': deviceId}));

    return retrievePlaybackState ? playbackState() : null;
  }

  /// Seeks to the given position in the user’s currently playing track.
  /// [positionMs] is required. The position in milliseconds to seek to.
  /// [deviceId] is optional. If not provided, the user's currently active device
  /// is the target.
  /// [retrievePlaybackState] is optional. If true, the current playback state
  /// will be retrieved. Defaults to true.
  Future<PlaybackState?> seek(int positionMs,
      {String? deviceId, bool retrievePlaybackState = true}) async {
    assert(positionMs >= 0, 'positionMs must be greater or equal to 0');
    await _api._put('$_path/seek?' +
        _buildQuery({'position_ms': positionMs, 'device_id': deviceId}));

    return retrievePlaybackState ? playbackState() : null;
  }

  /// Set the repeat mode for the user’s playback.
  /// [state] is required. Options are: [RepeatState.off],
  /// [RepeatState.track], [RepeatState.context].
  /// [deviceId] is optional. If not provided, the user's currently active device
  /// is the target.
  /// [retrievePlaybackState] is optional. If true, the current playback state
  /// will be retrieved. Defaults to true.
  Future<PlaybackState?> repeat(RepeatState state,
      {String? deviceId, bool retrievePlaybackState = true}) async {
    await _api._put('$_path/repeat?' +
        _buildQuery({
          'state': state.toString().split('.').last,
          'device_id': deviceId
        }));

    return retrievePlaybackState ? playbackState() : null;
  }

  /// Set the volume for the user’s current playback device.
  /// [volumePercent] is required. The volume to set. Must be a value from 0 to
  /// 100 inclusive.
  /// [deviceId] is optional. If not provided, the user's currently active device
  /// is the target.
  /// [retrievePlaybackState] is optional. If true, the current playback state
  /// will be retrieved. Defaults to true.
  Future<PlaybackState?> volume(int volumePercent,
      {String? deviceId, bool retrievePlaybackState = true}) async {
    assert(volumePercent >= 0 && volumePercent <= 100,
        'Volume must be between 0 and 100');
    await _api._put('$_path/volume?' +
        _buildQuery({'volume_percent': volumePercent, 'device_id': deviceId}));

    return retrievePlaybackState ? playbackState() : null;
  }
}
