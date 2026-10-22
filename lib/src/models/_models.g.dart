// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExternalUrls _$ExternalUrlsFromJson(Map<String, dynamic> json) => ExternalUrls()..spotify = json['spotify'] as String?;

Map<String, dynamic> _$ExternalUrlsToJson(ExternalUrls instance) => <String, dynamic>{
      'spotify': instance.spotify,
    };

ExternalIds _$ExternalIdsFromJson(Map<String, dynamic> json) => ExternalIds()
  ..isrc = json['isrc'] as String?
  ..ean = json['ean'] as String?
  ..upc = json['upc'] as String?;

Map<String, dynamic> _$ExternalIdsToJson(ExternalIds instance) => <String, dynamic>{
      'isrc': instance.isrc,
      'ean': instance.ean,
      'upc': instance.upc,
    };

ResumePoint _$ResumePointFromJson(Map<String, dynamic> json) => ResumePoint()
  ..fullyPlayed = json['fully_played'] as bool?
  ..resumePositionMs = convertToIntIfDoubleValue(json['resume_position_ms']);

Map<String, dynamic> _$ResumePointToJson(ResumePoint instance) => <String, dynamic>{
      'fully_played': instance.fullyPlayed,
      'resume_position_ms': instance.resumePositionMs,
    };

Album _$AlbumFromJson(Map<String, dynamic> json) => Album()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..restrictions =
      json['restrictions'] == null ? null : Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>)
  ..albumType = AlbumSimple._convertForAlbumType(json['album_type'] as String?)
  ..artists = (json['artists'] as List<dynamic>?)?.map((e) => ArtistSimple.fromJson(e as Map<String, dynamic>)).toList()
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..name = json['name'] as String?
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(_$DatePrecisionEnumMap, json['release_date_precision'])
  ..totalTracks = (json['total_tracks'] as num?)?.toInt()
  ..tracks = AlbumSimple._extractTracksFromPage(json['tracks'])
  ..copyrights =
      (json['copyrights'] as List<dynamic>?)?.map((e) => Copyright.fromJson(e as Map<String, dynamic>)).toList()
  ..externalIds =
      json['external_ids'] == null ? null : ExternalIds.fromJson(json['external_ids'] as Map<String, dynamic>)
  ..genres = (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'restrictions': instance.restrictions?.toJson(),
      'album_type': _$AlbumTypeEnumMap[instance.albumType],
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'release_date': instance.releaseDate,
      'release_date_precision': _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'total_tracks': instance.totalTracks,
      'tracks': instance.tracks?.map((e) => e.toJson()).toList(),
      'copyrights': instance.copyrights?.map((e) => e.toJson()).toList(),
      'external_ids': instance.externalIds?.toJson(),
      'genres': instance.genres,
    };

const _$SpotifyContentTypeEnumMap = {
  SpotifyContentType.artist: 'artist',
  SpotifyContentType.album: 'album',
  SpotifyContentType.track: 'track',
  SpotifyContentType.playlist: 'playlist',
  SpotifyContentType.episode: 'episode',
  SpotifyContentType.show: 'show',
  SpotifyContentType.audiobook: 'audiobook',
  SpotifyContentType.user: 'user',
};

const _$DatePrecisionEnumMap = {
  DatePrecision.day: 'day',
  DatePrecision.month: 'month',
  DatePrecision.year: 'year',
};

const _$AlbumTypeEnumMap = {
  AlbumType.album: 'album',
  AlbumType.single: 'single',
  AlbumType.compilation: 'compilation',
};

AlbumSimple _$AlbumSimpleFromJson(Map<String, dynamic> json) => AlbumSimple()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..restrictions =
      json['restrictions'] == null ? null : Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>)
  ..albumType = AlbumSimple._convertForAlbumType(json['album_type'] as String?)
  ..artists = (json['artists'] as List<dynamic>?)?.map((e) => ArtistSimple.fromJson(e as Map<String, dynamic>)).toList()
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..name = json['name'] as String?
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(_$DatePrecisionEnumMap, json['release_date_precision'])
  ..totalTracks = (json['total_tracks'] as num?)?.toInt()
  ..tracks = AlbumSimple._extractTracksFromPage(json['tracks']);

