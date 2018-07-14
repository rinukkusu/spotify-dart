// GENERATED CODE - DO NOT MODIFY BY HAND

part of spotify;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paging<T> _$PagingFromJson<T>(Map<String, dynamic> json) {
  return new Paging<T>()
    ..href = json['href'] as String
    ..itemsNative = json['items'] == null
        ? null
        : itemsNativeFromJson(json['items'] as List)
    ..limit = json['limit'] as int
    ..next = json['next'] as String
    ..offset = json['offset'] as int
    ..previous = json['previous'] as String
    ..total = json['total'] as int;
}

abstract class _$PagingSerializerMixin<T> {
  String get href;
  Iterable<dynamic> get itemsNative;
  int get limit;
  String get next;
  int get offset;
  String get previous;
  int get total;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'href': href,
        'items': itemsNative == null ? null : itemsNativeToJson(itemsNative),
        'limit': limit,
        'next': next,
        'offset': offset,
        'previous': previous,
        'total': total
      };
}

SpotifyError _$SpotifyErrorFromJson(Map<String, dynamic> json) {
  return new SpotifyError()
    ..status = json['status'] as int
    ..message = json['message'] as String;
}

abstract class _$SpotifyErrorSerializerMixin {
  int get status;
  String get message;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'status': status, 'message': message};
}

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return new Artist()
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String
    ..followers = json['followers'] == null
        ? null
        : new Followers.fromJson(json['followers'] as Map<String, dynamic>)
    ..genres = (json['genres'] as List)?.map((e) => e as String)?.toList()
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : new Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..popularity = json['popularity'] as int;
}

abstract class _$ArtistSerializerMixin {
  String get href;
  String get id;
  String get name;
  String get type;
  String get uri;
  Followers get followers;
  List<String> get genres;
  List<Image> get images;
  int get popularity;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'href': href,
        'id': id,
        'name': name,
        'type': type,
        'uri': uri,
        'followers': followers,
        'genres': genres,
        'images': images,
        'popularity': popularity
      };
}

ArtistSimple _$ArtistSimpleFromJson(Map<String, dynamic> json) {
  return new ArtistSimple()
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

abstract class _$ArtistSimpleSerializerMixin {
  String get href;
  String get id;
  String get name;
  String get type;
  String get uri;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'href': href,
        'id': id,
        'name': name,
        'type': type,
        'uri': uri
      };
}

Followers _$FollowersFromJson(Map<String, dynamic> json) {
  return new Followers()
    ..href = json['href'] as String
    ..total = json['total'] as int;
}

abstract class _$FollowersSerializerMixin {
  String get href;
  int get total;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'href': href, 'total': total};
}

Image _$ImageFromJson(Map<String, dynamic> json) {
  return new Image()
    ..height = json['height'] as int
    ..width = json['width'] as int
    ..url = json['url'] as String;
}

abstract class _$ImageSerializerMixin {
  int get height;
  int get width;
  String get url;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'height': height, 'width': width, 'url': url};
}

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return new Album()
    ..albumType = json['album_type'] as String
    ..artists = (json['artists'] as List)
        ?.map((e) => e == null
            ? null
            : new ArtistSimple.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..availableMarkets =
        (json['available_markets'] as List)?.map((e) => e as String)?.toList()
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : new Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String
    ..copyrights = (json['copyrights'] as List)
        ?.map((e) => e == null
            ? null
            : new Copyright.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..genres = (json['genres'] as List)?.map((e) => e as String)?.toList()
    ..label = json['label'] as String
    ..popularity = json['popularity'] as int
    ..releaseDate = json['release_date'] as String
    ..releaseDatePrecision = json['release_date_precision'] as String;
}

abstract class _$AlbumSerializerMixin {
  String get albumType;
  List<ArtistSimple> get artists;
  List<String> get availableMarkets;
  String get href;
  String get id;
  List<Image> get images;
  String get name;
  String get type;
  String get uri;
  List<Copyright> get copyrights;
  List<String> get genres;
  String get label;
  int get popularity;
  String get releaseDate;
  String get releaseDatePrecision;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'album_type': albumType,
        'artists': artists,
        'available_markets': availableMarkets,
        'href': href,
        'id': id,
        'images': images,
        'name': name,
        'type': type,
        'uri': uri,
        'copyrights': copyrights,
        'genres': genres,
        'label': label,
        'popularity': popularity,
        'release_date': releaseDate,
        'release_date_precision': releaseDatePrecision
      };
}

