// Copyright (c) 2022, 2023, chances, rinukkusu, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class PlayerEndpoint extends MeEndpointBase {
  @override
  String get _path => '${super._path}/player';

  PlayerEndpoint(SpotifyApiBase api) : super(api);

  /// Toggle Shuffle For User's Playback.
  ///
  /// Use [state] to toggle the shuffle. [true] to turn shuffle on and [false]
  /// to turn it off respectively.
  /// 
  /// Returns the current player state by making another request.
  /// See [playbackState([String market])];
  Future<Player> shuffle(bool state, [String? deviceId]) async {
    return _api._put('$_path/shuffle?' + _buildQuery({
                    'state': state,
                    'deviceId': deviceId})).then(playbackState);
  }

  /// Returns the current playback state, including progress, track
  /// and active device.
  @Deprecated('Use [playbackState] instead')
  Future<Player> player([String? market]) async {
    return playbackState(market);
  }

  /// Returns the current playback state, including progress, track
  /// and active device.
  Future<Player> playbackState([String? market]) async {
    var jsonString =
        await _api._get('$_path?' + _buildQuery({'market': market}));
    final map = json.decode(jsonString);
    return Player.fromJson(map);
  }

  /// Get the object currently being played on the user’s Spotify account.
  Future<Player> currentlyPlaying() async {
    final jsonString = await _api._get('$_path/currently-playing');

    if (jsonString.isEmpty) {
      return Player();
    }

    return Player.fromJson(json.decode(jsonString));
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
}
