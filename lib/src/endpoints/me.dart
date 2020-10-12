// Copyright (c) 2019, chances, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Me extends EndpointPaging {
  @override
  String get _path => 'v1/me';

  Me(SpotifyApiBase api) : super(api);

  Future<User> get() async {
    var jsonString = await _api._get(_path);
    var map = json.decode(jsonString);

    return User.fromJson(map);
  }

  /// Endpoint /v1/me/following only supports "artist" type at the moment.
  BundledPages following(FollowingType type) {
    return _getBundledPages('$_path/following?type=${type.key}', {
      'artists': (json) => Artist.fromJson(json),
    });
  }

  Future<Player> currentlyPlaying() async {
    var jsonString = await _api._get('$_path/player/currently-playing');

    if (jsonString.isEmpty) {
      return Player();
    }

    var map = json.decode(jsonString);
    return Player.fromJson(map);
  }

  Future<Iterable<PlayHistory>> recentlyPlayed(
      {int limit, DateTime after, DateTime before}) async {
    assert(after == null || before == null,
        'Cannot specify both after and before.');

    final jsonString = await _api._get('$_path/player/recently-played?' +
        _buildQuery({
          'limit': limit,
          'after': after?.millisecondsSinceEpoch,
          'before': before?.millisecondsSinceEpoch
        }));
    final map = json.decode(jsonString);
    return map['items'].map((item) => PlayHistory.fromJson(item));
  }

  Future<Iterable<Track>> topTracks() async {
    var jsonString = await _api._get('$_path/top/tracks');
    var map = json.decode(jsonString);

    var items = map['items'] as Iterable<dynamic>;
    return items.map((item) => Track.fromJson(item));
  }

  Future<Iterable<Artist>> topArtists() async {
    var jsonString = await _api._get('$_path/top/artists');
    var map = json.decode(jsonString);

    var items = map['items'] as Iterable<dynamic>;
    return items.map((item) => Artist.fromJson(item));
  }

  Future<Iterable<Device>> devices() async {
    return _api._get('$_path/player/devices').then(_parseDeviceJson);
  }

  Iterable<Device> _parseDeviceJson(String jsonString) {
    var map = json.decode(jsonString);

    var items = map['devices'] as Iterable<dynamic>;
    return items.map((item) => Device.fromJson(item));
  }
}

class FollowingType {
  final String _key;

  const FollowingType(this._key);

  String get key => _key;

  static const artist = FollowingType('artist');
}
