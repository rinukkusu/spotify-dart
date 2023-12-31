// Copyright (c) 2023, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// ignore: use_string_in_part_of_directives
part of spotify;

/// Custom oauth2 client that allows logging
class SpotifyHttpClient extends http.BaseClient {
  final FutureOr<http.Client> _delegate;
  final Logger _logger = Logger('spotify-dart');

  /// Set this to `true` to enable logging with the amount of
  /// [LoggingDetail]
  static bool enableLogging = false;

  /// Set this how detailed the logging should be.
  /// Default's to [LoggingDetail.full].
  static LoggingDetail loggingDetail = LoggingDetail.full;

  FutureOr<http.Client> get delegate => _delegate;

  SpotifyHttpClient(this._delegate);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (!enableLogging) {
      return (await _delegate).send(request);
    }
    StringBuffer s = StringBuffer("${request.method} ${request.url} -->");
    if (loggingDetail.index >= LoggingDetail.medium.index) {
      s.writeln("header: ${request.headers}");
      if (loggingDetail.index >= LoggingDetail.full.index) {
        if (request is http.Request) {
          var body = request.body;
          if (body.isNotEmpty) {
            var lineSplitter = LineSplitter();
            var lines = lineSplitter.convert(body);
            const maxLineCount = 30;
            // truncating body that has > 100 lines
            if (lines.length > maxLineCount) {
              s.writeln("body: ${lines.getRange(0, maxLineCount).join('\n')}");
              s.writeln("... (body truncated)");
            } else {
              s.writeln('body: ${request.body}');
            }
          } else {
            s.writeln('body: --no body--');
          }
        }
      }
    }
    _logger.info(s);
    s.clear();
    final response = await (await _delegate).send(request);
    s.write(
        "${request.method} ${request.url} <-- ${response.statusCode}:${response.reasonPhrase}");
    if (loggingDetail.index >= LoggingDetail.medium.index) {
      s.writeln("header: ${response.headers}");
      if (loggingDetail.index >= LoggingDetail.full.index) {
        // Simple request
        if (request is http.Request) {
          final List<int> bytes = await response.stream.toBytes();
          s.writeln("body: ${utf8.decode(bytes)}");
          _logger.info(s);

          return http.StreamedResponse(
            http.ByteStream.fromBytes(bytes),
            response.statusCode,
            contentLength: response.contentLength,
            request: request,
            headers: response.headers,
            isRedirect: response.isRedirect,
            persistentConnection: response.persistentConnection,
            reasonPhrase: response.reasonPhrase,
          );
        }
      }
    }
    _logger.info(s);
    return response;
  }

  @override
  void close() async {
    (await _delegate).close();
  }
}

/// Sets how much information is displayed in the http logging
enum LoggingDetail {
  /// Simple tier logging:
  /// Log the requests and responses with their corresponding status code
  simple,

  /// Medium tier logging:
  /// Log the requests with their headers and responses with their
  /// corresponding status codes and headers
  medium,

  /// Full tier logging:
  /// Log the requests with headers and payload and responses with their
  /// corresponding status codes, headers and payload.
  /// Note that this may level of detail may be slower than usual.
  full
}
