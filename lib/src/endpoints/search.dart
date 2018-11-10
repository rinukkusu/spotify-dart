// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Search extends EndpointPaging {
  @override
  String get _path => 'v1/search';

  Search(SpotifyApiBase api) : super(api);

   Pages<Object> get(String searchQuery, [SearchType searchType = SearchType.all]){
     return _getBundledPages(
         '$_path?q=$searchQuery&type=${searchType.key}', {
           'playlists': (json) => PlaylistSimple.fromJson(json),
           'albums': (json) => Album.fromJson(json),
           'artists': (json) => ArtistSimple.fromJson(json),
           'tracks': (json) => Track.fromJson(json)
         }
     );
   }

  Pages<PlaylistSimple> get me {
     return _getPages('v1/me/playlists', (json) => Playlist.fromJson(json));
  }
}


class SearchType {

  final String _key;

  const SearchType(this._key);
  get key => _key;

  static const all = SearchType("album,artist,playlist,track");
  static const album = SearchType("album");
  static const artist = SearchType("artist");
  static const playlist = SearchType("playlist");
  static const track = SearchType("track");
}
