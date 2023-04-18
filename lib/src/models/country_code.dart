// Copyright (c) 2019-2021, Denis Portnov. All rights reserved.
// Released under MIT License

// MIT License
// Copyright (c) 2019 Denis Portnov <denixport@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// Code taken from https://github.com/denixport/dart.country
// Using this class in order to prevent another library dependency

part of spotify.models;

/// Class that represents an `ISO 3166-1` assigned country code
class CountryCode {
  // 'A' - 1
  static const _baseChar = 0x41 - 1;

  // code units buffer for alpha codes
  static final _a2cu = <int>[0, 0];
  static final _a3cu = <int>[0, 0, 0];

  // Country alphanumeric codes are packed into 35-bit unsigned integer
  // [0-9] Alpha-2 code, 5 bits per character
  // [10-24] Alpha-3 code, 5 bits per character
  // [25-35] int representing numeric code 0-999
  final int _code;

  const CountryCode._(this._code);

  /// Creates user-defined country code.
  /// Note: Code is not registered in class `values`, use `assign` to
  /// register user country codes.
  factory CountryCode.user({String? alpha2, String? alpha3, int? numeric}) {
    assert(!(alpha2 == null && alpha3 == null && numeric == null));
    assert(alpha2 == null || alpha2.length >= 2);
    assert(alpha3 == null || alpha3.length >= 3);

    var a2 = 0;
    if (alpha2 != null) {
      a2 = _packAlpha2(alpha2.codeUnits);
      if (!_isInRange(a2, _userA2Ranges)) {
        throw ArgumentError('Alpha-2 code is not in allowed range');
      }
    }

    var a3 = 0;
    if (alpha3 != null) {
      a3 = _packAlpha3(alpha3.codeUnits);
      if (!_isInRange(a3, _userA3Ranges)) {
        throw ArgumentError('Alpha-3 code is not in allowed range');
      }
    }

    if (numeric != null && (numeric < 900 || numeric > 999)) {
      throw ArgumentError.value(
          numeric, 'numeric', 'Should be between 900..999');
    }

    numeric ??= 0;

    if ((1 << 32) == 0) {
      return CountryCode._(a2 + (a3 | numeric));
    }

    return CountryCode._(a2 | a3 | numeric);
  }

  /// Alpha-2 code as defined in (ISO 3166-1)[https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2]
  /// Returns empty string for user-assigned values that doesn't have alpha-2 code
  String get alpha2 {
    _unpackAlpha2(_code);
    return (_a2cu[0] != _baseChar) ? String.fromCharCodes(_a2cu) : '';
  }

  /// Alpha-3 code as defined in (ISO 3166-1)[https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3]
  /// Returns empty string for user-assigned values that doesn't have alpha-3 code
  String get alpha3 {
    _unpackAlpha3(_code);
    return (_a3cu[0] != _baseChar) ? String.fromCharCodes(_a3cu) : '';
  }

  /// Numeric code as defined in (ISO 3166-1)[https://en.wikipedia.org/wiki/ISO_3166-1_numeric]
  /// Returns 0 for user-assigned values that doesn't have alpha-3 code
  int get numeric {
    return _code & 0x3ff;
  }

  /// Returns unicode symbol for country code
  String get symbol {
    const base = 0x1f1a5;
    if (_code & 0x3ff != 0) {
      _unpackAlpha2(_code);
      return String.fromCharCodes(<int>[base + _a2cu[0], base + _a2cu[1]]);
    }
    return '';
  }

  /// Returns `true` if the code is official ISO-assigned
  bool get isOfficial {
    var n = _code & 0x3ff;
    return n > 0 && n < 900;
  }

  /// Returns `true` if the code is user-assigned.
  /// See (User-assigned code elements)[https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#User-assigned_code_elements]
  bool get isUserAssigned {
    var n = _code & 0x3ff;
    return n == 0 || n >= 900;
  }

  /// Returns position of the value in list of all country codes.
  int get index => values.indexOf(this);

  @override
  int get hashCode => _code;

  @override
  bool operator ==(Object other) =>
      other is CountryCode && _code == other._code;

  /// Returns string representation of `CountryCode`.
  /// Which is `CountryCode.` followed by either alpha-2, alpha-2, or numeric code
  /// depeding on which code is defined.
  /// For ISO-assigned country codes it alwais returns `CountryCode.` + alpha-2.
  @override
  String toString() {
    // 'Country'.codeUnits + 3
    const cu = <int>[67, 111, 117, 110, 116, 114, 121, 67, 111, 100, 101, 46];

    _unpackAlpha2(_code);
    if (_a2cu[0] != _baseChar) {
      return String.fromCharCodes(cu + _a2cu);
    }

    _unpackAlpha3(_code);
    if (_a3cu[0] != _baseChar) {
      return String.fromCharCodes(cu + _a3cu);
    }

    var n = _code & 0x3ff;
    if (n != 0) {
      return String.fromCharCodes(cu + n.toString().padLeft(3, '0').codeUnits);
    }

    assert(true, 'Unreachable return');
    return 'Country.UNKNOWN';
  }

