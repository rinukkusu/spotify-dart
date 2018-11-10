// GENERATED CODE - DO NOT MODIFY BY HAND

part of spotify;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paging<T> _$PagingFromJson<T>(Map<String, dynamic> json) {
  return Paging<T>()
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

Map<String, dynamic> _$PagingToJson<T>(Paging<T> instance) => <String, dynamic>{
      'href': instance.href,
      'items': instance.itemsNative == null
          ? null
          : itemsNativeToJson(instance.itemsNative),
      'limit': instance.limit,
      'next': instance.next,
      'offset': instance.offset,
      'previous': instance.previous,
      'total': instance.total
    };

SpotifyError _$SpotifyErrorFromJson(Map<String, dynamic> json) {
  return SpotifyError()
    ..status = json['status'] as int
    ..message = json['message'] as String;
}

Map<String, dynamic> _$SpotifyErrorToJson(SpotifyError instance) =>
    <String, dynamic>{'status': instance.status, 'message': instance.message};

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return Artist()
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String
    ..followers = json['followers'] == null
        ? null
        : Followers.fromJson(json['followers'] as Map<String, dynamic>)
    ..genres = (json['genres'] as List)?.map((e) => e as String)?.toList()
    ..images = (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..popularity = json['popularity'] as int;
}

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'uri': instance.uri,
      'followers': instance.followers,
      'genres': instance.genres,
      'images': instance.images,
      'popularity': instance.popularity
    };

ArtistSimple _$ArtistSimpleFromJson(Map<String, dynamic> json) {
  return ArtistSimple()
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$ArtistSimpleToJson(ArtistSimple instance) =>
    <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'uri': instance.uri
    };

Followers _$FollowersFromJson(Map<String, dynamic> json) {
  return Followers()
    ..href = json['href'] as String
    ..total = json['total'] as int;
}

Map<String, dynamic> _$FollowersToJson(Followers instance) =>
    <String, dynamic>{'href': instance.href, 'total': instance.total};

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image()
    ..height = json['height'] as int
    ..width = json['width'] as int
    ..url = json['url'] as String;
}

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'url': instance.url
    };

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return Album()
    ..albumType = json['album_type'] as String
    ..artists = (json['artists'] as List)
        ?.map((e) =>
            e == null ? null : ArtistSimple.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..availableMarkets =
        (json['available_markets'] as List)?.map((e) => e as String)?.toList()
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String
    ..copyrights = (json['copyrights'] as List)
        ?.map((e) =>
            e == null ? null : Copyright.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..genres = (json['genres'] as List)?.map((e) => e as String)?.toList()
    ..label = json['label'] as String
    ..popularity = json['popularity'] as int
    ..releaseDate = json['release_date'] as String
    ..releaseDatePrecision = json['release_date_precision'] as String;
}

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'album_type': instance.albumType,
      'artists': instance.artists,
      'available_markets': instance.availableMarkets,
      'href': instance.href,
      'id': instance.id,
      'images': instance.images,
      'name': instance.name,
      'type': instance.type,
      'uri': instance.uri,
      'copyrights': instance.copyrights,
      'genres': instance.genres,
      'label': instance.label,
      'popularity': instance.popularity,
      'release_date': instance.releaseDate,
      'release_date_precision': instance.releaseDatePrecision
    };

