// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of '../../spotify.dart';

/// Endpoint of audio features `v1/audio-features`
@Deprecated(
  'The Spotify Audio Features endpoint has been officially deprecated '
  'by Spotify. '
  'This functionality may be removed in a future version of this library.',
)
class AudioFeatures extends EndpointBase {
  @override
  String get _path => 'v1/audio-features';

  AudioFeatures(super.api);

  /// Returns audio features of a track with [trackId]
  @Deprecated(
    'The Spotify Audio Features endpoint has been officially deprecated '
    'by Spotify. '
    'This functionality may be removed in a future version of this library.',
  )
  Future<AudioFeature> get(String trackId) async {
    final jsonString = await _api._get('$_path/$trackId');
    final map = json.decode(jsonString);

    return AudioFeature.fromJson(map);
  }

  /// Retrieve multiple audio features of tracks with [trackIds]
  @Deprecated(
    'The Spotify Audio Features endpoint has been officially deprecated '
    'by Spotify. '
    'This functionality may be removed in a future version of this library.',
  )
  Future<Iterable<AudioFeature>> list(List<String> trackIds) async =>
      _listWithIds(
        path: _path,
        ids: trackIds,
        jsonKey: 'audio_features',
        fromJson: AudioFeature.fromJson,
      );
}