  /// List of all ISO-assigned country codes
  static List<CountryCode> get values {
    if (_userValues.isNotEmpty) {
      return List<CountryCode>.unmodifiable(_values + _userValues);
    }

    return List<CountryCode>.unmodifiable(_values);
  }

  /// List of all user-assigned country codes
  static List<CountryCode> get userValues => List.unmodifiable(_userValues);

  /// Returns country by Alpha-2 or Alpha-3 code
  /// Throws `ArgumentError` if the [code] is invalid or there is no
  /// ISO- or user-assigned country for this [code]
  static CountryCode ofAlpha(String code) {
    int index;

    if (_userValues.isNotEmpty) {
      index = _parseAlpha(code, _userValues);
      if (index != -1) {
        return _userValues[index];
      }
    }

    index = _parseAlpha(code, _values);
    if (index != -1) {
      return _values[index];
    }

    throw ArgumentError('Alpha code \"$code\" is not assigned');
  }

  /// Returns country code by numeric code
  /// Throws `ArgumentError` if the numeric [code] is invalid or there is no
  /// ISO- or user-assigned country for this [code]
  static CountryCode ofNumeric(int code) {
    int index;
    if (_userValues.isNotEmpty) {
      index = _indexOfNum(code, _userValues);
      if (index != -1) {
        return _userValues[index];
      }
    }

    index = _indexOfNum(code, _values);
    if (index != -1) {
      return _values[index];
    }

    throw ArgumentError('No country assigned for numeric code \"$code\"');
  }

  // returns index of numeric code in values list
  static int _indexOfNum(int code, List<CountryCode> values) {
    for (var i = 0; i < values.length; i++) {
      if (values[i]._code & 0x3ff == code) {
        return i;
      }
    }
    return -1;
  }

  /// Parses [source] as Alpha-2, alpha-3 or numeric country code
  /// The [source] must be either 2-3 ASCII uppercase letters of alpha code,
  /// or 2-3 digits of numeric code
  /// Throws `FormatException` if the code is not valid country code
  static CountryCode parse(String source) {
    var c = _parse(source);
    if (c == null) {
      throw FormatException('Invalid or non-assigned code', source);
    }
    return c;
  }

  /// Parses [source] as Alpha-2, alpha-3 or numeric country code.
  /// Same as [parse] but returns `null` in case of invalid country code
  static CountryCode? tryParse(String source) {
    return _parse(source);
  }

  //
  static CountryCode? _parse(String code) {
    int index;

    // first try user-assigned alpha code
    if (_userValues.isNotEmpty) {
      index = _parseAlpha(code, _userValues);
      if (index != -1) {
        return _userValues[index];
      }
    }

    // try ISO alpha code
    index = _parseAlpha(code, _values);
    if (index != -1) {
      return _values[index];
    }

    // try user numeric code
    if (_userValues.isNotEmpty) {
      index = _parseNum(code, _userValues);
      if (index != -1) {
        return _userValues[index];
      }
    }

    // try ISO numeric code
    index = _parseNum(code, _values);
    if (index != -1) {
      return _values[index];
    }

    return null;
  }

  // Parses alpha-2 or alpha-3 code, returns -1 for invalid or unassigned
  static int _parseAlpha(String code, List<CountryCode> values) {
    var cu = code.codeUnits;
    switch (cu.length) {
      case 2:
        for (var i = 0; i < values.length; i++) {
          _unpackAlpha2(values[i]._code);
          if (_a2cu[0] == cu[0] && _a2cu[1] == cu[1]) {
            return i;
          }
        }
        break;
      case 3:
        for (var i = 0; i < values.length; i++) {
          _unpackAlpha3(values[i]._code);
          if (_a3cu[0] == cu[0] && _a3cu[1] == cu[1] && _a3cu[2] == cu[2]) {
            return i;
          }
        }
        break;
    }
    return -1;
  }

  // Parses numeric code, returns -1 for invalid or unassigned
  static int _parseNum(String code, List<CountryCode> values) {
    var n = int.tryParse(code);
    if (n == null) {
      return -1;
    }
    for (var i = 0; i < values.length; i++) {
      if (values[i]._code & 0x3ff == n) {
        return i;
      }
    }
    return -1;
  }