AlbumSimple _$AlbumSimpleFromJson(Map<String, dynamic> json) {
  return AlbumSimple()
    ..albumType = json['album_type'] as String
    ..artists = (json['artists'] as List)
        ?.map((e) =>
            e == null ? null : ArtistSimple.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..availableMarkets =
        (json['available_markets'] as List)?.map((e) => e as String)?.toList()
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$AlbumSimpleToJson(AlbumSimple instance) =>
    <String, dynamic>{
      'album_type': instance.albumType,
      'artists': instance.artists,
      'available_markets': instance.availableMarkets,
      'href': instance.href,
      'id': instance.id,
      'images': instance.images,
      'name': instance.name,
      'type': instance.type,
      'uri': instance.uri
    };

Copyright _$CopyrightFromJson(Map<String, dynamic> json) {
  return Copyright()
    ..text = json['text'] as String
    ..type = json['type'] as String;
}

Map<String, dynamic> _$CopyrightToJson(Copyright instance) =>
    <String, dynamic>{'text': instance.text, 'type': instance.type};

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track()
    ..album = json['album'] == null
        ? null
        : AlbumSimple.fromJson(json['album'] as Map<String, dynamic>)
    ..artists = (json['artists'] as List)
        ?.map((e) =>
            e == null ? null : Artist.fromJson(e as Map<String, dynamic>))
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
        : TrackLink.fromJson(json['linked_from'] as Map<String, dynamic>)
    ..name = json['name'] as String
    ..popularity = json['popularity'] as int
    ..previewUrl = json['preview_url'] as String
    ..trackNumber = json['track_number'] as int
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'album': instance.album,
      'artists': instance.artists,
      'available_markets': instance.availableMarkets,
      'disc_number': instance.discNumber,
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
      'href': instance.href,
      'id': instance.id,
      'is_playable': instance.isPlayable,
      'linked_from': instance.linkedFrom,
      'name': instance.name,
      'popularity': instance.popularity,
      'preview_url': instance.previewUrl,
      'track_number': instance.trackNumber,
      'type': instance.type,
      'uri': instance.uri
    };

TrackSimple _$TrackSimpleFromJson(Map<String, dynamic> json) {
  return TrackSimple()
    ..artists = (json['artists'] as List)
        ?.map((e) =>
            e == null ? null : Artist.fromJson(e as Map<String, dynamic>))
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
        : TrackLink.fromJson(json['linked_from'] as Map<String, dynamic>)
    ..name = json['name'] as String
    ..previewUrl = json['preview_url'] as String
    ..trackNumber = json['track_number'] as int
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$TrackSimpleToJson(TrackSimple instance) =>
    <String, dynamic>{
      'artists': instance.artists,
      'available_markets': instance.availableMarkets,
      'disc_number': instance.discNumber,
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
      'href': instance.href,
      'id': instance.id,
      'is_playable': instance.isPlayable,
      'linked_from': instance.linkedFrom,
      'name': instance.name,
      'preview_url': instance.previewUrl,
      'track_number': instance.trackNumber,
      'type': instance.type,
      'uri': instance.uri
    };

TrackSaved _$TrackSavedFromJson(Map<String, dynamic> json) {
  return TrackSaved()
    ..addedAt = json['added_at'] == null
        ? null
        : DateTime.parse(json['added_at'] as String)
    ..track = json['track'] == null
        ? null
        : Track.fromJson(json['track'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TrackSavedToJson(TrackSaved instance) =>
    <String, dynamic>{
      'added_at': instance.addedAt?.toIso8601String(),
      'track': instance.track
    };

TrackLink _$TrackLinkFromJson(Map<String, dynamic> json) {
  return TrackLink()
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$TrackLinkToJson(TrackLink instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': instance.type,
      'uri': instance.uri
    };

TracksLink _$TracksLinkFromJson(Map<String, dynamic> json) {
  return TracksLink()
    ..href = json['href'] as String
    ..total = json['total'] as int;
}

Map<String, dynamic> _$TracksLinkToJson(TracksLink instance) =>
    <String, dynamic>{'href': instance.href, 'total': instance.total};

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return Playlist()
    ..collaborative = json['collaborative'] as bool
    ..description = json['description'] as String
    ..followers = json['followers'] == null
        ? null
        : Followers.fromJson(json['followers'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..name = json['name'] as String
    ..owner = json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>)
    ..public = json['public'] as bool
    ..snapshotId = json['snapshot_id'] as String
    ..tracks = (json['tracks'] as List)
        ?.map(
            (e) => e == null ? null : Track.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'collaborative': instance.collaborative,
      'description': instance.description,
      'followers': instance.followers,
      'href': instance.href,
      'id': instance.id,
      'images': instance.images,
      'name': instance.name,
      'owner': instance.owner,
      'public': instance.public,
      'snapshot_id': instance.snapshotId,
      'tracks': instance.tracks,
      'type': instance.type,
      'uri': instance.uri
    };

PlaylistSimple _$PlaylistSimpleFromJson(Map<String, dynamic> json) {
  return PlaylistSimple()
    ..collaborative = json['collaborative'] as bool
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..name = json['name'] as String
    ..owner = json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>)
    ..public = json['public'] as bool
    ..snapshotId = json['snapshot_id'] as String
    ..tracksLink = json['tracks'] == null
        ? null
        : TracksLink.fromJson(json['tracks'] as Map<String, dynamic>)
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$PlaylistSimpleToJson(PlaylistSimple instance) =>
    <String, dynamic>{
      'collaborative': instance.collaborative,
      'href': instance.href,
      'id': instance.id,
      'images': instance.images,
      'name': instance.name,
      'owner': instance.owner,
      'public': instance.public,
      'snapshot_id': instance.snapshotId,
      'tracks': instance.tracksLink,
      'type': instance.type,
      'uri': instance.uri
    };

PlaylistsFeatured _$PlaylistsFeaturedFromJson(Map<String, dynamic> json) {
  return PlaylistsFeatured()..message = json['message'] as String;
}

Map<String, dynamic> _$PlaylistsFeaturedToJson(PlaylistsFeatured instance) =>
    <String, dynamic>{'message': instance.message};

PlaylistTrack _$PlaylistTrackFromJson(Map<String, dynamic> json) {
  return PlaylistTrack()
    ..addedAt = json['added_at'] == null
        ? null
        : DateTime.parse(json['added_at'] as String)
    ..addedBy = json['added_by'] == null
        ? null
        : UserPublic.fromJson(json['added_by'] as Map<String, dynamic>)
    ..isLocal = json['is_local'] as bool
    ..track = json['track'] == null
        ? null
        : Track.fromJson(json['track'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PlaylistTrackToJson(PlaylistTrack instance) =>
    <String, dynamic>{
      'added_at': instance.addedAt?.toIso8601String(),
      'added_by': instance.addedBy,
      'is_local': instance.isLocal,
      'track': instance.track
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..birthdate = json['birthdate'] as String
    ..country = json['country'] as String
    ..displayName = json['display_name'] as String
    ..email = json['email'] as String
    ..followers = json['followers'] == null
        ? null
        : Followers.fromJson(json['followers'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..product = json['product'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'birthdate': instance.birthdate,
      'country': instance.country,
      'display_name': instance.displayName,
      'email': instance.email,
      'followers': instance.followers,
      'href': instance.href,
      'id': instance.id,
      'images': instance.images,
      'product': instance.product,
      'type': instance.type,
      'uri': instance.uri
    };

UserPublic _$UserPublicFromJson(Map<String, dynamic> json) {
  return UserPublic()
    ..displayName = json['display_name'] as String
    ..followers = json['followers'] == null
        ? null
        : Followers.fromJson(json['followers'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$UserPublicToJson(UserPublic instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'followers': instance.followers,
      'href': instance.href,
      'id': instance.id,
      'images': instance.images,
      'type': instance.type,
      'uri': instance.uri
    };

AudioFeature _$AudioFeatureFromJson(Map<String, dynamic> json) {
  return AudioFeature()
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

Map<String, dynamic> _$AudioFeatureToJson(AudioFeature instance) =>
    <String, dynamic>{
      'acousticness': instance.acousticness,
      'analysis_url': instance.analysisUrl,
      'danceability': instance.danceability,
      'duration_ms': instance.durationMs,
      'energy': instance.energy,
      'id': instance.id,
      'instrumentalness': instance.instrumentalness,
      'key': instance.key,
      'liveness': instance.liveness,
      'loudness': instance.loudness,
      'mode': instance.mode,
      'speechiness': instance.speechiness,
      'tempo': instance.tempo,
      'time_signature': instance.timeSignature,
      'track_href': instance.trackHref,
      'type': instance.type,
      'uri': instance.uri,
      'valence': instance.valence
    };
