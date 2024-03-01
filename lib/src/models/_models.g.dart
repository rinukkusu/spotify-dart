// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExternalUrls _$ExternalUrlsFromJson(Map<String, dynamic> json) =>
    ExternalUrls()..spotify = json['spotify'] as String?;

ExternalIds _$ExternalIdsFromJson(Map<String, dynamic> json) => ExternalIds()
  ..isrc = json['isrc'] as String?
  ..ean = json['ean'] as String?
  ..upc = json['upc'] as String?;

Album _$AlbumFromJson(Map<String, dynamic> json) => Album()
  ..albumType = AlbumSimple._convertForAlbumType(json['album_type'] as String?)
  ..artists = (json['artists'] as List<dynamic>?)
      ?.map((e) => ArtistSimple.fromJson(e as Map<String, dynamic>))
      .toList()
  ..availableMarkets = (json['available_markets'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$MarketEnumMap, e))
      .toList()
  ..externalUrls = json['external_urls'] == null
      ? null
      : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..name = json['name'] as String?
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(
      _$DatePrecisionEnumMap, json['release_date_precision'])
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?
  ..tracks = AlbumSimple._extractTracksFromPage(json['tracks'])
  ..copyrights = (json['copyrights'] as List<dynamic>?)
      ?.map((e) => Copyright.fromJson(e as Map<String, dynamic>))
      .toList()
  ..externalIds = json['external_ids'] == null
      ? null
      : ExternalIds.fromJson(json['external_ids'] as Map<String, dynamic>)
  ..genres =
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..label = json['label'] as String?
  ..popularity = convertToIntIfDoubleValue(json['popularity']);