Map<String, dynamic> _$AlbumSimpleToJson(AlbumSimple instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'restrictions': instance.restrictions?.toJson(),
      'album_type': _$AlbumTypeEnumMap[instance.albumType],
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'release_date': instance.releaseDate,
      'release_date_precision': _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'total_tracks': instance.totalTracks,
      'tracks': instance.tracks?.map((e) => e.toJson()).toList(),
    };

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..name = json['name'] as String?
  ..genres = (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList();

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'name': instance.name,
      'genres': instance.genres,
      'images': instance.images?.map((e) => e.toJson()).toList(),
    };

ArtistSimple _$ArtistSimpleFromJson(Map<String, dynamic> json) => ArtistSimple()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..name = json['name'] as String?;

Map<String, dynamic> _$ArtistSimpleToJson(ArtistSimple instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'name': instance.name,
    };

Audiobook _$AudiobookFromJson(Map<String, dynamic> json) => Audiobook()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..authors = (json['authors'] as List<dynamic>?)?.map((e) => Author.fromJson(e as Map<String, dynamic>)).toList()
  ..copyrights =
      (json['copyrights'] as List<dynamic>?)?.map((e) => Copyright.fromJson(e as Map<String, dynamic>)).toList()
  ..description = json['description'] as String?
  ..htmlDescription = json['html_description'] as String?
  ..edition = json['edition'] as String?
  ..explicit = json['explicit'] as bool?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..mediaType = json['media_type'] as String?
  ..name = json['name'] as String?
  ..narrators = (json['narrators'] as List<dynamic>?)?.map((e) => Narrator.fromJson(e as Map<String, dynamic>)).toList()
  ..totalChapters = convertToIntIfDoubleValue(json['total_chapters'])
  ..chapters = AudiobookSimple._extractChaptersFromPage(json['chapters']);

Map<String, dynamic> _$AudiobookToJson(Audiobook instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'authors': instance.authors?.map((e) => e.toJson()).toList(),
      'copyrights': instance.copyrights?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'html_description': instance.htmlDescription,
      'edition': instance.edition,
      'explicit': instance.explicit,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'languages': instance.languages,
      'media_type': instance.mediaType,
      'name': instance.name,
      'narrators': instance.narrators?.map((e) => e.toJson()).toList(),
      'total_chapters': instance.totalChapters,
      'chapters': instance.chapters?.map((e) => e.toJson()).toList(),
    };

AudiobookSimple _$AudiobookSimpleFromJson(Map<String, dynamic> json) => AudiobookSimple()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..authors = (json['authors'] as List<dynamic>?)?.map((e) => Author.fromJson(e as Map<String, dynamic>)).toList()
  ..copyrights =
      (json['copyrights'] as List<dynamic>?)?.map((e) => Copyright.fromJson(e as Map<String, dynamic>)).toList()
  ..description = json['description'] as String?
  ..htmlDescription = json['html_description'] as String?
  ..edition = json['edition'] as String?
  ..explicit = json['explicit'] as bool?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..mediaType = json['media_type'] as String?
  ..name = json['name'] as String?
  ..narrators = (json['narrators'] as List<dynamic>?)?.map((e) => Narrator.fromJson(e as Map<String, dynamic>)).toList()
  ..totalChapters = convertToIntIfDoubleValue(json['total_chapters']);

Map<String, dynamic> _$AudiobookSimpleToJson(AudiobookSimple instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'authors': instance.authors?.map((e) => e.toJson()).toList(),
      'copyrights': instance.copyrights?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'html_description': instance.htmlDescription,
      'edition': instance.edition,
      'explicit': instance.explicit,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'languages': instance.languages,
      'media_type': instance.mediaType,
      'name': instance.name,
      'narrators': instance.narrators?.map((e) => e.toJson()).toList(),
      'total_chapters': instance.totalChapters,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author()..name = json['name'] as String?;

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'name': instance.name,
    };

Narrator _$NarratorFromJson(Map<String, dynamic> json) => Narrator()..name = json['name'] as String?;