  /// Assigns user-defined codes. Returns index of country value in [userValues]
  /// Codes could be any combination of Alpha-2, alpha-2, or numeric code.
  /// Either one of 3 codes is required.
  /// After calling [assign] user-assigned codes are available through
  /// [parse], [tryParse], [ofAlpha], and [ofNumeric] static methods.
  static int assign({String? alpha2, String? alpha3, int? numeric}) {
    assert(!(alpha2 == null && alpha3 == null && numeric == null));

    // check Alpha-2
    if (alpha2 != null &&
        (_parseAlpha(alpha2, _userValues) != -1 ||
            _parseAlpha(alpha2, _values) != -1)) {
      throw StateError('Alpha-2 code \"$alpha2\" is already assigned');
    }

    // check Alpha-3
    if (alpha3 != null &&
        (_parseAlpha(alpha3, _userValues) != -1 ||
            _parseAlpha(alpha3, _values) != -1)) {
      throw StateError('Alpha-3 code \"$alpha3\" is already assigned');
    }

    // check numeric
    if (numeric != null &&
        (_indexOfNum(numeric, _userValues) != -1 ||
            _indexOfNum(numeric, _values) != -1)) {
      throw StateError('Numeric code \"$numeric\" is already assigned');
    }

    _userValues.add(
        CountryCode.user(alpha2: alpha2, alpha3: alpha3, numeric: numeric));

    return _values.length + _userValues.length - 1;
  }

  /// Removes all of user-assigned codes
  static void unassignAll() {
    _userValues.clear();
  }

  // pack/unpack rutines ------------------------------------------------------

  static int _packAlpha2(List<int> cu) {
    // hack to avoid 32-bit truncating in JS
    if ((1 << 32) != 0) {
      return (cu[0] - _baseChar) << 30 | (cu[1] - _baseChar) << 25;
    } else {
      return ((cu[0] - _baseChar) * 0x40000000) + ((cu[1] - _baseChar) << 25);
    }
  }

  // gets Alpha-2 code units from int
  static void _unpackAlpha2(int i) {
    // hack to avoid 32-bit truncating in JS
    if ((1 << 32) != 0) {
      _a2cu[0] = _baseChar + ((i >> 30));
    } else {
      _a2cu[0] = _baseChar + (i ~/ 0x40000000);
    }
    _a2cu[1] = _baseChar + ((i >> 25) & 0x1F);
  }

  static int _packAlpha3(List<int> cu) {
    return (cu[0] - _baseChar) << 20 |
        (cu[1] - _baseChar) << 15 |
        (cu[2] - _baseChar) << 10;
  }

  // gets Alpha-2 code units from int
  static void _unpackAlpha3(int i) {
    _a3cu[0] = _baseChar + ((i >> 20) & 0x1F);
    _a3cu[1] = _baseChar + ((i >> 15) & 0x1F);
    _a3cu[2] = _baseChar + ((i >> 10) & 0x1F);
  }

  static bool _isInRange(int code, List<int> ranges) {
    for (var i = 0; i < ranges.length - 1; i += 2) {
      if (code >= ranges[i] && code <= ranges[i + 1]) {
        return true;
      }
    }
    return false;
  }

  // ranges of user-assignable Alpha-2 codes
  static const _userA2Ranges = <int>[
    1107296256, 1107296256, // AA..AA //
    18689818624, 19126026240, // QM..QZ
    25803358208, 26642219008, // XA..XZ
    28789702656, 28789702656, // ZZ..ZZ
  ];

  // ranges of user-assignable Alpha-3 codes
  static const _userA3Ranges = <int>[
    1082368, 1107968, // AAA..AAZ //
    18252800, 18704384, // QMA..QZZ
    25199616, 26044416, // XAA..XZZ
    28115968, 28141568, // ZZA..ZZZ
  ];

  // User-assigned countries
  static final _userValues = <CountryCode>[];

  //GENERATED:START
  /// Andorra AD AND 20
  static const AD = CountryCode._(1209470996);

  /// United Arab Emirates AE ARE 784
  static const AE = CountryCode._(1243158288);

  /// Afghanistan AF AFG 4
  static const AF = CountryCode._(1276320772);

  /// Antigua and Barbuda AG ATG 28
  static const AG = CountryCode._(1310333980);

  /// Anguilla AI AIA 660
  static const AI = CountryCode._(1377076884);

  /// Albania AL ALB 8
  static const AL = CountryCode._(1477838856);

  /// Armenia AM ARM 51
  static const AM = CountryCode._(1511601203);

  /// Angola AO AGO 24
  static const AO = CountryCode._(1578351640);

  /// Antarctica AQ ATA 10
  static const AQ = CountryCode._(1645872138);

  /// Argentina AR ARG 32
  static const AR = CountryCode._(1679367200);

  /// American Samoa AS ASM 16
  static const AS = CountryCode._(1712960528);

