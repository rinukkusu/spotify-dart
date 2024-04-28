// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExternalUrls _$ExternalUrlsFromJson(Map<String, dynamic> json) =>
    ExternalUrls()..spotify = json['spotify'] as String?;

Map<String, dynamic> _$ExternalUrlsToJson(ExternalUrls instance) =>
    <String, dynamic>{
      'spotify': instance.spotify,
    };

ExternalIds _$ExternalIdsFromJson(Map<String, dynamic> json) => ExternalIds()
  ..isrc = json['isrc'] as String?
  ..ean = json['ean'] as String?
  ..upc = json['upc'] as String?;

Map<String, dynamic> _$ExternalIdsToJson(ExternalIds instance) =>
    <String, dynamic>{
      'isrc': instance.isrc,
      'ean': instance.ean,
      'upc': instance.upc,
    };

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

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'album_type': _$AlbumTypeEnumMap[instance.albumType],
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'available_markets':
          instance.availableMarkets?.map((e) => _$MarketEnumMap[e]!).toList(),
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'release_date': instance.releaseDate,
      'release_date_precision':
          _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'type': instance.type,
      'uri': instance.uri,
      'tracks': instance.tracks?.map((e) => e.toJson()).toList(),
      'copyrights': instance.copyrights?.map((e) => e.toJson()).toList(),
      'external_ids': instance.externalIds?.toJson(),
      'genres': instance.genres,
      'label': instance.label,
      'popularity': instance.popularity,
    };

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

const _$AlbumTypeEnumMap = {
  AlbumType.album: 'album',
  AlbumType.single: 'single',
  AlbumType.compilation: 'compilation',
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

Map<String, dynamic> _$AlbumSimpleToJson(AlbumSimple instance) =>
    <String, dynamic>{
      'album_type': _$AlbumTypeEnumMap[instance.albumType],
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'available_markets':
          instance.availableMarkets?.map((e) => _$MarketEnumMap[e]!).toList(),
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'release_date': instance.releaseDate,
      'release_date_precision':
          _$DatePrecisionEnumMap[instance.releaseDatePrecision],
      'type': instance.type,
      'uri': instance.uri,
      'tracks': instance.tracks?.map((e) => e.toJson()).toList(),
    };

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

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'uri': instance.uri,
      'followers': instance.followers?.toJson(),
      'genres': instance.genres,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'popularity': instance.popularity,
    };

ArtistSimple _$ArtistSimpleFromJson(Map<String, dynamic> json) => ArtistSimple()
  ..externalUrls = json['external_urls'] == null
      ? null
      : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

Map<String, dynamic> _$ArtistSimpleToJson(ArtistSimple instance) =>
    <String, dynamic>{
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'uri': instance.uri,
    };

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

Map<String, dynamic> _$AudioAnalysisToJson(AudioAnalysis instance) =>
    <String, dynamic>{
      'track': instance.track?.toJson(),
      'bars': instance.bars?.map((e) => e.toJson()).toList(),
      'beats': instance.beats?.map((e) => e.toJson()).toList(),
      'sections': instance.sections?.map((e) => e.toJson()).toList(),
      'segments': instance.segments?.map((e) => e.toJson()).toList(),
      'tatums': instance.tatums?.map((e) => e.toJson()).toList(),
    };

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

Map<String, dynamic> _$TrackAudioAnalysisToJson(TrackAudioAnalysis instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'confidence': instance.confidence,
      'loudness': instance.loudness,
      'tempo': instance.tempo,
      'tempo_confidence': instance.tempoConfidence,
      'key': instance.key,
      'key_confidence': instance.keyConfidence,
      'mode': instance.mode,
      'mode_confidence': instance.modeConfidence,
      'time_signature': instance.timeSignature,
      'time_signature_confidence': instance.timeSignatureConfidence,
      'num_samples': instance.numSamples,
      'analysis_sample_rate': instance.analysisSampleRate,
      'analysis_channels': instance.analysisChannels,
      'end_of_fade_in': instance.endOfFadeIn,
      'start_of_fade_out': instance.startOfFadeOut,
      'synchstring': instance.synchString,
      'synch_version': instance.synchVersion,
      'rhythmstring': instance.rhythmString,
      'rhythm_version': instance.rhythmVersion,
      'codestring': instance.codeString,
      'code_version': instance.codeVersion,
    };

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

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'duration': instance.duration,
      'confidence': instance.confidence,
      'loudness': instance.loudness,
      'tempo': instance.tempo,
      'tempo_confidence': instance.tempoConfidence,
      'key': instance.key,
      'key_confidence': instance.keyConfidence,
      'mode': instance.mode,
      'mode_confidence': instance.modeConfidence,
      'time_signature': instance.timeSignature,
      'time_signature_confidence': instance.timeSignatureConfidence,
      'start': instance.start,
    };

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

