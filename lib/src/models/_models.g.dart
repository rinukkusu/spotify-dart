// GENERATED CODE - DO NOT MODIFY BY HAND

part of spotify.models;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExternalUrls _$ExternalUrlsFromJson(Map<String, dynamic> json) {
  return ExternalUrls()..spotify = json['spotify'] as String;
}

Map<String, dynamic> _$ExternalUrlsToJson(ExternalUrls instance) =>
    <String, dynamic>{
      'spotify': instance.spotify,
    };

ExternalIds _$ExternalIdsFromJson(Map<String, dynamic> json) {
  return ExternalIds()
    ..isrc = json['isrc'] as String
    ..ean = json['ean'] as String
    ..upc = json['upc'] as String;
}

Map<String, dynamic> _$ExternalIdsToJson(ExternalIds instance) =>
    <String, dynamic>{
      'isrc': instance.isrc,
      'ean': instance.ean,
      'upc': instance.upc,
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
    ..externalUrls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..name = json['name'] as String
    ..releaseDate = json['release_date'] as String
    ..releaseDatePrecision = _$enumDecodeNullable(
        _$DatePrecisionEnumMap, json['release_date_precision'])
    ..type = json['type'] as String
    ..uri = json['uri'] as String
    ..tracks = AlbumSimple._extractTracksFromPage(
        json['tracks'] as Map<String, dynamic>)
    ..copyrights = (json['copyrights'] as List)
        ?.map((e) =>
            e == null ? null : Copyright.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..externalIds = json['external_ids'] == null
        ? null
        : ExternalIds.fromJson(json['external_ids'] as Map<String, dynamic>)
    ..genres = (json['genres'] as List)?.map((e) => e as String)?.toList()
    ..label = json['label'] as String
    ..popularity = json['popularity'] as int;
}

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'album_type': instance.albumType,
      'artists': instance.artists?.map((e) => e?.toJson())?.toList(),
      'available_markets': instance.availableMarkets,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'name': instance.name,
      'release_date': instance.releaseDate,
      'release_date_precision':
          _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'type': instance.type,
      'uri': instance.uri,
      'tracks': instance.tracks?.map((e) => e?.toJson())?.toList(),
      'copyrights': instance.copyrights?.map((e) => e?.toJson())?.toList(),
      'external_ids': instance.externalIds?.toJson(),
      'genres': instance.genres,
      'label': instance.label,
      'popularity': instance.popularity,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DatePrecisionEnumMap = {
  DatePrecision.day: 'day',
  DatePrecision.month: 'month',
  DatePrecision.year: 'year',
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
    ..externalUrls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..name = json['name'] as String
    ..releaseDate = json['release_date'] as String
    ..releaseDatePrecision = _$enumDecodeNullable(
        _$DatePrecisionEnumMap, json['release_date_precision'])
    ..type = json['type'] as String
    ..uri = json['uri'] as String
    ..tracks = AlbumSimple._extractTracksFromPage(
        json['tracks'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AlbumSimpleToJson(AlbumSimple instance) =>
    <String, dynamic>{
      'album_type': instance.albumType,
      'artists': instance.artists?.map((e) => e?.toJson())?.toList(),
      'available_markets': instance.availableMarkets,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'name': instance.name,
      'release_date': instance.releaseDate,
      'release_date_precision':
          _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'type': instance.type,
      'uri': instance.uri,
      'tracks': instance.tracks?.map((e) => e?.toJson())?.toList(),
    };

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return Artist()
    ..externalUrls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
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
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'uri': instance.uri,
      'followers': instance.followers?.toJson(),
      'genres': instance.genres,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'popularity': instance.popularity,
    };

ArtistSimple _$ArtistSimpleFromJson(Map<String, dynamic> json) {
  return ArtistSimple()
    ..externalUrls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$ArtistSimpleToJson(ArtistSimple instance) =>
    <String, dynamic>{
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'uri': instance.uri,
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
      'valence': instance.valence,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category()
    ..href = json['href'] as String
    ..icons = (json['icons'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..id = json['id'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'href': instance.href,
      'icons': instance.icons?.map((e) => e?.toJson())?.toList(),
      'id': instance.id,
      'name': instance.name,
    };

Copyright _$CopyrightFromJson(Map<String, dynamic> json) {
  return Copyright()
    ..text = json['text'] as String
    ..type = json['type'] as String;
}

Map<String, dynamic> _$CopyrightToJson(Copyright instance) => <String, dynamic>{
      'text': instance.text,
      'type': instance.type,
    };

CursorPaging<T> _$CursorPagingFromJson<T>(Map<String, dynamic> json) {
  return CursorPaging<T>()
    ..href = json['href'] as String
    ..itemsNative = itemsNativeFromJson(json['items'] as List)
    ..limit = json['limit'] as int
    ..next = json['next'] as String
    ..offset = json['offset'] as int
    ..previous = json['previous'] as String
    ..total = json['total'] as int
    ..cursors = json['cursors'] == null
        ? null
        : Cursor.fromJson(json['cursors'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CursorPagingToJson<T>(CursorPaging<T> instance) =>
    <String, dynamic>{
      'href': instance.href,
      'items': itemsNativeToJson(instance.itemsNative),
      'limit': instance.limit,
      'next': instance.next,
      'offset': instance.offset,
      'previous': instance.previous,
      'total': instance.total,
      'cursors': instance.cursors?.toJson(),
    };

Cursor _$CursorFromJson(Map<String, dynamic> json) {
  return Cursor()..after = json['after'] as String;
}

Map<String, dynamic> _$CursorToJson(Cursor instance) => <String, dynamic>{
      'after': instance.after,
    };

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device()
    ..id = json['id'] as String
    ..isActive = json['is_active'] as bool ?? false
    ..isPrivateSession = json['is_private_session'] as bool ?? false
    ..isRestricted = json['is_restricted'] as bool ?? false
    ..name = json['name'] as String
    ..type = _$enumDecodeNullable(_$DeviceTypeEnumMap, json['type'])
    ..volumePercent = json['volume_percent'] as int;
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'is_active': instance.isActive,
      'is_private_session': instance.isPrivateSession,
      'is_restricted': instance.isRestricted,
      'name': instance.name,
      'type': _$DeviceTypeEnumMap[instance.type],
      'volume_percent': instance.volumePercent,
    };

const _$DeviceTypeEnumMap = {
  DeviceType.Computer: 'Computer',
  DeviceType.Tablet: 'Tablet',
  DeviceType.Smartphone: 'Smartphone',
  DeviceType.Speaker: 'Speaker',
  DeviceType.TV: 'TV',
  DeviceType.AVR: 'AVR',
  DeviceType.STB: 'STB',
  DeviceType.AudioDongle: 'AudioDongle',
  DeviceType.GameConsole: 'GameConsole',
  DeviceType.CastVideo: 'CastVideo',
  DeviceType.CastAudio: 'CastAudio',
  DeviceType.Automobile: 'Automobile',
  DeviceType.Unknown: 'Unknown',
};

SpotifyError _$SpotifyErrorFromJson(Map<String, dynamic> json) {
  return SpotifyError()
    ..status = json['status'] as int
    ..message = json['message'] as String;
}

Map<String, dynamic> _$SpotifyErrorToJson(SpotifyError instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

Followers _$FollowersFromJson(Map<String, dynamic> json) {
  return Followers()
    ..href = json['href'] as String
    ..total = json['total'] as int;
}

Map<String, dynamic> _$FollowersToJson(Followers instance) => <String, dynamic>{
      'href': instance.href,
      'total': instance.total,
    };

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image()
    ..height = json['height'] as int
    ..width = json['width'] as int
    ..url = json['url'] as String;
}

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'url': instance.url,
    };

Paging<T> _$PagingFromJson<T>(Map<String, dynamic> json) {
  return Paging<T>()
    ..href = json['href'] as String
    ..itemsNative = itemsNativeFromJson(json['items'] as List)
    ..limit = json['limit'] as int
    ..next = json['next'] as String
    ..offset = json['offset'] as int
    ..previous = json['previous'] as String
    ..total = json['total'] as int;
}

Map<String, dynamic> _$PagingToJson<T>(Paging<T> instance) => <String, dynamic>{
      'href': instance.href,
      'items': itemsNativeToJson(instance.itemsNative),
      'limit': instance.limit,
      'next': instance.next,
      'offset': instance.offset,
      'previous': instance.previous,
      'total': instance.total,
    };

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player()
    ..timestamp = json['timestamp'] as int
    ..context = json['context'] == null
        ? null
        : PlayerContext.fromJson(json['context'] as Map<String, dynamic>)
    ..progress_ms = json['progress_ms'] as int
    ..item = json['item'] == null
        ? null
        : Track.fromJson(json['item'] as Map<String, dynamic>)
    ..currently_playing_type = json['currently_playing_type'] as String
    ..is_playing = json['is_playing'] as bool;
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'context': instance.context?.toJson(),
      'progress_ms': instance.progress_ms,
      'item': instance.item?.toJson(),
      'currently_playing_type': instance.currently_playing_type,
      'is_playing': instance.is_playing,
    };

PlayerContext _$PlayerContextFromJson(Map<String, dynamic> json) {
  return PlayerContext()
    ..external_urls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$PlayerContextToJson(PlayerContext instance) =>
    <String, dynamic>{
      'external_urls': instance.external_urls?.toJson(),
      'href': instance.href,
      'type': instance.type,
      'uri': instance.uri,
    };

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return Playlist()
    ..collaborative = json['collaborative'] as bool
    ..description = json['description'] as String
    ..externalUrls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
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
    ..tracks = json['tracks'] == null
        ? null
        : Paging.fromJson(json['tracks'] as Map<String, dynamic>)
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'collaborative': instance.collaborative,
      'description': instance.description,
      'external_urls': instance.externalUrls?.toJson(),
      'followers': instance.followers?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'name': instance.name,
      'owner': instance.owner?.toJson(),
      'public': instance.public,
      'snapshot_id': instance.snapshotId,
      'tracks': instance.tracks?.toJson(),
      'type': instance.type,
      'uri': instance.uri,
    };

PlaylistSimple _$PlaylistSimpleFromJson(Map<String, dynamic> json) {
  return PlaylistSimple()
    ..collaborative = json['collaborative'] as bool
    ..externalUrls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
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
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'name': instance.name,
      'owner': instance.owner?.toJson(),
      'public': instance.public,
      'snapshot_id': instance.snapshotId,
      'tracks': instance.tracksLink?.toJson(),
      'type': instance.type,
      'uri': instance.uri,
    };

PlaylistsFeatured _$PlaylistsFeaturedFromJson(Map<String, dynamic> json) {
  return PlaylistsFeatured()..message = json['message'] as String;
}

Map<String, dynamic> _$PlaylistsFeaturedToJson(PlaylistsFeatured instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

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
      'added_by': instance.addedBy?.toJson(),
      'is_local': instance.isLocal,
      'track': instance.track?.toJson(),
    };

Recommendations _$RecommendationsFromJson(Map<String, dynamic> json) {
  return Recommendations()
    ..seeds = (json['seeds'] as List)
        ?.map((e) => e == null
            ? null
            : RecommendationsSeed.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..tracks = (json['tracks'] as List)
        ?.map((e) =>
            e == null ? null : TrackSimple.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$RecommendationsToJson(Recommendations instance) =>
    <String, dynamic>{
      'seeds': instance.seeds?.map((e) => e?.toJson())?.toList(),
      'tracks': instance.tracks?.map((e) => e?.toJson())?.toList(),
    };

RecommendationsSeed _$RecommendationsSeedFromJson(Map<String, dynamic> json) {
  return RecommendationsSeed()
    ..afterFilteringSize = json['afterFilteringSize'] as int
    ..afterRelinkingSize = json['afterRelinkingSize'] as int
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..initialPoolSize = json['initialPoolSize'] as int
    ..type = json['type'] as String;
}

Map<String, dynamic> _$RecommendationsSeedToJson(
        RecommendationsSeed instance) =>
    <String, dynamic>{
      'afterFilteringSize': instance.afterFilteringSize,
      'afterRelinkingSize': instance.afterRelinkingSize,
      'href': instance.href,
      'id': instance.id,
      'initialPoolSize': instance.initialPoolSize,
      'type': instance.type,
    };

Show _$ShowFromJson(Map<String, dynamic> json) {
  return Show()
    ..availableMarkets =
        (json['available_markets'] as List)?.map((e) => e as String)?.toList()
    ..copyrights = (json['copyrights'] as List)
        ?.map((e) =>
            e == null ? null : Copyright.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..description = json['description'] as String
    ..explicit = json['explicit'] as bool
    ..externalUrls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..isExternallyHosted = json['is_externally_hosted'] as bool
    ..languages = (json['languages'] as List)?.map((e) => e as String)?.toList()
    ..mediaType = json['media_type'] as String
    ..name = json['name'] as String
    ..publisher = json['publisher'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$ShowToJson(Show instance) => <String, dynamic>{
      'available_markets': instance.availableMarkets,
      'copyrights': instance.copyrights?.map((e) => e?.toJson())?.toList(),
      'description': instance.description,
      'explicit': instance.explicit,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'is_externally_hosted': instance.isExternallyHosted,
      'languages': instance.languages,
      'media_type': instance.mediaType,
      'name': instance.name,
      'publisher': instance.publisher,
      'type': instance.type,
      'uri': instance.uri,
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return Episode()
    ..audioPreviewUrl = json['audio_preview_url'] as String
    ..description = json['description'] as String
    ..durationMs = json['duration_ms'] as int
    ..explicit = json['explicit'] as bool
    ..externalUrls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..images = (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..isExternallyHosted = json['is_externally_hosted'] as bool
    ..isPlayable = json['is_playable'] as bool
    ..language = json['language'] as String
    ..languages = (json['languages'] as List)?.map((e) => e as String)?.toList()
    ..name = json['name'] as String
    ..releaseDate = json['release_date'] == null
        ? null
        : DateTime.parse(json['release_date'] as String)
    ..releaseDatePrecision = json['release_date_precision'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'audio_preview_url': instance.audioPreviewUrl,
      'description': instance.description,
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'is_externally_hosted': instance.isExternallyHosted,
      'is_playable': instance.isPlayable,
      'language': instance.language,
      'languages': instance.languages,
      'name': instance.name,
      'release_date': instance.releaseDate?.toIso8601String(),
      'release_date_precision': instance.releaseDatePrecision,
      'type': instance.type,
      'uri': instance.uri,
    };

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
    ..externalIds = json['external_ids'] == null
        ? null
        : ExternalIds.fromJson(json['external_ids'] as Map<String, dynamic>)
    ..externalUrls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
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
      'album': instance.album?.toJson(),
      'artists': instance.artists?.map((e) => e?.toJson())?.toList(),
      'available_markets': instance.availableMarkets,
      'disc_number': instance.discNumber,
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
      'external_ids': instance.externalIds?.toJson(),
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'is_playable': instance.isPlayable,
      'linked_from': instance.linkedFrom?.toJson(),
      'name': instance.name,
      'popularity': instance.popularity,
      'preview_url': instance.previewUrl,
      'track_number': instance.trackNumber,
      'type': instance.type,
      'uri': instance.uri,
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
    ..externalUrls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
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
      'artists': instance.artists?.map((e) => e?.toJson())?.toList(),
      'available_markets': instance.availableMarkets,
      'disc_number': instance.discNumber,
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'is_playable': instance.isPlayable,
      'linked_from': instance.linkedFrom?.toJson(),
      'name': instance.name,
      'preview_url': instance.previewUrl,
      'track_number': instance.trackNumber,
      'type': instance.type,
      'uri': instance.uri,
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
      'track': instance.track?.toJson(),
    };

TrackLink _$TrackLinkFromJson(Map<String, dynamic> json) {
  return TrackLink()
    ..externalUrls = (json['external_urls'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    )
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

Map<String, dynamic> _$TrackLinkToJson(TrackLink instance) => <String, dynamic>{
      'external_urls': instance.externalUrls,
      'href': instance.href,
      'id': instance.id,
      'type': instance.type,
      'uri': instance.uri,
    };

TracksLink _$TracksLinkFromJson(Map<String, dynamic> json) {
  return TracksLink()
    ..href = json['href'] as String
    ..total = json['total'] as int;
}

Map<String, dynamic> _$TracksLinkToJson(TracksLink instance) =>
    <String, dynamic>{
      'href': instance.href,
      'total': instance.total,
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
      'followers': instance.followers?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'product': instance.product,
      'type': instance.type,
      'uri': instance.uri,
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
      'followers': instance.followers?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'type': instance.type,
      'uri': instance.uri,
    };

PlayHistory _$PlayHistoryFromJson(Map<String, dynamic> json) {
  return PlayHistory()
    ..track = json['track'] == null
        ? null
        : TrackSimple.fromJson(json['track'] as Map<String, dynamic>)
    ..playedAt = json['played_at'] == null
        ? null
        : DateTime.parse(json['played_at'] as String)
    ..context = json['context'] == null
        ? null
        : PlayerContext.fromJson(json['context'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PlayHistoryToJson(PlayHistory instance) =>
    <String, dynamic>{
      'track': instance.track?.toJson(),
      'played_at': instance.playedAt?.toIso8601String(),
      'context': instance.context?.toJson(),
    };