  /// Austria AT AUT 40
  static const AT = CountryCode._(1746587688);

  /// Australia AU AUS 36
  static const AU = CountryCode._(1780141092);

  /// Aruba AW ABW 533
  static const AW = CountryCode._(1846631957);

  /// Åland Islands AX ALA 248
  static const AX = CountryCode._(1880491256);

  /// Azerbaijan AZ AZE 31
  static const AZ = CountryCode._(1948062751);

  /// Bosnia and Herzegovina BA BIH 70
  static const BA = CountryCode._(2183438406);

  /// Barbados BB BRB 52
  static const BB = CountryCode._(2217281588);

  /// Bangladesh BD BGD 50
  static const BD = CountryCode._(2284032050);

  /// Belgium BE BEL 56
  static const BE = CountryCode._(2317529144);

  /// Burkina Faso BF BFA 854
  static const BF = CountryCode._(2351105878);

  /// Bulgaria BG BGR 100
  static const BG = CountryCode._(2384709732);

  /// Bahrain BH BHR 48
  static const BH = CountryCode._(2418296880);

  /// Burundi BI BDI 108
  static const BI = CountryCode._(2451711084);

  /// Benin BJ BEN 204
  static const BJ = CountryCode._(2485303500);

  /// Saint Barthélemy BL BLM 652
  static const BL = CountryCode._(2552641164);

  /// Bermuda BM BMU 60
  static const BM = CountryCode._(2586235964);

  /// Brunei Darussalam BN BRN 96
  static const BN = CountryCode._(2619947104);

  /// Bolivia (Plurinational State of) BO BOL 68
  static const BO = CountryCode._(2653401156);

  /// Bonaire, Sint Eustatius and Saba BQ BES 535
  static const BQ = CountryCode._(2720189975);

  /// Brazil BR BRA 76
  static const BR = CountryCode._(2754151500);

  /// Bahamas BS BHS 44
  static const BS = CountryCode._(2787396652);

  /// Bhutan BT BTN 64
  static const BT = CountryCode._(2821339200);

  /// Bouvet Island BV BVT 74
  static const BV = CountryCode._(2888519754);

  /// Botswana BW BWA 72
  static const BW = CountryCode._(2922087496);

  /// Belarus BY BLR 112
  static const BY = CountryCode._(2988853360);

  /// Belize BZ BLZ 84
  static const BZ = CountryCode._(3022415956);

  /// Canada CA CAN 124
  static const CA = CountryCode._(3257972860);

  /// Cocos (Keeling) Islands CC CCK 166
  static const CC = CountryCode._(3325144230);

  /// Congo, Democratic Republic of the CD COD 180
  static const CD = CountryCode._(3359084724);

  /// Central African Republic CF CAF 140
  static const CF = CountryCode._(3425736844);

  /// Congo CG COG 178
  static const CG = CountryCode._(3459751090);

  /// Switzerland CH CHE 756
  static const CH = CountryCode._(3493074676);

  /// Côte d'Ivoire CI CIV 384
  static const CI = CountryCode._(3526678912);

  /// Cook Islands CK COK 184
  static const CK = CountryCode._(3593972920);

  /// Chile CL CHL 152
  static const CL = CountryCode._(3627298968);

  /// Cameroon CM CMR 120
  static const CM = CountryCode._(3661023352);

  /// China CN CHN 156
  static const CN = CountryCode._(3694409884);

  /// Colombia CO COL 170
  static const CO = CountryCode._(3728191658);

  /// Costa Rica CR CRI 188
  static const CR = CountryCode._(3828950204);

  /// Cuba CU CUB 192
  static const CU = CountryCode._(3929704640);

  /// Cabo Verde CV CPV 132
  static const CV = CountryCode._(3963115652);

  /// Curaçao CW CUW 531
  static const CW = CountryCode._(3996835347);

  /// Christmas Island CX CXR 162
  static const CX = CountryCode._(4030482594);

  /// Cyprus CY CYP 196
  static const CY = CountryCode._(4064067780);

  /// Czechia CZ CZE 203
  static const CZ = CountryCode._(4097643723);

  /// Germany DE DEU 276
  static const DE = CountryCode._(4467119380);

  /// Djibouti DJ DJI 262
  static const DJ = CountryCode._(4635043078);

  /// Denmark DK DNK 208
  static const DK = CountryCode._(4668730576);

  /// Dominica DM DMA 212
  static const DM = CountryCode._(4735796436);

  /// Dominican Republic DO DOM 214
  static const DO = CountryCode._(4802983126);

  /// Algeria DZ DZA 12
  static const DZ = CountryCode._(5172429836);

  /// Ecuador EC ECU 218
  static const EC = CountryCode._(5474735322);

  /// Estonia EE EST 233
  static const EE = CountryCode._(5542367465);

