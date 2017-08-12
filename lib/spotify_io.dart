// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// Support for doing something awesome.
///
/// More dartdocs go here.
library spotify;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:owl/annotation/json.dart';

import 'spotify_io.json.g.dart';

part 'src/models/token_request.dart';
part 'src/models/artist.dart';
part 'src/models/followers.dart';
part 'src/models/image.dart';

part 'src/endpoints/artists.dart';

part 'src/spotify_credentials.dart';

part 'src/spotify_base.dart';
part 'src/spotify_io.dart';


// TODO: Export any libraries intended for clients of this package.
