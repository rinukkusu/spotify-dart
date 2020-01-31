// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

abstract class SpotifyApiBase {
  static const String _baseUrl = 'https://api.spotify.com';
  static const String _tokenUrl = 'https://accounts.spotify.com/api/token';
  static const String _authorizationUrl = 'https://accounts.spotify.com/authorize';

  Artists _artists;
  Albums _albums;
  Tracks _tracks;
  Playlists _playlists;
  Users _users;
  Search _search;
  AudioFeatures _audioFeatures;
  Categories _categories;

  Artists get artists => _artists;

  Albums get albums => _albums;

  Tracks get tracks => _tracks;

  Playlists get playlists => _playlists;

  Users get users => _users;

  Search get search => _search;

  AudioFeatures get audioFeatures => _audioFeatures;
  Categories get categories => _categories;

  SpotifyApiBase() {
    _artists = new Artists(this);
    _albums = new Albums(this);
    _tracks = new Tracks(this);
    _playlists = new Playlists(this);
    _users = new Users(this);
    _search = new Search(this);
    _audioFeatures = new AudioFeatures(this);
    _categories = Categories(this);
  }

  Future<String> _get(String path, Map<String, String> headers) {
    return _requestWrapper(path, (url) => _getImpl(url, headers));
  }

  Future<String> _post(String path, String body, Map<String, String> headers) {
    return _requestWrapper(
        path, (url) => _postImpl(url, headers, body));
  }

  Future<String> _delete(String path, String body, Map<String, String> headers) {
    return _requestWrapper(
        path, (url) => _deleteImpl(url, headers, body));
  }

  Future<String> _put(String path, String body, Map<String, String> headers) {
    return _requestWrapper(
        path, (url) => _putImpl(url, headers, body));
  }

  Future<String> _requestWrapper(String path,
      Future<String> req(String url)) async {
    var url = '${_baseUrl}/$path';
    return req(url);
  }

  Future<String> _getImpl(String url, Map<String, String> headers);

  Future<String> _postImpl(
      String url, Map<String, String> headers, dynamic body);

  Future<String> _deleteImpl(
      String url, Map<String, String> headers, dynamic body);

  Future<String> _putImpl(
      String url, Map<String, String> headers, dynamic body);
}
