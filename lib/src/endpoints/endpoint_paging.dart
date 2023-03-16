// Copyright (c) 2017, 2018, hayribakici, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

/// Base class of all endpoints using pagination
abstract class EndpointPaging extends EndpointBase {
  EndpointPaging(SpotifyApiBase api) : super(api);

  Pages<T> _getPages<T>(String path, ParserFunction<T> pageItemParser,
          [String? pageKey, ParserFunction<Object>? pageContainerParser]) =>
      Pages(_api, path, pageItemParser, pageKey, pageContainerParser);

  CursorPages<T> _getCursorPages<T>(
          String path, ParserFunction<T> pageItemParser,
          [String? pageKey, ParserFunction<Object>? pageContainerParser]) =>
      CursorPages(_api, path, pageItemParser, pageKey, pageContainerParser);

  BundledPages _getBundledPages<T>(
          String path, Map<String, ParserFunction<T>> pageItemParsers,
          [String? pageKey, ParserFunction<Object>? pageContainerParser]) =>
      BundledPages(_api, path, pageItemParsers, pageKey, pageContainerParser);
}

const defaultLimit = 20;

/// Base class that represents a generic response page.
abstract class BasePage<T> {
  final BasePaging<T> _paging;
  Iterable<T>? _items;
  Object? _container;

  BasePage(this._paging, ParserFunction<T> pageItemParser,
      [Object? pageContainer]) {
    _items = _paging.itemsNative!.map(pageItemParser);
    _container = pageContainer;
  }

  /// The offset-based paging object is a container for a set of objects. It
  /// contains a key called items (whose value is an array of the requested
  /// objects) along with other keys like previous, next and limit that can be
  /// useful in future calls.
  Paging<T> get metadata => _paging as Paging<T>;

  /// The requested data
  Iterable<T>? get items => _items;

  /// [true] if this page is the last page. [false] otherwise.
  bool get isLast;

  /// Generic next for multiple purposes for internal use only.
  /// It is not defined what data type it should have.
  /// Subclasses should return specific type and
  /// wrap another attribute with specific data type (e.g. [int]) around
  /// it. For example: `int get foo => _next as int`.
  ///
  /// Needs to be overridden by subclasses.
  dynamic get _next;

  /// The object containing this page, if applicable
  Object? get container => _container;
}

/// A page that uses an [offset] to get to the next page.
class Page<T> extends BasePage<T> {
  Page(Paging<T> _paging, ParserFunction<T> pageItemParser,
      [Object? pageContainer])
      : super(_paging, pageItemParser, pageContainer);

  @override
  bool get isLast {
    var paging = _paging as Paging<T>;
    return (paging.offset ?? 0) + paging.limit >= paging.total;
  }

  @override
  dynamic get _next {
    var paging = _paging as Paging<T>;
    return (paging.offset ?? 0) + paging.limit;
  }

  /// Returns the [offset] for the next page.
  int get nextOffset => _next as int;
}

/// A page that uses a [cursor] to get to the next page
class CursorPage<T> extends BasePage<T> {
  CursorPage(CursorPaging<T> _paging, ParserFunction<T> pageItemParser,
      [Object? pageContainer])
      : super(_paging, pageItemParser, pageContainer);

  @override
  dynamic get _next => (_paging as CursorPaging<T>).cursors?.after ?? '';

  /// The [cursor] pointing to the next page.
  /// Is empty, when it's the last page.
  String get after => _next as String;

  @override
  bool get isLast => after.isEmpty;
}

/// Generic strategy to first and next
abstract class NextStrategy<T> {
  Future<T> first([int limit = defaultLimit]);

  Future<T> _getPage(int limit, dynamic next);
}

/// Strategy to get the next set of elements from an offset
mixin OffsetStrategy<T> implements NextStrategy<T> {
  @override
  Future<T> first([int limit = defaultLimit]) => _getPage(limit, 0);

  @override
  Future<T> _getPage(int limit, dynamic next) => getPage(limit, next as int);

  /// Abstract method that is used to do the api call and json serializing
  Future<T> getPage(int limit, int offset);
}

/// Strategy to get the next set of elements from a cursor
mixin CursorStrategy<T> implements NextStrategy<T> {
  @override
  Future<T> first([int limit = defaultLimit]) => _getPage(limit, '');

  @override
  Future<T> _getPage(int limit, dynamic next) => getPage(limit, next as String);

  /// Abstract method that is used to do the api call and json serializing
  Future<T> getPage(int limit, [String after = '']);
}

abstract class _Pages {
  final SpotifyApiBase _api;
  final String _path;
  final String? _pageKey;
  final ParserFunction<dynamic>? _pageContainerParser;

  _Pages(this._api, this._path, this._pageKey, this._pageContainerParser) {
    if (_pageKey != null && _pageContainerParser == null) {
      throw ArgumentError.notNull('pageContainerParser');
    } else if (_pageKey == null && _pageContainerParser != null) {
      throw ArgumentError.notNull('pageKey');
    }
  }
}

