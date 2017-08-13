// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

abstract class EndpointBase {
  String get _path;
  final SpotifyApiBase _api;

  EndpointBase(this._api);

  Future<String> _get(String path) => _api._get(path);
  Future<String> _post(String path, String body) => _api._post(path, body);
}