  /// Egypt EG EGY 818
  static const EG = CountryCode._(5609088818);

  /// Western Sahara EH ESH 732
  static const EH = CountryCode._(5643018972);

  /// Eritrea ER ERI 232
  static const ER = CountryCode._(5978531048);

  /// Spain ES ESP 724
  static const ES = CountryCode._(6012125908);

  /// Ethiopia ET ETH 231
  static const ET = CountryCode._(6045704423);

  /// Finland FI FIN 246
  static const FI = CountryCode._(6751041782);

  /// Fiji FJ FJI 242
  static const FJ = CountryCode._(6784623858);

  /// Falkland Islands (Malvinas) FK FLK 238
  static const FK = CountryCode._(6818245870);

  /// Micronesia (Federated States of) FM FSM 583
  static const FM = CountryCode._(6885586503);

  /// Faroe Islands FO FRO 234
  static const FO = CountryCode._(6952664298);

  /// France FR FRA 250
  static const FR = CountryCode._(7053313274);

  /// Gabon GA GAB 266
  static const GA = CountryCode._(7557122314);

  /// United Kingdom of Great Britain and Northern Ireland GB GBR 826
  static const GB = CountryCode._(7590726458);

  /// Grenada GD GRD 308
  static const GD = CountryCode._(7658344756);

  /// Georgia GE GEO 268
  static const GE = CountryCode._(7691484428);

  /// French Guiana GF GUF 254
  static const GF = CountryCode._(7725553918);

  /// Guernsey GG GGY 831
  static const GG = CountryCode._(7758669631);

  /// Ghana GH GHA 288
  static const GH = CountryCode._(7792231712);

  /// Gibraltar GI GIB 292
  static const GI = CountryCode._(7825819940);

  /// Greenland GL GRL 304
  static const GL = CountryCode._(7926788400);

  /// Gambia GM GMB 270
  static const GM = CountryCode._(7960168718);

  /// Guinea GN GIN 324
  static const GN = CountryCode._(7993604420);

  /// Guadeloupe GP GLP 312
  static const GP = CountryCode._(8060813624);

  /// Equatorial Guinea GQ GNQ 226
  static const GQ = CountryCode._(8094434530);

  /// Greece GR GRC 300
  static const GR = CountryCode._(8128105772);

  /// South Georgia and the South Sandwich Islands GS SGS 239
  static const GS = CountryCode._(8173898991);

  /// Guatemala GT GTM 320
  static const GT = CountryCode._(8195290432);

  /// Guam GU GUM 316
  static const GU = CountryCode._(8228877628);

  /// Guinea-Bissau GW GNB 624
  static const GW = CountryCode._(8295746160);

  /// Guyana GY GUY 328
  static const GY = CountryCode._(8363107656);

  /// Hong Kong HK HKG 344
  static const HK = CountryCode._(8967789912);

  /// Heard Island and McDonald Islands HM HMD 334
  static const HM = CountryCode._(9034961230);

  /// Honduras HN HND 340
  static const HN = CountryCode._(9068548436);

  /// Croatia HR HRV 191
  static const HR = CountryCode._(9202915519);

  /// Haiti HT HTI 332
  static const HT = CountryCode._(9270076748);

  /// Hungary HU HUN 348
  static const HU = CountryCode._(9303669084);

  /// Indonesia ID IDN 360
  static const ID = CountryCode._(9807477096);

  /// Ireland IE IRL 372
  static const IE = CountryCode._(9841488244);

  /// Israel IL ISR 376
  static const IL = CountryCode._(10076408184);

  /// Isle of Man IM IMN 833
  static const IM = CountryCode._(10109762369);

  /// India IN IND 356
  static const IN = CountryCode._(10143338852);

  /// British Indian Ocean Territory IO IOT 86
  static const IO = CountryCode._(10176942166);

  /// Iraq IQ IRQ 368
  static const IQ = CountryCode._(10244146544);

  /// Iran (Islamic Republic of) IR IRN 364
  static const IR = CountryCode._(10277697900);

  /// Iceland IS ISL 352
  static const IS = CountryCode._(10311283040);

  /// Italy IT ITA 380
  static const IT = CountryCode._(10344859004);

  /// Jersey JE JEY 832
  static const JE = CountryCode._(10915866432);

  /// Jamaica JM JAM 388
  static const JM = CountryCode._(11184158084);

  /// Jordan JO JOR 400
  static const JO = CountryCode._(11251730832);

  /// Japan JP JPN 392
  static const JP = CountryCode._(11285313928);

  /// Kenya KE KEN 404
  static const KE = CountryCode._(11990645140);

  /// Kyrgyzstan KG KGZ 417
  static const KG = CountryCode._(12057831841);