Map<String, dynamic> _$SegmentToJson(Segment instance) => <String, dynamic>{
      'start': instance.start,
      'duration': instance.duration,
      'confidence': instance.confidence,
      'loudness_start': instance.loudnessStart,
      'loudness_max': instance.loudnessMax,
      'loudness_max_time': instance.loudnessMaxTime,
      'loudness_end': instance.loudnessEnd,
      'pitches': instance.pitches,
      'timbre': instance.timbre,
    };

TimeInterval _$TimeIntervalFromJson(Map<String, dynamic> json) => TimeInterval()
  ..confidence = (json['confidence'] as num?)?.toDouble()
  ..duration = (json['duration'] as num?)?.toDouble()
  ..start = (json['start'] as num?)?.toDouble();

Map<String, dynamic> _$TimeIntervalToJson(TimeInterval instance) =>
    <String, dynamic>{
      'confidence': instance.confidence,
      'duration': instance.duration,
      'start': instance.start,
    };

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

Category _$CategoryFromJson(Map<String, dynamic> json) => Category()
  ..href = json['href'] as String?
  ..icons = (json['icons'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..id = json['id'] as String?
  ..name = json['name'] as String?;

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'href': instance.href,
      'icons': instance.icons?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'name': instance.name,
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
  ..type = $enumDecodeNullable(_$DeviceTypeEnumMap, json['type'],
      unknownValue: DeviceType.Unknown)
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

Map<String, dynamic> _$SpotifyErrorToJson(SpotifyError instance) =>
    <String, dynamic>{
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

CursorPaging<T> _$CursorPagingFromJson<T>(Map<String, dynamic> json) =>
    CursorPaging<T>()
      ..href = json['href'] as String?
      ..itemsNative = itemsNativeFromJson(json['items'] as List)
      ..limit = convertToIntIfDoubleValueWithoutNull(json['limit'])
      ..next = json['next'] as String?
      ..cursors = json['cursors'] == null
          ? null
          : Cursor.fromJson(json['cursors'] as Map<String, dynamic>);

Map<String, dynamic> _$CursorPagingToJson<T>(CursorPaging<T> instance) =>
    <String, dynamic>{
      'href': instance.href,
      'items': itemsNativeToJson(instance.itemsNative),
      'limit': instance.limit,
      'next': instance.next,
      'cursors': instance.cursors?.toJson(),
    };

Cursor _$CursorFromJson(Map<String, dynamic> json) =>
    Cursor()..after = json['after'] as String?;

Map<String, dynamic> _$CursorToJson(Cursor instance) => <String, dynamic>{
      'after': instance.after,
    };

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

Map<String, dynamic> _$PlaybackStateToJson(PlaybackState instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'context': instance.context?.toJson(),
      'progress_ms': instance.progressMs,
      'item': instance.item?.toJson(),
      'currently_playing_type':
          _$CurrentlyPlayingTypeEnumMap[instance.currentlyPlayingType],
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

PlayerContext _$PlayerContextFromJson(Map<String, dynamic> json) =>
    PlayerContext()
      ..externalUrls = json['external_urls'] == null
          ? null
          : ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
      ..href = json['href'] as String?
      ..type = json['type'] as String?
      ..uri = json['uri'] as String?;

Map<String, dynamic> _$PlayerContextToJson(PlayerContext instance) =>
    <String, dynamic>{
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
      'tracks': instance.tracks?.toJson(),
      'type': instance.type,
      'uri': instance.uri,
    };

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

Map<String, dynamic> _$PlaylistSimpleToJson(PlaylistSimple instance) =>
    <String, dynamic>{
      'collaborative': instance.collaborative,
      'description': instance.description,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'owner': instance.owner?.toJson(),
      'public': instance.public,
      'snapshot_id': instance.snapshotId,
      'tracks': instance.tracksLink?.toJson(),
      'type': instance.type,
      'uri': instance.uri,
    };

PlaylistsFeatured _$PlaylistsFeaturedFromJson(Map<String, dynamic> json) =>
    PlaylistsFeatured()..message = json['message'] as String?;

Map<String, dynamic> _$PlaylistsFeaturedToJson(PlaylistsFeatured instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

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

Map<String, dynamic> _$PlaylistTrackToJson(PlaylistTrack instance) =>
    <String, dynamic>{
      'added_at': instance.addedAt?.toIso8601String(),
      'added_by': instance.addedBy?.toJson(),
      'is_local': instance.isLocal,
      'track': instance.track?.toJson(),
    };

Recommendations _$RecommendationsFromJson(Map<String, dynamic> json) =>
    Recommendations()
      ..seeds = (json['seeds'] as List<dynamic>?)
          ?.map((e) => RecommendationsSeed.fromJson(e as Map<String, dynamic>))
          .toList()
      ..tracks = (json['tracks'] as List<dynamic>?)
          ?.map((e) => TrackSimple.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$RecommendationsToJson(Recommendations instance) =>
    <String, dynamic>{
      'seeds': instance.seeds?.map((e) => e.toJson()).toList(),
      'tracks': instance.tracks?.map((e) => e.toJson()).toList(),
    };

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

Map<String, dynamic> _$ShowToJson(Show instance) => <String, dynamic>{
      'available_markets':
          instance.availableMarkets?.map((e) => _$MarketEnumMap[e]!).toList(),
      'copyrights': instance.copyrights?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'explicit': instance.explicit,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'is_externally_hosted': instance.isExternallyHosted,
      'languages': instance.languages,
      'media_type': instance.mediaType,
      'name': instance.name,
      'publisher': instance.publisher,
      'type': instance.type,
      'uri': instance.uri,
      'total_episodes': instance.totalEpisodes,
    };

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

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'audio_preview_url': instance.audioPreviewUrl,
      'description': instance.description,
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
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

Map<String, dynamic> _$EpisodeFullToJson(EpisodeFull instance) =>
    <String, dynamic>{
      'audio_preview_url': instance.audioPreviewUrl,
      'description': instance.description,
      'duration_ms': instance.durationMs,
      'explicit': instance.explicit,
      'external_urls': instance.externalUrls?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'is_externally_hosted': instance.isExternallyHosted,
      'is_playable': instance.isPlayable,
      'language': instance.language,
      'languages': instance.languages,
      'name': instance.name,
      'release_date': instance.releaseDate?.toIso8601String(),
      'release_date_precision': instance.releaseDatePrecision,
      'type': instance.type,
      'uri': instance.uri,
      'show': instance.show?.toJson(),
    };

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

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'album': instance.album?.toJson(),
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'available_markets':
          instance.availableMarkets?.map((e) => _$MarketEnumMap[e]!).toList(),
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

Map<String, dynamic> _$TrackSimpleToJson(TrackSimple instance) =>
    <String, dynamic>{
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'available_markets':
          instance.availableMarkets?.map((e) => _$MarketEnumMap[e]!).toList(),
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

TrackSaved _$TrackSavedFromJson(Map<String, dynamic> json) => TrackSaved()
  ..addedAt = json['added_at'] == null
      ? null
      : DateTime.parse(json['added_at'] as String)
  ..track = json['track'] == null
      ? null
      : Track.fromJson(json['track'] as Map<String, dynamic>);

Map<String, dynamic> _$TrackSavedToJson(TrackSaved instance) =>
    <String, dynamic>{
      'added_at': instance.addedAt?.toIso8601String(),
      'track': instance.track?.toJson(),
    };

TrackLink _$TrackLinkFromJson(Map<String, dynamic> json) => TrackLink()
  ..externalUrls = (json['external_urls'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  )
  ..href = json['href'] as String?
  ..id = json['id'] as String?
  ..type = json['type'] as String?
  ..uri = json['uri'] as String?;

Map<String, dynamic> _$TrackLinkToJson(TrackLink instance) => <String, dynamic>{
      'external_urls': instance.externalUrls,
      'href': instance.href,
      'id': instance.id,
      'type': instance.type,
      'uri': instance.uri,
    };

TracksLink _$TracksLinkFromJson(Map<String, dynamic> json) => TracksLink()
  ..href = json['href'] as String?
  ..total = convertToIntIfDoubleValue(json['total']);

Map<String, dynamic> _$TracksLinkToJson(TracksLink instance) =>
    <String, dynamic>{
      'href': instance.href,
      'total': instance.total,
    };

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

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'birthdate': instance.birthdate,
      'country': _$MarketEnumMap[instance.country],
      'display_name': instance.displayName,
      'email': instance.email,
      'followers': instance.followers?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'product': instance.product,
      'type': instance.type,
      'uri': instance.uri,
    };

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

Map<String, dynamic> _$UserPublicToJson(UserPublic instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'followers': instance.followers?.toJson(),
      'href': instance.href,
      'id': instance.id,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'type': instance.type,
      'uri': instance.uri,
    };

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

Map<String, dynamic> _$PlayHistoryToJson(PlayHistory instance) =>
    <String, dynamic>{
      'track': instance.track?.toJson(),
      'played_at': instance.playedAt?.toIso8601String(),
      'context': instance.context?.toJson(),
    };

Queue _$QueueFromJson(Map<String, dynamic> json) => Queue()
  ..currentlyPlaying = json['currently_playing'] == null
      ? null
      : Track.fromJson(json['currently_playing'] as Map<String, dynamic>)
  ..queue = (json['queue'] as List<dynamic>?)
      ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$QueueToJson(Queue instance) => <String, dynamic>{
      'currently_playing': instance.currentlyPlaying?.toJson(),
      'queue': instance.queue?.map((e) => e.toJson()).toList(),
    };
