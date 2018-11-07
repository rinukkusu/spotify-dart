// Copyright (c) 2017, chances. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

abstract class EndpointPaging extends EndpointBase {
  EndpointPaging(SpotifyApiBase api) : super(api);

  Pages<T> _getPages<T>(String path,
      ParserFunction<T> pageItemParser,
      [
        String pageKey = null,
        ParserFunction<Object> pageContainerParser = null
      ]) =>
      new Pages(_api, path, pageItemParser, pageKey, pageContainerParser);
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

class Pages<T> {
  static const defaultLimit = 20;

  SpotifyApiBase _api;
  String _path;
  ParserFunction<T> _pageMapper;
  ParserFunction<Object> _pageContainerMapper;
  String _pageKey;
  List<Page<T>> _bufferedPages = [];
  bool _cancelled = false;

  Pages(this._api, this._path, this._pageMapper,
      [this._pageKey = null, this._pageContainerMapper = null]) {
    if (_pageKey != null && _pageContainerMapper == null) {
      throw new ArgumentError.notNull('_pageContainerMapper');
    } else if (_pageKey == null && _pageContainerMapper != null) {
      throw new ArgumentError.notNull('_pageKey');
    }
  }

  Future<Page<T>> first([int limit = defaultLimit]) {
    return _getPage(limit, 0);
  }

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
      _getPage(limit, page.nextOffset).then(handlePageAndGetNext);
    }

    stream = new StreamController<Page<T>>(
      onListen: () {
        var firstPage = first(limit);
        firstPage.then(handlePageAndGetNext);
      },
      onCancel: () {
        _cancelled = true;
        return new Future.value(true);
      },
      onResume: () {
        _bufferedPages.forEach(stream.add);
        if (_bufferedPages.last.isLast) {
          stream.close();
        }
        _bufferedPages.clear();
      }
    );
    return stream.stream;
  }

  Future<Page<T>> _getPage(int limit, int offset) async {
    var pathDelimiter = _path.contains('?') ? '&' : '?';
    var path = '$_path${pathDelimiter}limit=$limit&offset=$offset';

    var jsonString = await _api._get(path);
    var map = json.decode(jsonString);

    if (_pageContainerMapper == null) {
      var paging = Paging.fromJson(map);
      return new Page(paging, _pageMapper);
    } else {
      var paging = Paging.fromJson(map[_pageKey]);
      var container = _pageContainerMapper(map);
      return new Page(paging, _pageMapper, container);
    }
  }
}