  /// Cambodia KH KHM 116
  static const KH = CountryCode._(12091405428);

  /// Kiribati KI KIR 296
  static const KI = CountryCode._(12124997928);

  /// Comoros KM COM 174
  static const KM = CountryCode._(12251018414);

  /// Saint Kitts and Nevis KN KNA 659
  static const KN = CountryCode._(12292916883);

  /// Korea (Democratic People's Republic of) KP PRK 408
  static const KP = CountryCode._(12365409688);

  /// Korea, Republic of KR KOR 410
  static const KR = CountryCode._(12427184538);

  /// Kuwait KW KWT 414
  static const KW = CountryCode._(12595220894);

  /// Cayman Islands KY CYM 136
  static const KY = CountryCode._(12653999240);

  /// Kazakhstan KZ KAZ 398
  static const KZ = CountryCode._(12695169422);

  /// Lao People's Democratic Republic LA LAO 418
  static const LA = CountryCode._(12931087778);

  /// Lebanon LB LBN 422
  static const LB = CountryCode._(12964673958);

  /// Saint Lucia LC LCA 662
  static const LC = CountryCode._(12998248086);

  /// Liechtenstein LI LIE 438
  static const LI = CountryCode._(13199775158);

  /// Sri Lanka LK LKA 144
  static const LK = CountryCode._(13266945168);

  /// Liberia LR LBR 430
  static const LR = CountryCode._(13501548974);

  /// Lesotho LS LSO 426
  static const LS = CountryCode._(13535657386);

  /// Lithuania LT LTU 440
  static const LT = CountryCode._(13569250744);

  /// Luxembourg LU LUX 442
  static const LU = CountryCode._(13602841018);

  /// Latvia LV LVA 428
  static const LV = CountryCode._(13636404652);

  /// Libya LY LBY 434
  static const LY = CountryCode._(13736437170);

  /// Morocco MA MAR 504
  static const MA = CountryCode._(14005881336);

  /// Monaco MC MCO 492
  static const MC = CountryCode._(14073052652);

  /// Moldova, Republic of MD MDA 498
  static const MD = CountryCode._(14106625522);

  /// Montenegro ME MNE 499
  static const ME = CountryCode._(14140511731);

  /// Saint Martin (French part) MF MAF 663
  static const MF = CountryCode._(14173641367);

  /// Madagascar MG MDG 450
  static const MG = CountryCode._(14207294914);

  /// Marshall Islands MH MHL 584
  static const MH = CountryCode._(14240985672);

  /// North Macedonia MK MKD 807
  static const MK = CountryCode._(14341739303);

  /// Mali ML MLI 466
  static const ML = CountryCode._(14375331282);

  /// Myanmar MM MMR 104
  static const MM = CountryCode._(14408927336);

  /// Mongolia MN MNG 496
  static const MN = CountryCode._(14442503664);

  /// Macao MO MAC 446
  static const MO = CountryCode._(14475627966);

  /// Northern Mariana Islands MP MNP 580
  static const MP = CountryCode._(14509621828);

  /// Martinique MQ MTQ 474
  static const MQ = CountryCode._(14543373786);

  /// Mauritania MR MRT 478
  static const MR = CountryCode._(14576865758);

  /// Montserrat MS MSR 500
  static const MS = CountryCode._(14610450932);

  /// Malta MT MLT 470
  static const MT = CountryCode._(14643778006);

  /// Mauritius MU MUS 480
  static const MU = CountryCode._(14677626336);

  /// Maldives MV MDV 462
  static const MV = CountryCode._(14710626766);

  /// Malawi MW MWI 454
  static const MW = CountryCode._(14744790470);

  /// Mexico MX MEX 484
  static const MX = CountryCode._(14777770468);

  /// Malaysia MY MYS 458
  static const MY = CountryCode._(14811975114);

  /// Mozambique MZ MOZ 508
  static const MZ = CountryCode._(14845209084);

  /// Namibia NA NAM 516
  static const NA = CountryCode._(15080666628);

  /// New Caledonia NC NCL 540
  static const NC = CountryCode._(15147840028);

  /// Niger NE NER 562
  static const NE = CountryCode._(15215020594);

  /// Norfolk Island NF NFK 574
  static const NF = CountryCode._(15248600638);

  /// Nigeria NG NGA 566
  static const NG = CountryCode._(15282177590);

  /// Nicaragua NI NIC 558
  static const NI = CountryCode._(15349354030);

  /// Netherlands NL NLD 528
  static const NL = CountryCode._(15450116624);

  /// Norway NO NOR 578
  static const NO = CountryCode._(15550892610);

  /// Nepal NP NPL 524
  static const NP = CountryCode._(15584473612);

  /// Nauru NR NRU 520
  static const NR = CountryCode._(15651657224);

