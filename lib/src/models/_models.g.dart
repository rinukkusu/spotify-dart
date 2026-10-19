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

Album _$AlbumFromJson(Map<String, dynamic> json) => Album()
  ..albumType = AlbumSimple._convertForAlbumType(json['album_type'] as String?)
  ..artists = (json['artists'] as List<dynamic>?)?.map((e) => ArtistSimple.fromJson(e as Map<String, dynamic>)).toList()
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..name = json['name'] as String?
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(_$DatePrecisionEnumMap, json['release_date_precision'])
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?
  ..tracks = AlbumSimple._extractTracksFromPage(json['tracks'])
  ..copyrights =
      (json['copyrights'] as List<dynamic>?)?.map((e) => Copyright.fromJson(e as Map<String, dynamic>)).toList()
  ..externalIds =
      json['external_ids'] == null ? null : ExternalIds.fromJson(json['external_ids'] as Map<String, dynamic>)
  ..genres = (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'album_type': _$AlbumTypeEnumMap[instance.albumType],
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'release_date': instance.releaseDate,
      'release_date_precision': _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'type': instance.type,
      'uri': instance.uri,
      'tracks': instance.tracks?.map((e) => e.toJson()).toList(),
      'copyrights': instance.copyrights?.map((e) => e.toJson()).toList(),
      'external_ids': instance.externalIds?.toJson(),
      'genres': instance.genres,
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
  ..albumType = AlbumSimple._convertForAlbumType(json['album_type'] as String?)
  ..artists = (json['artists'] as List<dynamic>?)?.map((e) => ArtistSimple.fromJson(e as Map<String, dynamic>)).toList()
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..name = json['name'] as String?
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(_$DatePrecisionEnumMap, json['release_date_precision'])
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?
  ..tracks = AlbumSimple._extractTracksFromPage(json['tracks']);

Map<String, dynamic> _$AlbumSimpleToJson(AlbumSimple instance) => <String, dynamic>{
      'album_type': _$AlbumTypeEnumMap[instance.albumType],
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'release_date': instance.releaseDate,
      'release_date_precision': _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'type': instance.type,
      'uri': instance.uri,
      'tracks': instance.tracks?.map((e) => e.toJson()).toList(),
    };

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist()
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?
  ..genres = (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList();

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'uri': instance.uri,
      'genres': instance.genres,
      'images': instance.images?.map((e) => e.toJson()).toList(),
    };

ArtistSimple _$ArtistSimpleFromJson(Map<String, dynamic> json) => ArtistSimple()
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

Map<String, dynamic> _$ArtistSimpleToJson(ArtistSimple instance) => <String, dynamic>{
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'uri': instance.uri,
    };

Audiobook _$AudiobookFromJson(Map<String, dynamic> json) => Audiobook()
  ..authors = (json['authors'] as List<dynamic>?)?.map((e) => Author.fromJson(e as Map<String, dynamic>)).toList()
  ..copyrights =
      (json['copyrights'] as List<dynamic>?)?.map((e) => Copyright.fromJson(e as Map<String, dynamic>)).toList()
  ..description = json['description'] as String?
  ..htmlDescription = json['html_description'] as String?
  ..edition = json['edition'] as String?
  ..explicit = json['explicit'] as bool?
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..mediaType = json['media_type'] as String?
  ..name = json['name'] as String?
  ..narrators = (json['narrators'] as List<dynamic>?)?.map((e) => Narrator.fromJson(e as Map<String, dynamic>)).toList()
  ..totalChapters = convertToIntIfDoubleValue(json['total_chapters'])
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?
  ..chapters = AudiobookSimple._extractChaptersFromPage(json['chapters']);

Map<String, dynamic> _$AudiobookToJson(Audiobook instance) => <String, dynamic>{
      'authors': instance.authors?.map((e) => e.toJson()).toList(),
      'copyrights': instance.copyrights?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'html_description': instance.htmlDescription,
      'edition': instance.edition,
      'explicit': instance.explicit,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'languages': instance.languages,
      'media_type': instance.mediaType,
      'name': instance.name,
      'narrators': instance.narrators?.map((e) => e.toJson()).toList(),
      'total_chapters': instance.totalChapters,
      'type': instance.type,
      'uri': instance.uri,
      'chapters': instance.chapters?.map((e) => e.toJson()).toList(),
    };

AudiobookSimple _$AudiobookSimpleFromJson(Map<String, dynamic> json) => AudiobookSimple()
  ..authors = (json['authors'] as List<dynamic>?)?.map((e) => Author.fromJson(e as Map<String, dynamic>)).toList()
  ..copyrights =
      (json['copyrights'] as List<dynamic>?)?.map((e) => Copyright.fromJson(e as Map<String, dynamic>)).toList()
  ..description = json['description'] as String?
  ..htmlDescription = json['html_description'] as String?
  ..edition = json['edition'] as String?
  ..explicit = json['explicit'] as bool?
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..mediaType = json['media_type'] as String?
  ..name = json['name'] as String?
  ..narrators = (json['narrators'] as List<dynamic>?)?.map((e) => Narrator.fromJson(e as Map<String, dynamic>)).toList()
  ..totalChapters = convertToIntIfDoubleValue(json['total_chapters'])
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

Map<String, dynamic> _$AudiobookSimpleToJson(AudiobookSimple instance) => <String, dynamic>{
      'authors': instance.authors?.map((e) => e.toJson()).toList(),
      'copyrights': instance.copyrights?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'html_description': instance.htmlDescription,
      'edition': instance.edition,
      'explicit': instance.explicit,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'languages': instance.languages,
      'media_type': instance.mediaType,
      'name': instance.name,
      'narrators': instance.narrators?.map((e) => e.toJson()).toList(),
      'total_chapters': instance.totalChapters,
      'type': instance.type,
      'uri': instance.uri,
    };

AudiobookSaved _$AudiobookSavedFromJson(Map<String, dynamic> json) => AudiobookSaved()
  ..addedAt = json['added_at'] == null ? null : DateTime.parse(json['added_at'] as String)
  ..audiobook = json['audiobook'] == null ? null : Audiobook.fromJson(json['audiobook'] as Map<String, dynamic>);

Map<String, dynamic> _$AudiobookSavedToJson(AudiobookSaved instance) => <String, dynamic>{
      'added_at': instance.addedAt?.toIso8601String(),
      'audiobook': instance.audiobook?.toJson(),
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author()..name = json['name'] as String?;

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'name': instance.name,
    };

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter()
  ..audiobook = json['audiobook'] == null ? null : AudiobookSimple.fromJson(json['audiobook'] as Map<String, dynamic>)
  ..audioPreviewUrl = json['audio_preview_url'] as String?
  ..chapterNumber = convertToIntIfDoubleValue(json['chapter_number'])
  ..description = json['description'] as String?
  ..htmlDescription = json['html_description'] as String?
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..explicit = json['explicit'] as bool?
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..isPlayable = json['is_playable'] as bool?
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..name = json['name'] as String?
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(_$DatePrecisionEnumMap, json['release_date_precision'])
  ..resumePoint =
      json['resume_point'] == null ? null : ResumePoint.fromJson(json['resume_point'] as Map<String, dynamic>)
  ..restrictions =
      json['restrictions'] == null ? null : Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>)
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'audiobook': instance.audiobook?.toJson(),
      'audio_preview_url': instance.audioPreviewUrl,
      'chapter_number': instance.chapterNumber,
      'description': instance.description,
      'html_description': instance.htmlDescription,
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'is_playable': instance.isPlayable,
      'languages': instance.languages,
      'name': instance.name,
      'release_date': instance.releaseDate,
      'release_date_precision': _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'resume_point': instance.resumePoint?.toJson(),
      'restrictions': instance.restrictions?.toJson(),
      'type': instance.type,
      'uri': instance.uri,
    };