Map<String, dynamic> _$NarratorToJson(Narrator instance) => <String, dynamic>{
      'name': instance.name,
    };

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..name = json['name'] as String?
  ..restrictions =
      json['restrictions'] == null ? null : Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>)
  ..explicit = json['explicit'] as bool?
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..isPlayable = json['is_playable'] as bool?
  ..description = json['description'] as String?
  ..htmlDescription = json['html_description'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(_$DatePrecisionEnumMap, json['release_date_precision'])
  ..resumePoint =
      json['resume_point'] == null ? null : ResumePoint.fromJson(json['resume_point'] as Map<String, dynamic>)
  ..audioPreviewUrl = json['audio_preview_url'] as String?
  ..chapterNumber = convertToIntIfDoubleValue(json['chapter_number'])
  ..audiobook = json['audiobook'] == null ? null : AudiobookSimple.fromJson(json['audiobook'] as Map<String, dynamic>);

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'name': instance.name,
      'restrictions': instance.restrictions?.toJson(),
      'explicit': instance.explicit,
      'duration_ms': instance.durationMs,
      'is_playable': instance.isPlayable,
      'description': instance.description,
      'html_description': instance.htmlDescription,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'languages': instance.languages,
      'release_date': instance.releaseDate,
      'release_date_precision': _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'resume_point': instance.resumePoint?.toJson(),
      'audio_preview_url': instance.audioPreviewUrl,
      'chapter_number': instance.chapterNumber,
      'audiobook': instance.audiobook?.toJson(),
    };