  /// Niue NU NIU 570
  static const NU = CountryCode._(15752025658);

  /// New Zealand NZ NZL 554
  static const NZ = CountryCode._(15920345642);

  /// Oman OM OMN 512
  static const OM = CountryCode._(16558504448);

  /// Panama PA PAN 591
  static const PA = CountryCode._(17230248527);

  /// Peru PE PER 604
  static const PE = CountryCode._(17364601436);

  /// French Polynesia PF PYF 258
  static const PF = CountryCode._(17398798594);

  /// Papua New Guinea PG PNG 598
  static const PG = CountryCode._(17431993942);

  /// Philippines PH PHL 608
  static const PH = CountryCode._(17465356896);

  /// Pakistan PK PAK 586
  static const PK = CountryCode._(17565789770);

  /// Poland PL POL 616
  static const PL = CountryCode._(17599804008);

  /// Saint Pierre and Miquelon PM SPM 666
  static const PM = CountryCode._(17636538010);

  /// Pitcairn PN PCN 612
  static const PN = CountryCode._(17666521700);

  /// Puerto Rico PR PRI 630
  static const PR = CountryCode._(17801225846);

  /// Palestine, State of PS PSE 275
  static const PS = CountryCode._(17834808595);

  /// Portugal PT PRT 620
  static const PT = CountryCode._(17868345964);

  /// Palau PW PLW 585
  static const PW = CountryCode._(17968815689);

  /// Paraguay PY PRY 600
  static const PY = CountryCode._(18036123224);

  /// Qatar QA QAT 634
  static const QA = CountryCode._(18305045114);

  /// Réunion RE REU 638
  static const RE = CountryCode._(19514185342);

  /// Romania RO ROU 642
  static const RO = CountryCode._(19850057346);

  /// Serbia RS SRB 688
  static const RS = CountryCode._(19985402544);

  /// Russian Federation RU RUS 643
  static const RU = CountryCode._(20051578499);

  /// Rwanda RW RWA 646
  static const RW = CountryCode._(20118734470);

  /// Saudi Arabia SA SAU 682
  static const SA = CountryCode._(20454626986);

  /// Solomon Islands SB SLB 90
  static const SB = CountryCode._(20488521818);

  /// Seychelles SC SYC 690
  static const SC = CountryCode._(20522503858);

  /// Sudan SD SDN 729
  static const SD = CountryCode._(20555381465);

  /// Sweden SE SWE 752
  static const SE = CountryCode._(20589549296);

  /// Singapore SG SGP 702
  static const SG = CountryCode._(20656145086);

  /// Saint Helena, Ascension and Tristan da Cunha SH SHN 654
  static const SH = CountryCode._(20689730190);

  /// Slovenia SI SVN 705
  static const SI = CountryCode._(20723743425);

  /// Svalbard and Jan Mayen SJ SJM 744
  static const SJ = CountryCode._(20756903656);

  /// Slovakia SK SVK 703
  static const SK = CountryCode._(20790849215);

  /// Sierra Leone SL SLE 694
  static const SL = CountryCode._(20824069814);

  /// San Marino SM SMR 674
  static const SM = CountryCode._(20857670306);

  /// Senegal SN SEN 686
  static const SN = CountryCode._(20890958510);

  /// Somalia SO SOM 706
  static const SO = CountryCode._(20924839618);

  /// Suriname SR SUR 740
  static const SR = CountryCode._(21025704676);

  /// South Sudan SS SSD 728
  static const SS = CountryCode._(21059179224);

  /// Sao Tome and Principe ST STP 678
  static const ST = CountryCode._(21092778662);

  /// El Salvador SV SLV 222
  static const SV = CountryCode._(21159631070);

  /// Sint Maarten (Dutch part) SX SXM 534
  static const SX = CountryCode._(21227124246);

  /// Syrian Arab Republic SY SYR 760
  static const SY = CountryCode._(21260716792);

  /// Eswatini SZ SWZ 748
  static const SZ = CountryCode._(21294213868);

  /// Turks and Caicos Islands TC TCA 796
  static const TC = CountryCode._(21596571420);

  /// Chad TD TCD 148
  static const TD = CountryCode._(21630128276);

  /// French Southern Territories TF ATF 260
  static const TF = CountryCode._(21677873412);

  /// Togo TG TGO 768
  static const TG = CountryCode._(21730934528);

  /// Thailand TH THA 764
  static const TH = CountryCode._(21764507388);

  /// Tajikistan TJ TJK 762
  static const TJ = CountryCode._(21831692026);

  /// Tokelau TK TKL 772
  static const TK = CountryCode._(21865280260);

  /// Timor-Leste TL TLS 626
  static const TL = CountryCode._(21898874482);

