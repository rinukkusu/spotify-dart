// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class AudioFeatures extends EndpointBase {
  @override
  String get _path => 'v1/audio-features';

  AudioFeatures(SpotifyApiBase api) : super(api);

  Future<AudioFeature> get(String id) async {
    var json = await _api._get('$_path/$id');
    return AudioFeatureMapper.fromJson(json);
  }

  Future<Iterable<AudioFeature>> list(Iterable<String> ids) async {
    var json = await _api._get('$_path?ids=${ids.join(',')}');
    var map = JSON.decode(json);

    var artistsMap = map['audio-features'] as Iterable<Map>;
    return artistsMap.map((m) => AudioFeatureMapper.parse(m));
  }
}
