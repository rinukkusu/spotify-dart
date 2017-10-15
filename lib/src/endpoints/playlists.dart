// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class Playlists extends EndpointPaging {
  @override
  String get _path => 'v1/browse';

  Playlists(SpotifyApiBase api) : super(api);

   Pages<PlaylistSimple> get featured {
     return _getPages(
         '$_path/featured-playlists', PlaylistSimpleMapper.parse,
         'playlists', PlaylistsFeaturedMapper.parse
     );
   }

  Pages<PlaylistSimple> get me {
     return _getPages('v1/me/playlists', PlaylistSimpleMapper.parse);
  }
}