const _$MarketEnumMap = {
  Market.AD: 'AD',
  Market.AE: 'AE',
  Market.AF: 'AF',
  Market.AG: 'AG',
  Market.AI: 'AI',
  Market.AL: 'AL',
  Market.AM: 'AM',
  Market.AO: 'AO',
  Market.AQ: 'AQ',
  Market.AR: 'AR',
  Market.AS: 'AS',
  Market.AT: 'AT',
  Market.AU: 'AU',
  Market.AW: 'AW',
  Market.AX: 'AX',
  Market.AZ: 'AZ',
  Market.BA: 'BA',
  Market.BB: 'BB',
  Market.BD: 'BD',
  Market.BE: 'BE',
  Market.BF: 'BF',
  Market.BG: 'BG',
  Market.BH: 'BH',
  Market.BI: 'BI',
  Market.BJ: 'BJ',
  Market.BL: 'BL',
  Market.BM: 'BM',
  Market.BN: 'BN',
  Market.BO: 'BO',
  Market.BQ: 'BQ',
  Market.BR: 'BR',
  Market.BS: 'BS',
  Market.BT: 'BT',
  Market.BV: 'BV',
  Market.BW: 'BW',
  Market.BY: 'BY',
  Market.BZ: 'BZ',
  Market.CA: 'CA',
  Market.CC: 'CC',
  Market.CD: 'CD',
  Market.CF: 'CF',
  Market.CG: 'CG',
  Market.CH: 'CH',
  Market.CI: 'CI',
  Market.CK: 'CK',
  Market.CL: 'CL',
  Market.CM: 'CM',
  Market.CN: 'CN',
  Market.CO: 'CO',
  Market.CR: 'CR',
  Market.CU: 'CU',
  Market.CV: 'CV',
  Market.CW: 'CW',
  Market.CX: 'CX',
  Market.CY: 'CY',
  Market.CZ: 'CZ',
  Market.DE: 'DE',
  Market.DJ: 'DJ',
  Market.DK: 'DK',
  Market.DM: 'DM',
  Market.DO: 'DO',
  Market.DZ: 'DZ',
  Market.EC: 'EC',
  Market.EE: 'EE',
  Market.EG: 'EG',
  Market.EH: 'EH',
  Market.ER: 'ER',
  Market.ES: 'ES',
  Market.ET: 'ET',
  Market.FI: 'FI',
  Market.FJ: 'FJ',
  Market.FK: 'FK',
  Market.FM: 'FM',
  Market.FO: 'FO',
  Market.FR: 'FR',
  Market.GA: 'GA',
  Market.GB: 'GB',
  Market.GD: 'GD',
  Market.GE: 'GE',
  Market.GF: 'GF',
  Market.GG: 'GG',
  Market.GH: 'GH',
  Market.GI: 'GI',
  Market.GL: 'GL',
  Market.GM: 'GM',
  Market.GN: 'GN',
  Market.GP: 'GP',
  Market.GQ: 'GQ',
  Market.GR: 'GR',
  Market.GS: 'GS',
  Market.GT: 'GT',
  Market.GU: 'GU',
  Market.GW: 'GW',
  Market.GY: 'GY',
  Market.HK: 'HK',
  Market.HM: 'HM',
  Market.HN: 'HN',
  Market.HR: 'HR',
  Market.HT: 'HT',
  Market.HU: 'HU',
  Market.ID: 'ID',
  Market.IE: 'IE',
  Market.IL: 'IL',
  Market.IM: 'IM',
  Market.IN: 'IN',
  Market.IO: 'IO',
  Market.IQ: 'IQ',
  Market.IR: 'IR',
  Market.IS: 'IS',
  Market.IT: 'IT',
  Market.JE: 'JE',
  Market.JM: 'JM',
  Market.JO: 'JO',
  Market.JP: 'JP',
  Market.KE: 'KE',
  Market.KG: 'KG',
  Market.KH: 'KH',
  Market.KI: 'KI',
  Market.KM: 'KM',
  Market.KN: 'KN',
  Market.KP: 'KP',
  Market.KR: 'KR',
  Market.KW: 'KW',
  Market.KY: 'KY',
  Market.KZ: 'KZ',
  Market.LA: 'LA',
  Market.LB: 'LB',
  Market.LC: 'LC',
  Market.LI: 'LI',
  Market.LK: 'LK',
  Market.LR: 'LR',
  Market.LS: 'LS',
  Market.LT: 'LT',
  Market.LU: 'LU',
  Market.LV: 'LV',
  Market.LY: 'LY',
  Market.MA: 'MA',
  Market.MC: 'MC',
  Market.MD: 'MD',
  Market.ME: 'ME',
  Market.MF: 'MF',
  Market.MG: 'MG',
  Market.MH: 'MH',
  Market.MK: 'MK',
  Market.ML: 'ML',
  Market.MM: 'MM',
  Market.MN: 'MN',
  Market.MO: 'MO',
  Market.MP: 'MP',
  Market.MQ: 'MQ',
  Market.MR: 'MR',
  Market.MS: 'MS',
  Market.MT: 'MT',
  Market.MU: 'MU',
  Market.MV: 'MV',
  Market.MW: 'MW',
  Market.MX: 'MX',
  Market.MY: 'MY',
  Market.MZ: 'MZ',
  Market.NA: 'NA',
  Market.NC: 'NC',
  Market.NE: 'NE',
  Market.NF: 'NF',
  Market.NG: 'NG',
  Market.NI: 'NI',
  Market.NL: 'NL',
  Market.NO: 'NO',
  Market.NP: 'NP',
  Market.NR: 'NR',
  Market.NU: 'NU',
  Market.NZ: 'NZ',
  Market.OM: 'OM',
  Market.PA: 'PA',
  Market.PE: 'PE',
  Market.PF: 'PF',
  Market.PG: 'PG',
  Market.PH: 'PH',
  Market.PK: 'PK',
  Market.PL: 'PL',
  Market.PM: 'PM',
  Market.PN: 'PN',
  Market.PR: 'PR',
  Market.PS: 'PS',
  Market.PT: 'PT',
  Market.PW: 'PW',
  Market.PY: 'PY',
  Market.QA: 'QA',
  Market.RE: 'RE',
  Market.RO: 'RO',
  Market.RS: 'RS',
  Market.RU: 'RU',
  Market.RW: 'RW',
  Market.SA: 'SA',
  Market.SB: 'SB',
  Market.SC: 'SC',
  Market.SD: 'SD',
  Market.SE: 'SE',
  Market.SG: 'SG',
  Market.SH: 'SH',
  Market.SI: 'SI',
  Market.SJ: 'SJ',
  Market.SK: 'SK',
  Market.SL: 'SL',
  Market.SM: 'SM',
  Market.SN: 'SN',
  Market.SO: 'SO',
  Market.SR: 'SR',
  Market.SS: 'SS',
  Market.ST: 'ST',
  Market.SV: 'SV',
  Market.SX: 'SX',
  Market.SY: 'SY',
  Market.SZ: 'SZ',
  Market.TC: 'TC',
  Market.TD: 'TD',
  Market.TF: 'TF',
  Market.TG: 'TG',
  Market.TH: 'TH',
  Market.TJ: 'TJ',
  Market.TK: 'TK',
  Market.TL: 'TL',
  Market.TM: 'TM',
  Market.TN: 'TN',
  Market.TO: 'TO',
  Market.TR: 'TR',
  Market.TT: 'TT',
  Market.TV: 'TV',
  Market.TW: 'TW',
  Market.TZ: 'TZ',
  Market.UA: 'UA',
  Market.UG: 'UG',
  Market.UM: 'UM',
  Market.US: 'US',
  Market.UY: 'UY',
  Market.UZ: 'UZ',
  Market.VA: 'VA',
  Market.VC: 'VC',
  Market.VE: 'VE',
  Market.VG: 'VG',
  Market.VI: 'VI',
  Market.VN: 'VN',
  Market.VU: 'VU',
  Market.WF: 'WF',
  Market.WS: 'WS',
  Market.XK: 'XK',
  Market.YE: 'YE',
  Market.YT: 'YT',
  Market.ZA: 'ZA',
  Market.ZM: 'ZM',
  Market.ZW: 'ZW',
};