ChapterSimple _$ChapterSimpleFromJson(Map<String, dynamic> json) => ChapterSimple()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..name = json['name'] as String?
  ..restrictions =
      json['restrictions'] == null ? null : Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>)
  ..explicit = json['explicit'] as bool?
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..isPlayable = json['is_playable'] as bool?
  ..description = json['description'] as String?
  ..htmlDescription = json['html_description'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(_$DatePrecisionEnumMap, json['release_date_precision'])
  ..resumePoint =
      json['resume_point'] == null ? null : ResumePoint.fromJson(json['resume_point'] as Map<String, dynamic>)
  ..audioPreviewUrl = json['audio_preview_url'] as String?
  ..chapterNumber = convertToIntIfDoubleValue(json['chapter_number']);

Map<String, dynamic> _$ChapterSimpleToJson(ChapterSimple instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'name': instance.name,
      'restrictions': instance.restrictions?.toJson(),
      'explicit': instance.explicit,
      'duration_ms': instance.durationMs,
      'is_playable': instance.isPlayable,
      'description': instance.description,
      'html_description': instance.htmlDescription,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'languages': instance.languages,
      'release_date': instance.releaseDate,
      'release_date_precision': _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'resume_point': instance.resumePoint?.toJson(),
      'audio_preview_url': instance.audioPreviewUrl,
      'chapter_number': instance.chapterNumber,
    };

Copyright _$CopyrightFromJson(Map<String, dynamic> json) => Copyright()
  ..text = json['text'] as String?
  ..type = $enumDecodeNullable(_$CopyrightTypeEnumMap, json['type']);

Map<String, dynamic> _$CopyrightToJson(Copyright instance) => <String, dynamic>{
      'text': instance.text,
      'type': _$CopyrightTypeEnumMap[instance.type],
    };

const _$CopyrightTypeEnumMap = {
  CopyrightType.C: 'C',
  CopyrightType.P: 'P',
};

Device _$DeviceFromJson(Map<String, dynamic> json) => Device()
  ..id = json['id'] as String?
  ..isActive = json['is_active'] as bool? ?? false
  ..isPrivateSession = json['is_private_session'] as bool? ?? false
  ..isRestricted = json['is_restricted'] as bool? ?? false
  ..name = json['name'] as String?
  ..type = $enumDecodeNullable(_$DeviceTypeEnumMap, json['type'], unknownValue: DeviceType.Unknown)
  ..volumePercent = convertToIntIfDoubleValue(json['volume_percent']);

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

SpotifyError _$SpotifyErrorFromJson(Map<String, dynamic> json) => SpotifyError()
  ..status = convertToIntIfDoubleValue(json['status'])
  ..message = json['message'] as String?;

Map<String, dynamic> _$SpotifyErrorToJson(SpotifyError instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

Followers _$FollowersFromJson(Map<String, dynamic> json) => Followers()
  ..href = json['href'] as String?
  ..total = convertToIntIfDoubleValue(json['total']);

Map<String, dynamic> _$FollowersToJson(Followers instance) => <String, dynamic>{
      'href': instance.href,
      'total': instance.total,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image()
  ..height = convertToIntIfDoubleValue(json['height'])
  ..width = convertToIntIfDoubleValue(json['width'])
  ..url = json['url'] as String?;

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'url': instance.url,
    };

Paging<T> _$PagingFromJson<T>(Map<String, dynamic> json) => Paging<T>()
  ..href = json['href'] as String?
  ..itemsNative = itemsNativeFromJson(json['items'] as List)
  ..limit = convertToIntIfDoubleValueWithoutNull(json['limit'])
  ..next = json['next'] as String?
  ..offset = convertToIntIfDoubleValue(json['offset'])
  ..previous = json['previous'] as String?
  ..total = convertToIntIfDoubleValueWithoutNull(json['total']);

Map<String, dynamic> _$PagingToJson<T>(Paging<T> instance) => <String, dynamic>{
      'href': instance.href,
      'items': itemsNativeToJson(instance.itemsNative),
      'limit': instance.limit,
      'next': instance.next,
      'offset': instance.offset,
      'previous': instance.previous,
      'total': instance.total,
    };

CursorPaging<T> _$CursorPagingFromJson<T>(Map<String, dynamic> json) => CursorPaging<T>()
  ..href = json['href'] as String?
  ..itemsNative = itemsNativeFromJson(json['items'] as List)
  ..limit = convertToIntIfDoubleValueWithoutNull(json['limit'])
  ..next = json['next'] as String?
  ..cursors = json['cursors'] == null ? null : Cursor.fromJson(json['cursors'] as Map<String, dynamic>);

Map<String, dynamic> _$CursorPagingToJson<T>(CursorPaging<T> instance) => <String, dynamic>{
      'href': instance.href,
      'items': itemsNativeToJson(instance.itemsNative),
      'limit': instance.limit,
      'next': instance.next,
      'cursors': instance.cursors?.toJson(),
    };

Cursor _$CursorFromJson(Map<String, dynamic> json) => Cursor()..after = json['after'] as String?;

Map<String, dynamic> _$CursorToJson(Cursor instance) => <String, dynamic>{
      'after': instance.after,
    };

PlaybackState _$PlaybackStateFromJson(Map<String, dynamic> json) => PlaybackState()
  ..timestamp = convertToIntIfDoubleValue(json['timestamp'])
  ..context = json['context'] == null ? null : PlayerContext.fromJson(json['context'] as Map<String, dynamic>)
  ..progressMs = convertToIntIfDoubleValue(json['progress_ms'])
  ..item = _playableContentFromJson(json['item'] as Map<String, dynamic>?)
  ..currentlyPlayingType = $enumDecodeNullable(_$CurrentlyPlayingTypeEnumMap, json['currently_playing_type'])
  ..actions = json['actions'] == null ? null : Actions.fromJson(json['actions'] as Map<String, dynamic>)
  ..isPlaying = json['is_playing'] as bool? ?? false
  ..isShuffling = json['shuffle_state'] as bool? ?? false
  ..repeatState = $enumDecodeNullable(_$RepeatStateEnumMap, json['repeat_state']) ?? RepeatState.off;

Map<String, dynamic> _$PlaybackStateToJson(PlaybackState instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'context': instance.context?.toJson(),
      'progress_ms': instance.progressMs,
      'item': instance.item?.toJson(),
      'currently_playing_type': _$CurrentlyPlayingTypeEnumMap[instance.currentlyPlayingType],
      'actions': instance.actions?.toJson(),
      'is_playing': instance.isPlaying,
      'shuffle_state': instance.isShuffling,
      'repeat_state': _$RepeatStateEnumMap[instance.repeatState],
    };

const _$CurrentlyPlayingTypeEnumMap = {
  CurrentlyPlayingType.track: 'track',
  CurrentlyPlayingType.episode: 'episode',
  CurrentlyPlayingType.ad: 'ad',
  CurrentlyPlayingType.unknown: 'unknown',
};

const _$RepeatStateEnumMap = {
  RepeatState.off: 'off',
  RepeatState.context: 'context',
  RepeatState.track: 'track',
};

PlayerContext _$PlayerContextFromJson(Map<String, dynamic> json) => PlayerContext()
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

Map<String, dynamic> _$PlayerContextToJson(PlayerContext instance) => <String, dynamic>{
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'type': instance.type,
      'uri': instance.uri,
    };

Actions _$ActionsFromJson(Map<String, dynamic> json) => Actions()
  ..interruptingPlayback = json['interrupting_playback'] as bool? ?? false
  ..pausing = json['pausing'] as bool? ?? false
  ..resuming = json['resuming'] as bool? ?? false
  ..seeking = json['seeking'] as bool? ?? false
  ..skippingNext = json['skipping_next'] as bool? ?? false
  ..skippingPrev = json['skipping_prev'] as bool? ?? false
  ..togglingRepeatContext = json['toggling_repeat_context'] as bool? ?? false
  ..togglingRepeatTrack = json['toggling_repeat_track'] as bool? ?? false
  ..togglingShuffle = json['toggling_shuffle'] as bool? ?? false
  ..transferringPlayback = json['transferring_playback'] as bool? ?? false;

Map<String, dynamic> _$ActionsToJson(Actions instance) => <String, dynamic>{
      'interrupting_playback': instance.interruptingPlayback,
      'pausing': instance.pausing,
      'resuming': instance.resuming,
      'seeking': instance.seeking,
      'skipping_next': instance.skippingNext,
      'skipping_prev': instance.skippingPrev,
      'toggling_repeat_context': instance.togglingRepeatContext,
      'toggling_repeat_track': instance.togglingRepeatTrack,
      'toggling_shuffle': instance.togglingShuffle,
      'transferring_playback': instance.transferringPlayback,
    };

Map<String, dynamic> _$StartWithContextOptionsToJson(StartWithContextOptions instance) => <String, dynamic>{
      'context_uri': instance.contextUri,
      'offset': StartWithContextOptions._offsetToJson(instance.offset),
    };

Map<String, dynamic> _$StartWithUrisOptionsToJson(StartWithUrisOptions instance) => <String, dynamic>{
      'uris': instance.uris,
      'position_ms': instance.positionMs,
    };

Map<String, dynamic> _$UriOffsetToJson(UriOffset instance) => <String, dynamic>{
      'uri': instance.uri,
    };

Map<String, dynamic> _$PositionOffsetToJson(PositionOffset instance) => <String, dynamic>{
      'position': instance.position,
    };

PlaylistSimple _$PlaylistSimpleFromJson(Map<String, dynamic> json) => PlaylistSimple()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..collaborative = json['collaborative'] as bool?
  ..description = json['description'] as String?
  ..followers = json['followers'] == null ? null : Followers.fromJson(json['followers'] as Map<String, dynamic>)
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..name = json['name'] as String?
  ..owner = json['owner'] == null ? null : User.fromJson(json['owner'] as Map<String, dynamic>)
  ..public = json['public'] as bool?
  ..snapshotId = json['snapshot_id'] as String?
  ..itemsLink = json['items'] == null ? null : TracksLink.fromJson(json['items'] as Map<String, dynamic>);

Map<String, dynamic> _$PlaylistSimpleToJson(PlaylistSimple instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'collaborative': instance.collaborative,
      'description': instance.description,
      'followers': instance.followers?.toJson(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'owner': instance.owner?.toJson(),
      'public': instance.public,
      'snapshot_id': instance.snapshotId,
      'items': instance.itemsLink?.toJson(),
    };

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..collaborative = json['collaborative'] as bool?
  ..description = json['description'] as String?
  ..followers = json['followers'] == null ? null : Followers.fromJson(json['followers'] as Map<String, dynamic>)
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..name = json['name'] as String?
  ..owner = json['owner'] == null ? null : User.fromJson(json['owner'] as Map<String, dynamic>)
  ..public = json['public'] as bool?
  ..snapshotId = json['snapshot_id'] as String?
  ..items = json['items'] == null ? null : Paging<PlaylistItem>.fromJson(json['items'] as Map<String, dynamic>);

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'collaborative': instance.collaborative,
      'description': instance.description,
      'followers': instance.followers?.toJson(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'owner': instance.owner?.toJson(),
      'public': instance.public,
      'snapshot_id': instance.snapshotId,
      'items': instance.items?.toJson(),
    };

PlaylistItem _$PlaylistItemFromJson(Map<String, dynamic> json) => PlaylistItem()
  ..addedAt = json['added_at'] == null ? null : DateTime.parse(json['added_at'] as String)
  ..addedBy = json['added_by'] == null ? null : UserPublic.fromJson(json['added_by'] as Map<String, dynamic>)
  ..isLocal = json['is_local'] as bool?
  ..item = _playableContentFromJson(json['item'] as Map<String, dynamic>?);

Restrictions _$RestrictionsFromJson(Map<String, dynamic> json) => Restrictions()..reason = json['reason'] as String?;

Map<String, dynamic> _$RestrictionsToJson(Restrictions instance) => <String, dynamic>{
      'reason': instance.reason,
    };

Show _$ShowFromJson(Map<String, dynamic> json) => Show()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..copyrights =
      (json['copyrights'] as List<dynamic>?)?.map((e) => Copyright.fromJson(e as Map<String, dynamic>)).toList()
  ..description = json['description'] as String?
  ..explicit = json['explicit'] as bool?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..isExternallyHosted = json['is_externally_hosted'] as bool?
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..mediaType = json['media_type'] as String?
  ..name = json['name'] as String?
  ..totalEpisodes = json['total_episodes'] == null ? 0 : convertToIntIfDoubleValue(json['total_episodes']);

Map<String, dynamic> _$ShowToJson(Show instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'copyrights': instance.copyrights?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'explicit': instance.explicit,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'is_externally_hosted': instance.isExternallyHosted,
      'languages': instance.languages,
      'media_type': instance.mediaType,
      'name': instance.name,
      'total_episodes': instance.totalEpisodes,
    };

EpisodeSimple _$EpisodeSimpleFromJson(Map<String, dynamic> json) => EpisodeSimple()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..name = json['name'] as String?
  ..restrictions =
      json['restrictions'] == null ? null : Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>)
  ..explicit = json['explicit'] as bool?
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..isPlayable = json['is_playable'] as bool?
  ..description = json['description'] as String?
  ..htmlDescription = json['html_description'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(_$DatePrecisionEnumMap, json['release_date_precision'])
  ..resumePoint =
      json['resume_point'] == null ? null : ResumePoint.fromJson(json['resume_point'] as Map<String, dynamic>)
  ..isExternallyHosted = json['is_externally_hosted'] as bool?
  ..language = json['language'] as String?;

Map<String, dynamic> _$EpisodeSimpleToJson(EpisodeSimple instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'name': instance.name,
      'restrictions': instance.restrictions?.toJson(),
      'explicit': instance.explicit,
      'duration_ms': instance.durationMs,
      'is_playable': instance.isPlayable,
      'description': instance.description,
      'html_description': instance.htmlDescription,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'languages': instance.languages,
      'release_date': instance.releaseDate,
      'release_date_precision': _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'resume_point': instance.resumePoint?.toJson(),
      'is_externally_hosted': instance.isExternallyHosted,
      'language': instance.language,
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..name = json['name'] as String?
  ..restrictions =
      json['restrictions'] == null ? null : Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>)
  ..explicit = json['explicit'] as bool?
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..isPlayable = json['is_playable'] as bool?
  ..description = json['description'] as String?
  ..htmlDescription = json['html_description'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(_$DatePrecisionEnumMap, json['release_date_precision'])
  ..resumePoint =
      json['resume_point'] == null ? null : ResumePoint.fromJson(json['resume_point'] as Map<String, dynamic>)
  ..isExternallyHosted = json['is_externally_hosted'] as bool?
  ..language = json['language'] as String?
  ..show = json['show'] == null ? null : Show.fromJson(json['show'] as Map<String, dynamic>);

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'name': instance.name,
      'restrictions': instance.restrictions?.toJson(),
      'explicit': instance.explicit,
      'duration_ms': instance.durationMs,
      'is_playable': instance.isPlayable,
      'description': instance.description,
      'html_description': instance.htmlDescription,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'languages': instance.languages,
      'release_date': instance.releaseDate,
      'release_date_precision': _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'resume_point': instance.resumePoint?.toJson(),
      'is_externally_hosted': instance.isExternallyHosted,
      'language': instance.language,
      'show': instance.show?.toJson(),
    };

Track _$TrackFromJson(Map<String, dynamic> json) => Track()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..name = json['name'] as String?
  ..restrictions =
      json['restrictions'] == null ? null : Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>)
  ..explicit = json['explicit'] as bool?
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..isPlayable = json['is_playable'] as bool?
  ..artists = (json['artists'] as List<dynamic>?)?.map((e) => Artist.fromJson(e as Map<String, dynamic>)).toList()
  ..discNumber = convertToIntIfDoubleValue(json['disc_number'])
  ..trackNumber = convertToIntIfDoubleValue(json['track_number'])
  ..album = json['album'] == null ? null : AlbumSimple.fromJson(json['album'] as Map<String, dynamic>)
  ..externalIds =
      json['external_ids'] == null ? null : ExternalIds.fromJson(json['external_ids'] as Map<String, dynamic>)
  ..previewUrl = json['preview_url'] as String?;

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'name': instance.name,
      'restrictions': instance.restrictions?.toJson(),
      'explicit': instance.explicit,
      'duration_ms': instance.durationMs,
      'is_playable': instance.isPlayable,
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'disc_number': instance.discNumber,
      'track_number': instance.trackNumber,
      'album': instance.album?.toJson(),
      'external_ids': instance.externalIds?.toJson(),
      'preview_url': instance.previewUrl,
    };

TrackSimple _$TrackSimpleFromJson(Map<String, dynamic> json) => TrackSimple()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..name = json['name'] as String?
  ..restrictions =
      json['restrictions'] == null ? null : Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>)
  ..explicit = json['explicit'] as bool?
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..isPlayable = json['is_playable'] as bool?
  ..artists = (json['artists'] as List<dynamic>?)?.map((e) => Artist.fromJson(e as Map<String, dynamic>)).toList()
  ..discNumber = convertToIntIfDoubleValue(json['disc_number'])
  ..previewUrl = json['preview_url'] as String?
  ..trackNumber = convertToIntIfDoubleValue(json['track_number']);

