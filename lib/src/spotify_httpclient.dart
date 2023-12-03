// Copyright (c) 2023, hayribakici. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

/// Custom oauth2 client that allows logging
class SpotifyHttpClient extends oauth2.Client {
  // final http.Client _delegate;
  final Logger _logger;

  /// Set this to `true` to enable logging with the amount of
  /// [LoggingDetail]
  bool enableLogging = false;

  /// Set this how detailed the logging should be.
  /// Default's to [LoggingDetail.full].
  LoggingDetail loggingDetail = LoggingDetail.full;

  SpotifyHttpClient(super.credentials, this._logger);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (!enableLogging) {
      return super.send(request);
    }
    if (loggingDetail.index >= LoggingDetail.simple.index) {
      StringBuffer s = StringBuffer("${request.method} ${request.url} -->");
      if (loggingDetail.index >= LoggingDetail.medium.index) {
        s.writeln("header: ${request.headers}");
        if (loggingDetail.index >= LoggingDetail.full.index) {
          if (request is http.Request) {
            if (request.body.isNotEmpty) {
              s.writeln("body: ${request.body}");
            } else {
              s.writeln('body: --no body--');
            }
          }
        }
      }
      _logger.info(s.toString());
      s.clear();
      final response = await super.send(request);
      s.write("${request.method} ${request.url} <--");
      if (loggingDetail.index >= LoggingDetail.medium.index) {
        s.writeln("header: ${response.headers}");

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

      _logger.info(s);

      return response;
    }
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
  /// corresponding status codes, headers and payload
  full
}
