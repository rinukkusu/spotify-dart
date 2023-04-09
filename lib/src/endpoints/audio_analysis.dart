// Copyright (c) 2021, grabajuice. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

/// Endpoint of a tracks audio analysis
class AudioAnalysisEndpoint extends EndpointBase {
  @override
  String get _path => 'v1/audio-analysis';

  AudioAnalysisEndpoint(SpotifyApiBase api) : super(api);

  Future<AudioAnalysis> get(String trackId) async {
    var jsonString = await _api._get('$_path/$trackId');
    var map = json.decode(jsonString);

    return AudioAnalysis.fromJson(map);
  }
}
