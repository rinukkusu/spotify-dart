// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

/// Endpoint of audio features `v1/audio-features`
class AudioFeatures extends EndpointBase {
  @override
  String get _path => 'v1/audio-features';

  AudioFeatures(SpotifyApiBase api) : super(api);

  /// Returns audio features of a track with [trackId]
  Future<AudioFeature> get(String trackId) async {
    var jsonString = await _api._get('$_path/$trackId');
    var map = json.decode(jsonString);

    return AudioFeature.fromJson(map);
  }

  /// Retrieve multiple audio features of tracks with [trackIds]
  Future<Iterable<AudioFeature>> list(Iterable<String> trackIds) async {
    var jsonString = await _api._get('$_path?ids=${trackIds.join(',')}');
    var map = json.decode(jsonString);

    var artistsMap = map['audio_features'] as Iterable<dynamic>;
    return artistsMap.map((m) => AudioFeature.fromJson(m));
  }
}