Map<String, dynamic> _$TrackSimpleToJson(TrackSimple instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'name': instance.name,
      'restrictions': instance.restrictions?.toJson(),
      'explicit': instance.explicit,
      'duration_ms': instance.durationMs,
      'is_playable': instance.isPlayable,
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'disc_number': instance.discNumber,
      'preview_url': instance.previewUrl,
      'track_number': instance.trackNumber,
    };

TrackSaved _$TrackSavedFromJson(Map<String, dynamic> json) => TrackSaved()
  ..addedAt = json['added_at'] == null ? null : DateTime.parse(json['added_at'] as String)
  ..track = json['track'] == null ? null : Track.fromJson(json['track'] as Map<String, dynamic>);

Map<String, dynamic> _$TrackSavedToJson(TrackSaved instance) => <String, dynamic>{
      'added_at': instance.addedAt?.toIso8601String(),
      'track': instance.track?.toJson(),
    };

TracksLink _$TracksLinkFromJson(Map<String, dynamic> json) => TracksLink()
  ..href = json['href'] as String?
  ..total = convertToIntIfDoubleValue(json['total']);

Map<String, dynamic> _$TracksLinkToJson(TracksLink instance) => <String, dynamic>{
      'href': instance.href,
      'total': instance.total,
    };

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..displayName = json['display_name'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..accountId = json['account_id'] as String?
  ..birthdate = json['birthdate'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'display_name': instance.displayName,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'account_id': instance.accountId,
      'birthdate': instance.birthdate,
    };

UserPublic _$UserPublicFromJson(Map<String, dynamic> json) => UserPublic()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = SpotifyUri.tryParse(json['uri'])
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..displayName = json['display_name'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList();

Map<String, dynamic> _$UserPublicToJson(UserPublic instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'external_urls': instance.externalUrls?.toJson(),
      'display_name': instance.displayName,
      'images': instance.images?.map((e) => e.toJson()).toList(),
    };

PlayHistory _$PlayHistoryFromJson(Map<String, dynamic> json) => PlayHistory()
  ..track = json['track'] == null ? null : Track.fromJson(json['track'] as Map<String, dynamic>)
  ..playedAt = json['played_at'] == null ? null : DateTime.parse(json['played_at'] as String)
  ..context = json['context'] == null ? null : PlayerContext.fromJson(json['context'] as Map<String, dynamic>);

Map<String, dynamic> _$PlayHistoryToJson(PlayHistory instance) => <String, dynamic>{
      'track': instance.track?.toJson(),
      'played_at': instance.playedAt?.toIso8601String(),
      'context': instance.context?.toJson(),
    };

Queue _$QueueFromJson(Map<String, dynamic> json) => Queue()
  ..currentlyPlaying = _playableContentFromJson(json['currently_playing'] as Map<String, dynamic>?)
  ..queue = Queue._queueFromJson(json['queue'] as List?);

Map<String, dynamic> _$QueueToJson(Queue instance) => <String, dynamic>{
      'currently_playing': instance.currentlyPlaying?.toJson(),
      'queue': instance.queue?.map((e) => e.toJson()).toList(),
    };