AlbumSimple _$AlbumSimpleFromJson(Map<String, dynamic> json) {
  return new AlbumSimple()
    ..albumType = json['album_type'] as String
    ..artists = (json['artists'] as List)
        ?.map((e) => e == null
            ? null
            : new ArtistSimple.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..availableMarkets =
        (json['available_markets'] as List)?.map((e) => e as String)?.toList()
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : new Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

abstract class _$AlbumSimpleSerializerMixin {
  String get albumType;
  List<ArtistSimple> get artists;
  List<String> get availableMarkets;
  String get href;
  String get id;
  List<Image> get images;
  String get name;
  String get type;
  String get uri;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'album_type': albumType,
        'artists': artists,
        'available_markets': availableMarkets,
        'href': href,
        'id': id,
        'images': images,
        'name': name,
        'type': type,
        'uri': uri
      };
}

Copyright _$CopyrightFromJson(Map<String, dynamic> json) {
  return new Copyright()
    ..text = json['text'] as String
    ..type = json['type'] as String;
}

abstract class _$CopyrightSerializerMixin {
  String get text;
  String get type;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'text': text, 'type': type};
}

Track _$TrackFromJson(Map<String, dynamic> json) {
  return new Track()
    ..album = json['album'] == null
        ? null
        : new AlbumSimple.fromJson(json['album'] as Map<String, dynamic>)
    ..artists = (json['artists'] as List)
        ?.map((e) =>
            e == null ? null : new Artist.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..availableMarkets =
        (json['available_markets'] as List)?.map((e) => e as String)?.toList()
    ..discNumber = json['disc_number'] as int
    ..durationMs = json['duration_ms'] as int
    ..explicit = json['explicit'] as bool
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..isPlayable = json['is_playable'] as bool
    ..linkedFrom = json['linked_from'] == null
        ? null
        : new TrackLink.fromJson(json['linked_from'] as Map<String, dynamic>)
    ..name = json['name'] as String
    ..popularity = json['popularity'] as int
    ..previewUrl = json['preview_url'] as String
    ..trackNumber = json['track_number'] as int
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

abstract class _$TrackSerializerMixin {
  AlbumSimple get album;
  List<Artist> get artists;
  List<String> get availableMarkets;
  int get discNumber;
  int get durationMs;
  bool get explicit;
  String get href;
  String get id;
  bool get isPlayable;
  TrackLink get linkedFrom;
  String get name;
  int get popularity;
  String get previewUrl;
  int get trackNumber;
  String get type;
  String get uri;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'album': album,
        'artists': artists,
        'available_markets': availableMarkets,
        'disc_number': discNumber,
        'duration_ms': durationMs,
        'explicit': explicit,
        'href': href,
        'id': id,
        'is_playable': isPlayable,
        'linked_from': linkedFrom,
        'name': name,
        'popularity': popularity,
        'preview_url': previewUrl,
        'track_number': trackNumber,
        'type': type,
        'uri': uri
      };
}

TrackSimple _$TrackSimpleFromJson(Map<String, dynamic> json) {
  return new TrackSimple()
    ..artists = (json['artists'] as List)
        ?.map((e) =>
            e == null ? null : new Artist.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..availableMarkets =
        (json['available_markets'] as List)?.map((e) => e as String)?.toList()
    ..discNumber = json['disc_number'] as int
    ..durationMs = json['duration_ms'] as int
    ..explicit = json['explicit'] as bool
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..isPlayable = json['is_playable'] as bool
    ..linkedFrom = json['linked_from'] == null
        ? null
        : new TrackLink.fromJson(json['linked_from'] as Map<String, dynamic>)
    ..name = json['name'] as String
    ..previewUrl = json['preview_url'] as String
    ..trackNumber = json['track_number'] as int
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

abstract class _$TrackSimpleSerializerMixin {
  List<Artist> get artists;
  List<String> get availableMarkets;
  int get discNumber;
  int get durationMs;
  bool get explicit;
  String get href;
  String get id;
  bool get isPlayable;
  TrackLink get linkedFrom;
  String get name;
  String get previewUrl;
  int get trackNumber;
  String get type;
  String get uri;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'artists': artists,
        'available_markets': availableMarkets,
        'disc_number': discNumber,
        'duration_ms': durationMs,
        'explicit': explicit,
        'href': href,
        'id': id,
        'is_playable': isPlayable,
        'linked_from': linkedFrom,
        'name': name,
        'preview_url': previewUrl,
        'track_number': trackNumber,
        'type': type,
        'uri': uri
      };
}

TrackSaved _$TrackSavedFromJson(Map<String, dynamic> json) {
  return new TrackSaved()
    ..addedAt = json['added_at'] == null
        ? null
        : DateTime.parse(json['added_at'] as String)
    ..track = json['track'] == null
        ? null
        : new Track.fromJson(json['track'] as Map<String, dynamic>);
}

abstract class _$TrackSavedSerializerMixin {
  DateTime get addedAt;
  Track get track;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'added_at': addedAt?.toIso8601String(), 'track': track};
}

TrackLink _$TrackLinkFromJson(Map<String, dynamic> json) {
  return new TrackLink()
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

abstract class _$TrackLinkSerializerMixin {
  String get href;
  String get id;
  String get type;
  String get uri;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'href': href, 'id': id, 'type': type, 'uri': uri};
}

TracksLink _$TracksLinkFromJson(Map<String, dynamic> json) {
  return new TracksLink()
    ..href = json['href'] as String
    ..total = json['total'] as int;
}

abstract class _$TracksLinkSerializerMixin {
  String get href;
  int get total;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'href': href, 'total': total};
}

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return new Playlist()
    ..collaborative = json['collaborative'] as bool
    ..description = json['description'] as String
    ..followers = json['followers'] == null
        ? null
        : new Followers.fromJson(json['followers'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : new Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..name = json['name'] as String
    ..owner = json['owner'] == null
        ? null
        : new User.fromJson(json['owner'] as Map<String, dynamic>)
    ..public = json['public'] as bool
    ..snapshotId = json['snapshot_id'] as String
    ..tracks = (json['tracks'] as List)
        ?.map((e) =>
            e == null ? null : new Track.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

abstract class _$PlaylistSerializerMixin {
  bool get collaborative;
  String get description;
  Followers get followers;
  String get href;
  String get id;
  List<Image> get images;
  String get name;
  User get owner;
  bool get public;
  String get snapshotId;
  List<Track> get tracks;
  String get type;
  String get uri;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'collaborative': collaborative,
        'description': description,
        'followers': followers,
        'href': href,
        'id': id,
        'images': images,
        'name': name,
        'owner': owner,
        'public': public,
        'snapshot_id': snapshotId,
        'tracks': tracks,
        'type': type,
        'uri': uri
      };
}

PlaylistSimple _$PlaylistSimpleFromJson(Map<String, dynamic> json) {
  return new PlaylistSimple()
    ..collaborative = json['collaborative'] as bool
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : new Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..name = json['name'] as String
    ..owner = json['owner'] == null
        ? null
        : new User.fromJson(json['owner'] as Map<String, dynamic>)
    ..public = json['public'] as bool
    ..snapshotId = json['snapshot_id'] as String
    ..tracksLink = json['tracks'] == null
        ? null
        : new TracksLink.fromJson(json['tracks'] as Map<String, dynamic>)
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

abstract class _$PlaylistSimpleSerializerMixin {
  bool get collaborative;
  String get href;
  String get id;
  List<Image> get images;
  String get name;
  User get owner;
  bool get public;
  String get snapshotId;
  TracksLink get tracksLink;
  String get type;
  String get uri;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'collaborative': collaborative,
        'href': href,
        'id': id,
        'images': images,
        'name': name,
        'owner': owner,
        'public': public,
        'snapshot_id': snapshotId,
        'tracks': tracksLink,
        'type': type,
        'uri': uri
      };
}

PlaylistsFeatured _$PlaylistsFeaturedFromJson(Map<String, dynamic> json) {
  return new PlaylistsFeatured()..message = json['message'] as String;
}

abstract class _$PlaylistsFeaturedSerializerMixin {
  String get message;
  Map<String, dynamic> toJson() => <String, dynamic>{'message': message};
}

PlaylistTrack _$PlaylistTrackFromJson(Map<String, dynamic> json) {
  return new PlaylistTrack()
    ..addedAt = json['added_at'] == null
        ? null
        : DateTime.parse(json['added_at'] as String)
    ..addedBy = json['added_by'] == null
        ? null
        : new UserPublic.fromJson(json['added_by'] as Map<String, dynamic>)
    ..isLocal = json['is_local'] as bool
    ..track = json['track'] == null
        ? null
        : new Track.fromJson(json['track'] as Map<String, dynamic>);
}

abstract class _$PlaylistTrackSerializerMixin {
  DateTime get addedAt;
  UserPublic get addedBy;
  bool get isLocal;
  Track get track;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'added_at': addedAt?.toIso8601String(),
        'added_by': addedBy,
        'is_local': isLocal,
        'track': track
      };
}

User _$UserFromJson(Map<String, dynamic> json) {
  return new User()
    ..birthdate = json['birthdate'] as String
    ..country = json['country'] as String
    ..displayName = json['display_name'] as String
    ..email = json['email'] as String
    ..followers = json['followers'] == null
        ? null
        : new Followers.fromJson(json['followers'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : new Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..product = json['product'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

abstract class _$UserSerializerMixin {
  String get birthdate;
  String get country;
  String get displayName;
  String get email;
  Followers get followers;
  String get href;
  String get id;
  List<Image> get images;
  String get product;
  String get type;
  String get uri;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'birthdate': birthdate,
        'country': country,
        'display_name': displayName,
        'email': email,
        'followers': followers,
        'href': href,
        'id': id,
        'images': images,
        'product': product,
        'type': type,
        'uri': uri
      };
}

UserPublic _$UserPublicFromJson(Map<String, dynamic> json) {
  return new UserPublic()
    ..displayName = json['display_name'] as String
    ..followers = json['followers'] == null
        ? null
        : new Followers.fromJson(json['followers'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : new Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

abstract class _$UserPublicSerializerMixin {
  String get displayName;
  Followers get followers;
  String get href;
  String get id;
  List<Image> get images;
  String get type;
  String get uri;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'display_name': displayName,
        'followers': followers,
        'href': href,
        'id': id,
        'images': images,
        'type': type,
        'uri': uri
      };
}

AudioFeature _$AudioFeatureFromJson(Map<String, dynamic> json) {
  return new AudioFeature()
    ..acousticness = (json['acousticness'] as num)?.toDouble()
    ..analysisUrl = json['analysis_url'] as String
    ..danceability = (json['danceability'] as num)?.toDouble()
    ..durationMs = json['duration_ms'] as int
    ..energy = (json['energy'] as num)?.toDouble()
    ..id = json['id'] as String
    ..instrumentalness = (json['instrumentalness'] as num)?.toDouble()
    ..key = json['key'] as int
    ..liveness = (json['liveness'] as num)?.toDouble()
    ..loudness = (json['loudness'] as num)?.toDouble()
    ..mode = json['mode'] as int
    ..speechiness = (json['speechiness'] as num)?.toDouble()
    ..tempo = (json['tempo'] as num)?.toDouble()
    ..timeSignature = json['time_signature'] as int
    ..trackHref = json['track_href'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String
    ..valence = (json['valence'] as num)?.toDouble();
}

abstract class _$AudioFeatureSerializerMixin {
  double get acousticness;
  String get analysisUrl;
  double get danceability;
  int get durationMs;
  double get energy;
  String get id;
  double get instrumentalness;
  int get key;
  double get liveness;
  double get loudness;
  int get mode;
  double get speechiness;
  double get tempo;
  int get timeSignature;
  String get trackHref;
  String get type;
  String get uri;
  double get valence;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'acousticness': acousticness,
        'analysis_url': analysisUrl,
        'danceability': danceability,
        'duration_ms': durationMs,
        'energy': energy,
        'id': id,
        'instrumentalness': instrumentalness,
        'key': key,
        'liveness': liveness,
        'loudness': loudness,
        'mode': mode,
        'speechiness': speechiness,
        'tempo': tempo,
        'time_signature': timeSignature,
        'track_href': trackHref,
        'type': type,
        'uri': uri,
        'valence': valence
      };
}
