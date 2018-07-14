// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class AudioFeatures extends EndpointBase {
  @override
  String get _path => 'v1/audio-features';

  AudioFeatures(SpotifyApiBase api) : super(api);

  Future<AudioFeature> get(String trackId) async {
    var json = await _api._get('$_path/$trackId');
    var map = JSON.decode(json);

    return AudioFeature.fromJson(map);
  }

  Future<Iterable<AudioFeature>> list(Iterable<String> trackIds) async {
    var json = await _api._get('$_path?ids=${trackIds.join(',')}');
    var map = JSON.decode(json);

    var artistsMap = map['audio-features'] as Iterable<dynamic>;
    return artistsMap.map((m) => AudioFeature.fromJson(m));
  }
}
