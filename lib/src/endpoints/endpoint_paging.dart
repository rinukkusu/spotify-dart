// Copyright (c) 2017, 2018, hayribakici, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

abstract class EndpointPaging extends EndpointBase {
  EndpointPaging(SpotifyApiBase api) : super(api);

  Pages<T> _getPages<T>(String path, ParserFunction<T> pageItemParser,
          [String pageKey = null,
          ParserFunction<Object> pageContainerParser = null]) =>
      new Pages(_api, path, pageItemParser, pageKey, pageContainerParser);

  BundledPages _getBundledPages<T>(
          String path, Map<String, ParserFunction<T>> pageItemParsers,
          [String pageKey = null,
          ParserFunction<Object> pageContainerParser = null]) =>
      new BundledPages(
          _api, path, pageItemParsers, pageKey, pageContainerParser);
}

class Page<T> {
  Paging<dynamic> _paging;
  Iterable<T> _items;
  Object _container;

  Page(this._paging, ParserFunction<T> pageItemParser,
      [Object pageContainer = null]) {
    _items = _paging.itemsNative.map(pageItemParser);
    _container = pageContainer;
  }

  /// The offset-based paging object is a container for a set of objects. It
  /// contains a key called items (whose value is an array of the requested
  /// objects) along with other keys like previous, next and limit that can be
  /// useful in future calls.
  Paging<T> get metadata => _paging;

  /// The requested data
  Iterable<T> get items => _items;

  /// The object containing this page, if applicable
  Object get container => _container;

  bool get isLast => _paging.offset + _paging.limit >= _paging.total;
  int get nextOffset => _paging.offset + _paging.limit;
}

const defaultLimit = 20;

abstract class _Pages<T> {
  SpotifyApiBase _api;
  String _path;
  String _pageKey;
  ParserFunction<Object> _pageContainerParser;

  _Pages(this._api, this._path,
      [this._pageKey = null, this._pageContainerParser = null]) {
    if (_pageKey != null && _pageContainerParser == null) {
      throw new ArgumentError.notNull('pageContainerParser');
    } else if (_pageKey == null && _pageContainerParser != null) {
      throw new ArgumentError.notNull('pageKey');
    }
  }

  /// Abstract method that is used to do the api call and json serializing
  Future<T> getPage(int limit, int offset);

  Future<T> first([int limit = defaultLimit]) {
    return getPage(limit, 0);
  }
}

class Pages<T> extends _Pages<Page<T>> {
  ParserFunction<T> _pageParser;
  List<Page<T>> _bufferedPages = [];
  bool _cancelled = false;

  Pages(SpotifyApi api, String path, this._pageParser,
      [String pageKey = null,
      ParserFunction<Object> pageContainerMapper = null])
      : super(api, path, pageKey, pageContainerMapper);

  Future<Iterable<T>> all([int limit = defaultLimit]) {
    return stream(limit)
        .map((page) => page.items)
        .toList()
        .then((pages) => pages.expand((page) => page));
  }

  Stream<Page<T>> stream([int limit = defaultLimit]) {
    StreamController<Page<T>> stream;

    void handlePageAndGetNext(Page<T> page) {
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
      getPage(limit, page.nextOffset).then(handlePageAndGetNext);
    }

    stream = new StreamController<Page<T>>(onListen: () {
      var firstPage = first(limit);
      firstPage.then(handlePageAndGetNext);
    }, onCancel: () {
      _cancelled = true;
      return new Future.value(true);
    }, onResume: () {
      _bufferedPages.forEach(stream.add);
      if (_bufferedPages.last.isLast) {
        stream.close();
      }
      _bufferedPages.clear();
    });
    return stream.stream;
  }

  Future<Page<T>> getPage(int limit, int offset) async {
    var pathDelimiter = _path.contains('?') ? '&' : '?';
    var newPath = '$_path${pathDelimiter}limit=$limit&offset=$offset';

    var jsonString = await _api._get(newPath);
    var map = json.decode(jsonString);

    if (_pageContainerParser == null) {
      var paging = Paging.fromJson(map);
      return new Page(paging, _pageParser);
    } else {
      var paging = Paging.fromJson(map[_pageKey]);
      var container = _pageContainerParser(map);
      return new Page(paging, _pageParser, container);
    }
  }
}

class BundledPages extends _Pages<List<Page<Object>>> {
  Map<String, ParserFunction<Object>> _pageMappers;

  BundledPages(SpotifyApiBase api, String path, this._pageMappers,
      [String pageKey, ParserFunction<Object> pageContainerParser])
      : super(api, path, pageKey, pageContainerParser);

  Future<List<Page<Object>>> getPage(int limit, int offset) async {
    var pathDelimiter = _path.contains('?') ? '&' : '?';
    var path = '$_path${pathDelimiter}limit=$limit&offset=$offset';

    return _api._get(path).then(_parseBundledPage);
  }

  List<Page<Object>> _parseBundledPage(String jsonString) {
    var map = json.decode(jsonString);
    List<Page<Object>> pages = [];
    _pageMappers.forEach((key, value) {
      if (map[key] != null) {
        var paging = Paging.fromJson(map[key]);
        var page;
        if (_pageContainerParser == null) {
          page = new Page(paging, value);
        } else {
          var container = _pageContainerParser(map[key]);
          page = new Page(paging, value, container);
        }
        pages.add(page);
      }
    });
    return pages;
  }
}
