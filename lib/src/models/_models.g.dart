// GENERATED CODE - DO NOT MODIFY BY HAND

part of spotify.models;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExternalUrls _$ExternalUrlsFromJson(Map<String, dynamic> json) {
  return ExternalUrls()..spotify = json['spotify'] as String;
}

ExternalIds _$ExternalIdsFromJson(Map<String, dynamic> json) {
  return ExternalIds()
    ..isrc = json['isrc'] as String
    ..ean = json['ean'] as String
    ..upc = json['upc'] as String;
}

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

Copyright _$CopyrightFromJson(Map<String, dynamic> json) {
  return Copyright()
    ..text = json['text'] as String
    ..type = json['type'] as String;
}

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

Cursor _$CursorFromJson(Map<String, dynamic> json) {
  return Cursor()..after = json['after'] as String;
}

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

Followers _$FollowersFromJson(Map<String, dynamic> json) {
  return Followers()
    ..href = json['href'] as String
    ..total = json['total'] as int;
}

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image()
    ..height = json['height'] as int
    ..width = json['width'] as int
    ..url = json['url'] as String;
}

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

PlayerContext _$PlayerContextFromJson(Map<String, dynamic> json) {
  return PlayerContext()
    ..external_urls = json['external_urls'] == null
        ? null
        : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
    ..href = json['href'] as String
    ..type = json['type'] as String
    ..uri = json['uri'] as String;
}

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

PlaylistsFeatured _$PlaylistsFeaturedFromJson(Map<String, dynamic> json) {
  return PlaylistsFeatured()..message = json['message'] as String;
}

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

RecommendationsSeed _$RecommendationsSeedFromJson(Map<String, dynamic> json) {
  return RecommendationsSeed()
    ..afterFilteringSize = json['afterFilteringSize'] as int
    ..afterRelinkingSize = json['afterRelinkingSize'] as int
    ..href = json['href'] as String
    ..id = json['id'] as String
    ..initialPoolSize = json['initialPoolSize'] as int
    ..type = json['type'] as String;
}

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

TrackSaved _$TrackSavedFromJson(Map<String, dynamic> json) {
  return TrackSaved()
    ..addedAt = json['added_at'] == null
        ? null
        : DateTime.parse(json['added_at'] as String)
    ..track = json['track'] == null
        ? null
        : Track.fromJson(json['track'] as Map<String, dynamic>);
}

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

TracksLink _$TracksLinkFromJson(Map<String, dynamic> json) {
  return TracksLink()
    ..href = json['href'] as String
    ..total = json['total'] as int;
}

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
