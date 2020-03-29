// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library spotify;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'dart:io' // Default
    if (dart.library.io) 'dart:io'
    if (dart.library.html) 'dart:html';

import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart';

import 'src/models/_models.dart';

export 'src/models/_models.dart';

part 'src/endpoints/endpoint_base.dart';
part 'src/endpoints/endpoint_paging.dart';
part 'src/endpoints/artists.dart';
part 'src/endpoints/albums.dart';
part 'src/endpoints/tracks.dart';
part 'src/endpoints/playlists.dart';
part 'src/endpoints/users.dart';
part 'src/endpoints/search.dart';
part 'src/endpoints/audio_features.dart';
part 'src/endpoints/categories.dart';

part 'src/spotify_credentials.dart';
part 'src/spotify_base.dart';
part 'src/spotify_exception.dart';
part 'src/spotify.dart';
part 'src/spotify_mock.dart';