const _$DatePrecisionEnumMap = {
  DatePrecision.day: 'day',
  DatePrecision.month: 'month',
  DatePrecision.year: 'year',
};

AlbumSimple _$AlbumSimpleFromJson(Map<String, dynamic> json) => AlbumSimple()
  ..albumType = AlbumSimple._convertForAlbumType(json['album_type'] as String?)
  ..artists = (json['artists'] as List<dynamic>?)
      ?.map((e) => ArtistSimple.fromJson(e as Map<String, dynamic>))
      .toList()
  ..availableMarkets = (json['available_markets'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$MarketEnumMap, e))
      .toList()
  ..externalUrls = json['external_urls'] == null
      ? null
      : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..name = json['name'] as String?
  ..releaseDate = json['release_date'] as String?
  ..releaseDatePrecision = $enumDecodeNullable(
      _$DatePrecisionEnumMap, json['release_date_precision'])
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?
  ..tracks = AlbumSimple._extractTracksFromPage(json['tracks']);

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist()
  ..externalUrls = json['external_urls'] == null
      ? null
      : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?
  ..followers = json['followers'] == null
      ? null
      : Followers.fromJson(json['followers'] as Map<String, dynamic>)
  ..genres =
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..images = (json['images'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..popularity = convertToIntIfDoubleValue(json['popularity']);

ArtistSimple _$ArtistSimpleFromJson(Map<String, dynamic> json) => ArtistSimple()
  ..externalUrls = json['external_urls'] == null
      ? null
      : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

AudioAnalysis _$AudioAnalysisFromJson(Map<String, dynamic> json) =>
    AudioAnalysis()
      ..track = json['track'] == null
          ? null
          : TrackAudioAnalysis.fromJson(json['track'] as Map<String, dynamic>)
      ..bars = (json['bars'] as List<dynamic>?)
          ?.map((e) => TimeInterval.fromJson(e as Map<String, dynamic>))
          .toList()
      ..beats = (json['beats'] as List<dynamic>?)
          ?.map((e) => TimeInterval.fromJson(e as Map<String, dynamic>))
          .toList()
      ..sections = (json['sections'] as List<dynamic>?)
          ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList()
      ..segments = (json['segments'] as List<dynamic>?)
          ?.map((e) => Segment.fromJson(e as Map<String, dynamic>))
          .toList()
      ..tatums = (json['tatums'] as List<dynamic>?)
          ?.map((e) => TimeInterval.fromJson(e as Map<String, dynamic>))
          .toList();

TrackAudioAnalysis _$TrackAudioAnalysisFromJson(Map<String, dynamic> json) =>
    TrackAudioAnalysis()
      ..duration = (json['duration'] as num?)?.toDouble()
      ..confidence = (json['confidence'] as num?)?.toDouble()
      ..loudness = (json['loudness'] as num?)?.toDouble()
      ..tempo = (json['tempo'] as num?)?.toDouble()
      ..tempoConfidence = (json['tempo_confidence'] as num?)?.toDouble()
      ..key = convertToIntIfDoubleValue(json['key'])
      ..keyConfidence = (json['key_confidence'] as num?)?.toDouble()
      ..mode = convertToIntIfDoubleValue(json['mode'])
      ..modeConfidence = (json['mode_confidence'] as num?)?.toDouble()
      ..timeSignature = convertToIntIfDoubleValue(json['time_signature'])
      ..timeSignatureConfidence =
          (json['time_signature_confidence'] as num?)?.toDouble()
      ..numSamples = convertToIntIfDoubleValue(json['num_samples'])
      ..analysisSampleRate =
          convertToIntIfDoubleValue(json['analysis_sample_rate'])
      ..analysisChannels = convertToIntIfDoubleValue(json['analysis_channels'])
      ..endOfFadeIn = (json['end_of_fade_in'] as num?)?.toDouble()
      ..startOfFadeOut = (json['start_of_fade_out'] as num?)?.toDouble()
      ..synchString = json['synchstring'] as String?
      ..synchVersion = (json['synch_version'] as num?)?.toDouble()
      ..rhythmString = json['rhythmstring'] as String?
      ..rhythmVersion = (json['rhythm_version'] as num?)?.toDouble()
      ..codeString = json['codestring'] as String?
      ..codeVersion = (json['code_version'] as num?)?.toDouble();

Section _$SectionFromJson(Map<String, dynamic> json) => Section()
  ..duration = (json['duration'] as num?)?.toDouble()
  ..confidence = (json['confidence'] as num?)?.toDouble()
  ..loudness = (json['loudness'] as num?)?.toDouble()
  ..tempo = (json['tempo'] as num?)?.toDouble()
  ..tempoConfidence = (json['tempo_confidence'] as num?)?.toDouble()
  ..key = convertToIntIfDoubleValue(json['key'])
  ..keyConfidence = (json['key_confidence'] as num?)?.toDouble()
  ..mode = convertToIntIfDoubleValue(json['mode'])
  ..modeConfidence = (json['mode_confidence'] as num?)?.toDouble()
  ..timeSignature = convertToIntIfDoubleValue(json['time_signature'])
  ..timeSignatureConfidence =
      (json['time_signature_confidence'] as num?)?.toDouble()
  ..start = (json['start'] as num?)?.toDouble();

Segment _$SegmentFromJson(Map<String, dynamic> json) => Segment()
  ..start = (json['start'] as num?)?.toDouble()
  ..duration = (json['duration'] as num?)?.toDouble()
  ..confidence = (json['confidence'] as num?)?.toDouble()
  ..loudnessStart = (json['loudness_start'] as num?)?.toDouble()
  ..loudnessMax = (json['loudness_max'] as num?)?.toDouble()
  ..loudnessMaxTime = (json['loudness_max_time'] as num?)?.toDouble()
  ..loudnessEnd = (json['loudness_end'] as num?)?.toDouble()
  ..pitches = (json['pitches'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList()
  ..timbre = (json['timbre'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList();

TimeInterval _$TimeIntervalFromJson(Map<String, dynamic> json) => TimeInterval()
  ..confidence = (json['confidence'] as num?)?.toDouble()
  ..duration = (json['duration'] as num?)?.toDouble()
  ..start = (json['start'] as num?)?.toDouble();

AudioFeature _$AudioFeatureFromJson(Map<String, dynamic> json) => AudioFeature()
  ..acousticness = (json['acousticness'] as num?)?.toDouble()
  ..analysisUrl = json['analysis_url'] as String?
  ..danceability = (json['danceability'] as num?)?.toDouble()
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..energy = (json['energy'] as num?)?.toDouble()
  ..id = json['id'] as String?
  ..instrumentalness = (json['instrumentalness'] as num?)?.toDouble()
  ..key = convertToIntIfDoubleValue(json['key'])
  ..liveness = (json['liveness'] as num?)?.toDouble()
  ..loudness = (json['loudness'] as num?)?.toDouble()
  ..mode = convertToIntIfDoubleValue(json['mode'])
  ..speechiness = (json['speechiness'] as num?)?.toDouble()
  ..tempo = (json['tempo'] as num?)?.toDouble()
  ..timeSignature = convertToIntIfDoubleValue(json['time_signature'])
  ..trackHref = json['track_href'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?
  ..valence = (json['valence'] as num?)?.toDouble();

Category _$CategoryFromJson(Map<String, dynamic> json) => Category()
  ..href = json['href'] as String?
  ..icons = (json['icons'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..id = json['id'] as String?
  ..name = json['name'] as String?;

Copyright _$CopyrightFromJson(Map<String, dynamic> json) => Copyright()
  ..text = json['text'] as String?
  ..type = $enumDecodeNullable(_$CopyrightTypeEnumMap, json['type']);

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
  ..type = $enumDecodeNullable(_$DeviceTypeEnumMap, json['type'],
      unknownValue: DeviceType.Unknown)
  ..volumePercent = convertToIntIfDoubleValue(json['volume_percent']);

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

Followers _$FollowersFromJson(Map<String, dynamic> json) => Followers()
  ..href = json['href'] as String?
  ..total = convertToIntIfDoubleValue(json['total']);

Image _$ImageFromJson(Map<String, dynamic> json) => Image()
  ..height = convertToIntIfDoubleValue(json['height'])
  ..width = convertToIntIfDoubleValue(json['width'])
  ..url = json['url'] as String?;

Paging<T> _$PagingFromJson<T>(Map<String, dynamic> json) => Paging<T>()
  ..href = json['href'] as String?
  ..itemsNative = itemsNativeFromJson(json['items'] as List)
  ..limit = convertToIntIfDoubleValueWithoutNull(json['limit'])
  ..next = json['next'] as String?
  ..offset = convertToIntIfDoubleValue(json['offset'])
  ..previous = json['previous'] as String?
  ..total = convertToIntIfDoubleValueWithoutNull(json['total']);

CursorPaging<T> _$CursorPagingFromJson<T>(Map<String, dynamic> json) =>
    CursorPaging<T>()
      ..href = json['href'] as String?
      ..itemsNative = itemsNativeFromJson(json['items'] as List)
      ..limit = convertToIntIfDoubleValueWithoutNull(json['limit'])
      ..next = json['next'] as String?
      ..cursors = json['cursors'] == null
          ? null
          : Cursor.fromJson(json['cursors'] as Map<String, dynamic>);

Cursor _$CursorFromJson(Map<String, dynamic> json) =>
    Cursor()..after = json['after'] as String?;

PlaybackState _$PlaybackStateFromJson(Map<String, dynamic> json) =>
    PlaybackState()
      ..timestamp = convertToIntIfDoubleValue(json['timestamp'])
      ..context = json['context'] == null
          ? null
          : PlayerContext.fromJson(json['context'] as Map<String, dynamic>)
      ..progressMs = convertToIntIfDoubleValue(json['progress_ms'])
      ..item = json['item'] == null
          ? null
          : Track.fromJson(json['item'] as Map<String, dynamic>)
      ..currentlyPlayingType = $enumDecodeNullable(
          _$CurrentlyPlayingTypeEnumMap, json['currently_playing_type'])
      ..actions = json['actions'] == null
          ? null
          : Actions.fromJson(json['actions'] as Map<String, dynamic>)
      ..isPlaying = json['is_playing'] as bool? ?? false
      ..isShuffling = json['shuffle_state'] as bool? ?? false
      ..repeatState =
          $enumDecodeNullable(_$RepeatStateEnumMap, json['repeat_state']) ??
              RepeatState.off;

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

PlayerContext _$PlayerContextFromJson(Map<String, dynamic> json) =>
    PlayerContext()
      ..externalUrls = json['external_urls'] == null
          ? null
          : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
      ..href = json['href'] as String?
      ..type = json['type'] as String?
      ..uri = json['uri'] as String?;

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

Map<String, dynamic> _$StartWithContextOptionsToJson(
        StartWithContextOptions instance) =>
    <String, dynamic>{
      'context_uri': instance.contextUri,
      'offset': StartWithContextOptions._offsetToJson(instance.offset),
    };

Map<String, dynamic> _$StartWithUrisOptionsToJson(
        StartWithUrisOptions instance) =>
    <String, dynamic>{
      'uris': instance.uris,
      'position_ms': instance.positionMs,
    };

Map<String, dynamic> _$UriOffsetToJson(UriOffset instance) => <String, dynamic>{
      'uri': instance.uri,
    };

Map<String, dynamic> _$PositionOffsetToJson(PositionOffset instance) =>
    <String, dynamic>{
      'position': instance.position,
    };

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist()
  ..collaborative = json['collaborative'] as bool?
  ..description = json['description'] as String?
  ..externalUrls = json['external_urls'] == null
      ? null
      : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..followers = json['followers'] == null
      ? null
      : Followers.fromJson(json['followers'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..name = json['name'] as String?
  ..owner = json['owner'] == null
      ? null
      : User.fromJson(json['owner'] as Map<String, dynamic>)
  ..public = json['public'] as bool?
  ..snapshotId = json['snapshot_id'] as String?
  ..tracks = json['tracks'] == null
      ? null
      : Paging<Track>.fromJson(json['tracks'] as Map<String, dynamic>)
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

PlaylistSimple _$PlaylistSimpleFromJson(Map<String, dynamic> json) =>
    PlaylistSimple()
      ..collaborative = json['collaborative'] as bool?
      ..description = json['description'] as String?
      ..externalUrls = json['external_urls'] == null
          ? null
          : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
      ..href = json['href'] as String?
      ..id = json['id'] as String?
      ..images = (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList()
      ..name = json['name'] as String?
      ..owner = json['owner'] == null
          ? null
          : User.fromJson(json['owner'] as Map<String, dynamic>)
      ..public = json['public'] as bool?
      ..snapshotId = json['snapshot_id'] as String?
      ..tracksLink = json['tracks'] == null
          ? null
          : TracksLink.fromJson(json['tracks'] as Map<String, dynamic>)
      ..type = json['type'] as String?
      ..uri = json['uri'] as String?;

PlaylistsFeatured _$PlaylistsFeaturedFromJson(Map<String, dynamic> json) =>
    PlaylistsFeatured()..message = json['message'] as String?;

PlaylistTrack _$PlaylistTrackFromJson(Map<String, dynamic> json) =>
    PlaylistTrack()
      ..addedAt = json['added_at'] == null
          ? null
          : DateTime.parse(json['added_at'] as String)
      ..addedBy = json['added_by'] == null
          ? null
          : UserPublic.fromJson(json['added_by'] as Map<String, dynamic>)
      ..isLocal = json['is_local'] as bool?
      ..track = json['track'] == null
          ? null
          : Track.fromJson(json['track'] as Map<String, dynamic>);

Recommendations _$RecommendationsFromJson(Map<String, dynamic> json) =>
    Recommendations()
      ..seeds = (json['seeds'] as List<dynamic>?)
          ?.map((e) => RecommendationsSeed.fromJson(e as Map<String, dynamic>))
          .toList()
      ..tracks = (json['tracks'] as List<dynamic>?)
          ?.map((e) => TrackSimple.fromJson(e as Map<String, dynamic>))
          .toList();

RecommendationsSeed _$RecommendationsSeedFromJson(Map<String, dynamic> json) =>
    RecommendationsSeed()
      ..afterFilteringSize =
          convertToIntIfDoubleValue(json['afterFilteringSize'])
      ..afterRelinkingSize =
          convertToIntIfDoubleValue(json['afterRelinkingSize'])
      ..href = json['href'] as String?
      ..id = json['id'] as String?
      ..initialPoolSize = convertToIntIfDoubleValue(json['initialPoolSize'])
      ..type = json['type'] as String?;

Show _$ShowFromJson(Map<String, dynamic> json) => Show()
  ..availableMarkets = (json['available_markets'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$MarketEnumMap, e))
      .toList()
  ..copyrights = (json['copyrights'] as List<dynamic>?)
      ?.map((e) => Copyright.fromJson(e as Map<String, dynamic>))
      .toList()
  ..description = json['description'] as String?
  ..explicit = json['explicit'] as bool?
  ..externalUrls = json['external_urls'] == null
      ? null
      : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..isExternallyHosted = json['is_externally_hosted'] as bool?
  ..languages =
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..mediaType = json['media_type'] as String?
  ..name = json['name'] as String?
  ..publisher = json['publisher'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?
  ..totalEpisodes = json['total_episodes'] == null
      ? 0
      : convertToIntIfDoubleValue(json['total_episodes']);

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode()
  ..audioPreviewUrl = json['audio_preview_url'] as String?
  ..description = json['description'] as String?
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..explicit = json['explicit'] as bool?
  ..externalUrls = json['external_urls'] == null
      ? null
      : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..isExternallyHosted = json['is_externally_hosted'] as bool?
  ..isPlayable = json['is_playable'] as bool?
  ..language = json['language'] as String?
  ..languages =
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..name = json['name'] as String?
  ..releaseDate = json['release_date'] == null
      ? null
      : DateTime.parse(json['release_date'] as String)
  ..releaseDatePrecision = json['release_date_precision'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

EpisodeFull _$EpisodeFullFromJson(Map<String, dynamic> json) => EpisodeFull()
  ..audioPreviewUrl = json['audio_preview_url'] as String?
  ..description = json['description'] as String?
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..explicit = json['explicit'] as bool?
  ..externalUrls = json['external_urls'] == null
      ? null
      : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..isExternallyHosted = json['is_externally_hosted'] as bool?
  ..isPlayable = json['is_playable'] as bool?
  ..language = json['language'] as String?
  ..languages =
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..name = json['name'] as String?
  ..releaseDate = json['release_date'] == null
      ? null
      : DateTime.parse(json['release_date'] as String)
  ..releaseDatePrecision = json['release_date_precision'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?
  ..show = json['show'] == null
      ? null
      : Show.fromJson(json['show'] as Map<String, dynamic>);

Track _$TrackFromJson(Map<String, dynamic> json) => Track()
  ..album = json['album'] == null
      ? null
      : AlbumSimple.fromJson(json['album'] as Map<String, dynamic>)
  ..artists = (json['artists'] as List<dynamic>?)
      ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
      .toList()
  ..availableMarkets = (json['available_markets'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$MarketEnumMap, e))
      .toList()
  ..discNumber = convertToIntIfDoubleValue(json['disc_number'])
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..explicit = json['explicit'] as bool?
  ..externalIds = json['external_ids'] == null
      ? null
      : ExternalIds.fromJson(json['external_ids'] as Map<String, dynamic>)
  ..externalUrls = json['external_urls'] == null
      ? null
      : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..isPlayable = json['is_playable'] as bool?
  ..linkedFrom = json['linked_from'] == null
      ? null
      : TrackLink.fromJson(json['linked_from'] as Map<String, dynamic>)
  ..name = json['name'] as String?
  ..popularity = convertToIntIfDoubleValue(json['popularity'])
  ..previewUrl = json['preview_url'] as String?
  ..trackNumber = convertToIntIfDoubleValue(json['track_number'])
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

TrackSimple _$TrackSimpleFromJson(Map<String, dynamic> json) => TrackSimple()
  ..artists = (json['artists'] as List<dynamic>?)
      ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
      .toList()
  ..availableMarkets = (json['available_markets'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$MarketEnumMap, e))
      .toList()
  ..discNumber = convertToIntIfDoubleValue(json['disc_number'])
  ..durationMs = convertToIntIfDoubleValue(json['duration_ms'])
  ..explicit = json['explicit'] as bool?
  ..externalUrls = json['external_urls'] == null
      ? null
      : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..isPlayable = json['is_playable'] as bool?
  ..linkedFrom = json['linked_from'] == null
      ? null
      : TrackLink.fromJson(json['linked_from'] as Map<String, dynamic>)
  ..name = json['name'] as String?
  ..previewUrl = json['preview_url'] as String?
  ..trackNumber = convertToIntIfDoubleValue(json['track_number'])
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

TrackSaved _$TrackSavedFromJson(Map<String, dynamic> json) => TrackSaved()
  ..addedAt = json['added_at'] == null
      ? null
      : DateTime.parse(json['added_at'] as String)
  ..track = json['track'] == null
      ? null
      : Track.fromJson(json['track'] as Map<String, dynamic>);

TrackLink _$TrackLinkFromJson(Map<String, dynamic> json) => TrackLink()
  ..externalUrls = (json['external_urls'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  )
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

TracksLink _$TracksLinkFromJson(Map<String, dynamic> json) => TracksLink()
  ..href = json['href'] as String?
  ..total = convertToIntIfDoubleValue(json['total']);

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..birthdate = json['birthdate'] as String?
  ..country = $enumDecodeNullable(_$MarketEnumMap, json['country'])
  ..displayName = json['display_name'] as String?
  ..email = json['email'] as String?
  ..followers = json['followers'] == null
      ? null
      : Followers.fromJson(json['followers'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..product = json['product'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

UserPublic _$UserPublicFromJson(Map<String, dynamic> json) => UserPublic()
  ..displayName = json['display_name'] as String?
  ..followers = json['followers'] == null
      ? null
      : Followers.fromJson(json['followers'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..images = (json['images'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

PlayHistory _$PlayHistoryFromJson(Map<String, dynamic> json) => PlayHistory()
  ..track = json['track'] == null
      ? null
      : TrackSimple.fromJson(json['track'] as Map<String, dynamic>)
  ..playedAt = json['played_at'] == null
      ? null
      : DateTime.parse(json['played_at'] as String)
  ..context = json['context'] == null
      ? null
      : PlayerContext.fromJson(json['context'] as Map<String, dynamic>);

Queue _$QueueFromJson(Map<String, dynamic> json) => Queue()
  ..currentlyPlaying = json['currently_playing'] == null
      ? null
      : Track.fromJson(json['currently_playing'] as Map<String, dynamic>)
  ..queue = (json['queue'] as List<dynamic>?)
      ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
      .toList();