  /// Turkmenistan TM TKM 795
  static const TM = CountryCode._(21932390171);

  /// Tunisia TN TUN 788
  static const TN = CountryCode._(21966273300);

  /// Tonga TO TON 776
  static const TO = CountryCode._(21999631112);

  /// Turkey TR TUR 792
  static const TR = CountryCode._(22100495128);

  /// Trinidad and Tobago TT TTO 780
  static const TT = CountryCode._(22167568140);

  /// Tuvalu TV TUV 798
  static const TV = CountryCode._(22234716958);

  /// Taiwan, Province of China TW TWN 158
  static const TW = CountryCode._(22268328094);

  /// Tanzania, United Republic of TZ TZA 834
  static const TZ = CountryCode._(22369077058);

  /// Ukraine UA UKR 804
  static const UA = CountryCode._(22604532516);

  /// Uganda UG UGA 800
  static const UG = CountryCode._(22805710624);

  /// United States Minor Outlying Islands UM UMI 581
  static const UM = CountryCode._(23007241797);

  /// United States of America US USA 840
  static const US = CountryCode._(23208757064);

  /// Uruguay UY URY 858
  static const UY = CountryCode._(23410075482);

  /// Uzbekistan UZ UZB 860
  static const UZ = CountryCode._(23443868508);

  /// Holy See VA VAT 336
  static const VA = CountryCode._(23678996816);

  /// Saint Vincent and the Grenadines VC VCT 670
  static const VC = CountryCode._(23746171550);

  /// Venezuela (Bolivarian Republic of) VE VEN 862
  static const VE = CountryCode._(23813339998);

  /// Virgin Islands (British) VG VGB 92
  static const VG = CountryCode._(23880501340);

  /// Virgin Islands (U.S.) VI VIR 850
  static const VI = CountryCode._(23947692882);

  /// Viet Nam VN VNM 704
  static const VN = CountryCode._(24115623616);

  /// Vanuatu VU VUT 548
  static const VU = CountryCode._(24350741028);

  /// Wallis and Futuna WF WLF 876
  static const WF = CountryCode._(24921906028);

  /// Samoa WS WSM 882
  static const WS = CountryCode._(25358350194);

  /// Yemen YE YEM 887
  static const YE = CountryCode._(27037710199);

  /// Mayotte YT MYT 175
  static const YT = CountryCode._(27529105583);

  /// South Africa ZA ZAF 710
  static const ZA = CountryCode._(27978144454);

  /// Zambia ZM ZMB 894
  static const ZM = CountryCode._(28381186942);

  /// Zimbabwe ZW ZWE 716
  static const ZW = CountryCode._(28717061836);

  // List of ISO standard values
  static const _values = <CountryCode>[
    AD, AE, AF, AG, AI, AL, AM, AO, AQ, AR, AS, AT, AU, AW, AX, AZ, BA, BB, //
    BD, BE, BF, BG, BH, BI, BJ, BL, BM, BN, BO, BQ, BR, BS, BT, BV, BW, BY,
    BZ, CA, CC, CD, CF, CG, CH, CI, CK, CL, CM, CN, CO, CR, CU, CV, CW, CX,
    CY, CZ, DE, DJ, DK, DM, DO, DZ, EC, EE, EG, EH, ER, ES, ET, FI, FJ, FK,
    FM, FO, FR, GA, GB, GD, GE, GF, GG, GH, GI, GL, GM, GN, GP, GQ, GR, GS,
    GT, GU, GW, GY, HK, HM, HN, HR, HT, HU, ID, IE, IL, IM, IN, IO, IQ, IR,
    IS, IT, JE, JM, JO, JP, KE, KG, KH, KI, KM, KN, KP, KR, KW, KY, KZ, LA,
    LB, LC, LI, LK, LR, LS, LT, LU, LV, LY, MA, MC, MD, ME, MF, MG, MH, MK,
    ML, MM, MN, MO, MP, MQ, MR, MS, MT, MU, MV, MW, MX, MY, MZ, NA, NC, NE,
    NF, NG, NI, NL, NO, NP, NR, NU, NZ, OM, PA, PE, PF, PG, PH, PK, PL, PM,
    PN, PR, PS, PT, PW, PY, QA, RE, RO, RS, RU, RW, SA, SB, SC, SD, SE, SG,
    SH, SI, SJ, SK, SL, SM, SN, SO, SR, SS, ST, SV, SX, SY, SZ, TC, TD, TF,
    TG, TH, TJ, TK, TL, TM, TN, TO, TR, TT, TV, TW, TZ, UA, UG, UM, US, UY,
    UZ, VA, VC, VE, VG, VI, VN, VU, WF, WS, YE, YT, ZA, ZM, ZW,
  ];
  //GENERATED:END
}