/// Base class that handles retrieval of pages with one type
/// (e.g. [Artist], [Playlist] etc.)
abstract class SinglePages<T, V extends BasePage<T>> extends _Pages
    implements NextStrategy<V> {
  bool _cancelled = false;
  final ParserFunction<T> _pageParser;
  final List<V> _bufferedPages = [];

  SinglePages(SpotifyApiBase api, String path, this._pageParser,
      [String? pageKey, ParserFunction<Object>? pageContainerMapper])
      : super(api, path, pageKey, pageContainerMapper);

  Future<Iterable<T>> all([int limit = defaultLimit]) {
    return stream(limit)
        .map((page) => page.items)
        .toList()
        .then((pages) => pages.expand((page) => page!));
  }

  Stream<V> stream([limit = defaultLimit]) {
    late StreamController<V> stream;

    void handlePageAndGetNext(V page) {
      if (_cancelled) {
        stream.close();
        return;
      }

      if (stream.isPaused) {
        _bufferedPages.add(page);
      } else {
        stream.add(page);
      }

      // If this is the last page then end the stream
      if (page.isLast) {
        if (!stream.isPaused) {
          stream.close();
        }
        return;
      }

      // Otherwise get the next page
      _getPage(limit, page._next).then(handlePageAndGetNext);
    }

    stream = StreamController<V>(onListen: () {
      Future<V> firstPage;
      if (_bufferedPages.length == 1) {
        firstPage = Future.value(_bufferedPages.removeAt(0));
      } else {
        firstPage = first(limit);
      }
      firstPage.then(handlePageAndGetNext);
    }, onCancel: () {
      _cancelled = true;
      return Future.value(true);
    }, onResume: () {
      _bufferedPages.forEach(stream.add);
      if (_bufferedPages.last.isLast) {
        stream.close();
      }
      _bufferedPages.clear();
    });
    return stream.stream;
  }
}

/// Handles retrieval of a page through an offset
class Pages<T> extends SinglePages<T, Page<T>> with OffsetStrategy<Page<T>> {
  Pages(SpotifyApiBase api, String path, ParserFunction<T> pageParser,
      [String? pageKey, ParserFunction<Object>? pageContainerMapper])
      : super(api, path, pageParser, pageKey, pageContainerMapper);

  Pages.fromPaging(
      SpotifyApiBase api, Paging<T> paging, ParserFunction<T> pageParser,
      [String? pageKey, ParserFunction<Object>? pageContainerMapper])
      : super(api, Uri.parse(paging.href!).path.substring(1), pageParser,
            pageKey, pageContainerMapper) {
    _bufferedPages.add(Page<T>(paging, _pageParser));
  }

  @override
  Future<Page<T>> getPage(int limit, int offset) async {
    var pathDelimiter = _path.contains('?') ? '&' : '?';
    var newPath = '$_path${pathDelimiter}limit=$limit&offset=$offset';

    var jsonString = await _api._get(newPath);
    var map = json.decode(jsonString);

    if (_pageContainerParser == null) {
      var paging = Paging<T>.fromJson(map);
      return Page<T>(paging, _pageParser);
    } else {
      var paging = Paging<T>.fromJson(map[_pageKey]);
      var container = _pageContainerParser!(map);
      return Page<T>(paging, _pageParser, container);
    }
  }
}

/// Handles retrieval of a page through a cursor
class CursorPages<T> extends SinglePages<T, CursorPage<T>>
    with CursorStrategy<CursorPage<T>> {
  CursorPages(SpotifyApiBase api, String path, ParserFunction<T> pageParser,
      [String? pageKey, ParserFunction<Object>? pageContainerMapper])
      : super(api, path, pageParser, pageKey, pageContainerMapper);

  CursorPages.fromCursorPaging(
      SpotifyApiBase api, CursorPaging<T> paging, ParserFunction<T> pageParser,
      [String? pageKey, ParserFunction<Object>? pageContainerMapper])
      : super(api, Uri.parse(paging.href!).path.substring(1), pageParser,
            pageKey, pageContainerMapper) {
    _bufferedPages.add(CursorPage<T>(paging, _pageParser));
  }

  @override
  Future<CursorPage<T>> getPage(int limit, [String after = '']) async {
    var pathDelimiter = _path.contains('?') ? '&' : '?';
    var newPath = '$_path${pathDelimiter}limit=$limit';
    if (after.isNotEmpty) {
      newPath += '&after=$after';
    }

    var jsonString = await _api._get(newPath);
    var map = json.decode(jsonString);

    if (_pageContainerParser == null) {
      var paging = CursorPaging<T>.fromJson(map);
      return CursorPage<T>(paging, _pageParser);
    } else {
      var paging = CursorPaging<T>.fromJson(map[_pageKey]);
      var container = _pageContainerParser!(map);
      return CursorPage<T>(paging, _pageParser, container);
    }
  }
}

/// Page that allows multiple types (artist, track, episode etc.) together
class BundledPages extends _Pages with OffsetStrategy<List<Page<dynamic>>> {
  final Map<String, ParserFunction<dynamic>> _pageMappers;

  BundledPages(SpotifyApiBase api, String path, this._pageMappers,
      [String? pageKey, ParserFunction<dynamic>? pageContainerParser])
      : super(api, path, pageKey, pageContainerParser);

  @override
  Future<List<Page<dynamic>>> getPage(int limit, int offset) async {
    var pathDelimiter = _path.contains('?') ? '&' : '?';
    var path = '$_path${pathDelimiter}limit=$limit&offset=$offset';

    return _api._get(path).then(_parseBundledPage);
  }

  List<Page<dynamic>> _parseBundledPage(String jsonString) {
    var map = json.decode(jsonString);
    var pages = <Page<dynamic>>[];
    _pageMappers.forEach((key, value) {
      if (map[key] != null) {
        var paging = Paging.fromJson(map[key]);
        var page;
        if (_pageContainerParser == null) {
          page = Page(paging, value);
        } else {
          var container = _pageContainerParser!(map[key]);
          page = Page(paging, value, container);
        }
        pages.add(page);
      }
    });
    return pages;
  }
}