ChapterSimple _$ChapterSimpleFromJson(Map<String, dynamic> json) => ChapterSimple()
  ..audioPreviewUrl = json['audio_preview_url'] as String?
  ..chapterNumber = convertToIntIfDoubleValue(json['chapter_number'])
  ..description = json['description'] as String?
  ..htmlDescription = json['html_description'] as String?
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..explicit = json['explicit'] as bool?
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..isPlayable = json['is_playable'] as bool?
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..name = json['name'] as String?
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(_$DatePrecisionEnumMap, json['release_date_precision'])
  ..resumePoint =
      json['resume_point'] == null ? null : ResumePoint.fromJson(json['resume_point'] as Map<String, dynamic>)
  ..restrictions =
      json['restrictions'] == null ? null : Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>)
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

Map<String, dynamic> _$ChapterSimpleToJson(ChapterSimple instance) => <String, dynamic>{
      'audio_preview_url': instance.audioPreviewUrl,
      'chapter_number': instance.chapterNumber,
      'description': instance.description,
      'html_description': instance.htmlDescription,
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'is_playable': instance.isPlayable,
      'languages': instance.languages,
      'name': instance.name,
      'release_date': instance.releaseDate,
      'release_date_precision': _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'resume_point': instance.resumePoint?.toJson(),
      'restrictions': instance.restrictions?.toJson(),
      'type': instance.type,
      'uri': instance.uri,
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

Narrator _$NarratorFromJson(Map<String, dynamic> json) => Narrator()..name = json['name'] as String?;

Map<String, dynamic> _$NarratorToJson(Narrator instance) => <String, dynamic>{
      'name': instance.name,
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
  ..item = json['item'] == null ? null : Track.fromJson(json['item'] as Map<String, dynamic>)
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

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist()
  ..collaborative = json['collaborative'] as bool?
  ..description = json['description'] as String?
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..followers = json['followers'] == null ? null : Followers.fromJson(json['followers'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..name = json['name'] as String?
  ..owner = json['owner'] == null ? null : User.fromJson(json['owner'] as Map<String, dynamic>)
  ..public = json['public'] as bool?
  ..snapshotId = json['snapshot_id'] as String?
  ..items = json['items'] == null ? null : Paging<PlaylistTrack>.fromJson(json['items'] as Map<String, dynamic>)
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'collaborative': instance.collaborative,
      'description': instance.description,
      'external_urls': instance.externalUrls?.toJson(),
      'followers': instance.followers?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'owner': instance.owner?.toJson(),
      'public': instance.public,
      'snapshot_id': instance.snapshotId,
      'items': instance.items?.toJson(),
      'type': instance.type,
      'uri': instance.uri,
    };

PlaylistSimple _$PlaylistSimpleFromJson(Map<String, dynamic> json) => PlaylistSimple()
  ..collaborative = json['collaborative'] as bool?
  ..description = json['description'] as String?
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..followers = json['followers'] == null ? null : Followers.fromJson(json['followers'] as Map<String, dynamic>)
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..name = json['name'] as String?
  ..owner = json['owner'] == null ? null : User.fromJson(json['owner'] as Map<String, dynamic>)
  ..public = json['public'] as bool?
  ..snapshotId = json['snapshot_id'] as String?
  ..itemsLink = json['items'] == null ? null : TracksLink.fromJson(json['items'] as Map<String, dynamic>)
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

Map<String, dynamic> _$PlaylistSimpleToJson(PlaylistSimple instance) => <String, dynamic>{
      'collaborative': instance.collaborative,
      'description': instance.description,
      'external_urls': instance.externalUrls?.toJson(),
      'followers': instance.followers?.toJson(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'owner': instance.owner?.toJson(),
      'public': instance.public,
      'snapshot_id': instance.snapshotId,
      'items': instance.itemsLink?.toJson(),
      'type': instance.type,
      'uri': instance.uri,
    };

PlaylistsFeatured _$PlaylistsFeaturedFromJson(Map<String, dynamic> json) => PlaylistsFeatured()
  ..content = json['content'] == null ? null : Playlist.fromJson(json['content'] as Map<String, dynamic>)
  ..message = json['message'] as String?;

Map<String, dynamic> _$PlaylistsFeaturedToJson(PlaylistsFeatured instance) => <String, dynamic>{
      'content': instance.content?.toJson(),
      'message': instance.message,
    };

PlaylistTrack _$PlaylistTrackFromJson(Map<String, dynamic> json) => PlaylistTrack()
  ..addedAt = json['added_at'] == null ? null : DateTime.parse(json['added_at'] as String)
  ..addedBy = json['added_by'] == null ? null : UserPublic.fromJson(json['added_by'] as Map<String, dynamic>)
  ..isLocal = json['is_local'] as bool?
  ..item = json['item'] == null ? null : Track.fromJson(json['item'] as Map<String, dynamic>);

Map<String, dynamic> _$PlaylistTrackToJson(PlaylistTrack instance) => <String, dynamic>{
      'added_at': instance.addedAt?.toIso8601String(),
      'added_by': instance.addedBy?.toJson(),
      'is_local': instance.isLocal,
      'item': instance.item?.toJson(),
    };

Restrictions _$RestrictionsFromJson(Map<String, dynamic> json) => Restrictions()..reason = json['reason'] as String?;

Map<String, dynamic> _$RestrictionsToJson(Restrictions instance) => <String, dynamic>{
      'reason': instance.reason,
    };

ResumePoint _$ResumePointFromJson(Map<String, dynamic> json) => ResumePoint()
  ..fullyPlayed = json['fully_played'] as bool?
  ..resumePositionMs = convertToIntIfDoubleValue(json['resume_position_ms']);

Map<String, dynamic> _$ResumePointToJson(ResumePoint instance) => <String, dynamic>{
      'fully_played': instance.fullyPlayed,
      'resume_position_ms': instance.resumePositionMs,
    };

Show _$ShowFromJson(Map<String, dynamic> json) => Show()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = json['uri'] as String?
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..copyrights =
      (json['copyrights'] as List<dynamic>?)?.map((e) => Copyright.fromJson(e as Map<String, dynamic>)).toList()
  ..description = json['description'] as String?
  ..explicit = json['explicit'] as bool?
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..isExternallyHosted = json['is_externally_hosted'] as bool?
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..mediaType = json['media_type'] as String?
  ..name = json['name'] as String?
  ..totalEpisodes = json['total_episodes'] == null ? 0 : convertToIntIfDoubleValue(json['total_episodes']);

Map<String, dynamic> _$ShowToJson(Show instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'uri': instance.uri,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'copyrights': instance.copyrights?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'explicit': instance.explicit,
      'external_urls': instance.externalUrls?.toJson(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'is_externally_hosted': instance.isExternallyHosted,
      'languages': instance.languages,
      'media_type': instance.mediaType,
      'name': instance.name,
      'total_episodes': instance.totalEpisodes,
    };

const _$SpotifyContentTypeEnumMap = {
  SpotifyContentType.album: 'album',
  SpotifyContentType.track: 'track',
  SpotifyContentType.playlist: 'playlist',
  SpotifyContentType.episode: 'episode',
  SpotifyContentType.show: 'show',
};

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = json['uri'] as String?
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..name = json['name'] as String?
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..explicit = json['explicit'] as bool?
  ..isPlayable = json['is_playable'] as bool?
  ..audioPreviewUrl = json['audio_preview_url'] as String?
  ..description = json['description'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..isExternallyHosted = json['is_externally_hosted'] as bool?
  ..language = json['language'] as String?
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..releaseDate = json['release_date'] == null ? null : DateTime.parse(json['release_date'] as String)
  ..releaseDatePrecision = json['release_date_precision'] as String?;

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'uri': instance.uri,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'name': instance.name,
      'external_urls': instance.externalUrls?.toJson(),
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
      'is_playable': instance.isPlayable,
      'audio_preview_url': instance.audioPreviewUrl,
      'description': instance.description,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'is_externally_hosted': instance.isExternallyHosted,
      'language': instance.language,
      'languages': instance.languages,
      'release_date': instance.releaseDate?.toIso8601String(),
      'release_date_precision': instance.releaseDatePrecision,
    };

EpisodeFull _$EpisodeFullFromJson(Map<String, dynamic> json) => EpisodeFull()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = json['uri'] as String?
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..name = json['name'] as String?
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..explicit = json['explicit'] as bool?
  ..isPlayable = json['is_playable'] as bool?
  ..audioPreviewUrl = json['audio_preview_url'] as String?
  ..description = json['description'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..isExternallyHosted = json['is_externally_hosted'] as bool?
  ..language = json['language'] as String?
  ..languages = (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..releaseDate = json['release_date'] == null ? null : DateTime.parse(json['release_date'] as String)
  ..releaseDatePrecision = json['release_date_precision'] as String?
  ..show = json['show'] == null ? null : Show.fromJson(json['show'] as Map<String, dynamic>);

Map<String, dynamic> _$EpisodeFullToJson(EpisodeFull instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'uri': instance.uri,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'name': instance.name,
      'external_urls': instance.externalUrls?.toJson(),
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
      'is_playable': instance.isPlayable,
      'audio_preview_url': instance.audioPreviewUrl,
      'description': instance.description,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'is_externally_hosted': instance.isExternallyHosted,
      'language': instance.language,
      'languages': instance.languages,
      'release_date': instance.releaseDate?.toIso8601String(),
      'release_date_precision': instance.releaseDatePrecision,
      'show': instance.show?.toJson(),
    };

Track _$TrackFromJson(Map<String, dynamic> json) => Track()
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..uri = json['uri'] as String?
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..name = json['name'] as String?
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..explicit = json['explicit'] as bool?
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
      'uri': instance.uri,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'name': instance.name,
      'external_urls': instance.externalUrls?.toJson(),
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
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
  ..uri = json['uri'] as String?
  ..type = $enumDecodeNullable(_$SpotifyContentTypeEnumMap, json['type'])
  ..name = json['name'] as String?
  ..externalUrls =
      json['external_urls'] == null ? null : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..explicit = json['explicit'] as bool?
  ..isPlayable = json['is_playable'] as bool?
  ..artists = (json['artists'] as List<dynamic>?)?.map((e) => Artist.fromJson(e as Map<String, dynamic>)).toList()
  ..discNumber = convertToIntIfDoubleValue(json['disc_number'])
  ..previewUrl = json['preview_url'] as String?
  ..trackNumber = convertToIntIfDoubleValue(json['track_number']);

Map<String, dynamic> _$TrackSimpleToJson(TrackSimple instance) => <String, dynamic>{
      'href': instance.href,
      'id': instance.id,
      'uri': instance.uri,
      'type': _$SpotifyContentTypeEnumMap[instance.type],
      'name': instance.name,
      'external_urls': instance.externalUrls?.toJson(),
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
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
  ..accountId = json['account_id'] as String?
  ..birthdate = json['birthdate'] as String?
  ..displayName = json['display_name'] as String?
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'account_id': instance.accountId,
      'birthdate': instance.birthdate,
      'display_name': instance.displayName,
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'type': instance.type,
      'uri': instance.uri,
    };

UserPublic _$UserPublicFromJson(Map<String, dynamic> json) => UserPublic()
  ..displayName = json['display_name'] as String?
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)?.map((e) => Image.fromJson(e as Map<String, dynamic>)).toList()
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

Map<String, dynamic> _$UserPublicToJson(UserPublic instance) => <String, dynamic>{
      'display_name': instance.displayName,
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'type': instance.type,
      'uri': instance.uri,
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
  ..currentlyPlaying =
      json['currently_playing'] == null ? null : Track.fromJson(json['currently_playing'] as Map<String, dynamic>)
  ..queue = (json['queue'] as List<dynamic>?)?.map((e) => Track.fromJson(e as Map<String, dynamic>)).toList();

Map<String, dynamic> _$QueueToJson(Queue instance) => <String, dynamic>{
      'currently_playing': instance.currentlyPlaying?.toJson(),
      'queue': instance.queue?.map((e) => e.toJson()).toList(),
    };
