// Copyright (c) 2024 IT Path Solutions, hayribakici
//
// MIT-Licence
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
// associated documentation files (the “Software”), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

part of '../spotify.dart';

/// A custom HTTP client with logging capabilities.
class SpotifyClient with http.BaseClient {
  final FutureOr<oauth2.Client> _inner;

  late Logger _logger;

  bool _enableLogging = false;
  void enableLogging(bool enable, {Logger? logger}){
     _enableLogging = enable;
     _logger = logger ?? Logger();
  }

  LoggingDetail _detail = LoggingDetail.full;
  get loggingDetail => _detail;
  set logginDetail(value) => _detail = value;

  SpotifyClient(this._inner);

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    if (!_enableLogging) {
      return await (await _inner).get(url, headers: headers);
    }
    var output = StringBuffer();
    try {
      // Log GET request details
      _logger.i(_logString('🚀 🌐 GET Request 🌐 🚀', url));

      // Perform the GET request
      final response = await (await _inner).get(url, headers: headers);

      // Log GET response details based on the level of detail
      _logger.i(_logString('✅ 🌐 GET Response 🌐 ✅', url,
          headers: response.headers,
          body: response.body,
          statusCode: response.statusCode));

      return response;
    } catch (error) {
      // Log GET error
      output.writeln('❌ ❗ GET Request Failed ❗ ❌');
      output.writeln('❗ Error Message: $error');
      _logger.e(output);
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (!_enableLogging) {
      return await (await _inner).send(request);
    }
    var output = StringBuffer();
    try {
      // not using the _logString method here on purpose
      // Log request details
      output.writeln('🚀 🌐 Request 🌐 🚀');
      output.writeln('🔗 URL: ${request.url}');
      output.write('🤔 Method: ${request.method}');

      if (_loggingMedium) {
        output.writeln();
        output.writeln('📋 Headers:');
        output.writeln(_headersLog(request.headers));
        output.write('🔍 Query Parameters: ${request.url.queryParameters}');
      }
      if (_loggingFull) {
        output.writeln();
        String requestData = (request is http.Request)
            ? '📤 Request Data: ${request.body}'
            : '📤 Request Data: Not applicable for this type of request';
        output.write(requestData);
      }
      _logger.i(output);
      output.clear();

      // Send the request and get the response
      final streamedResponse = await (await _inner).send(request);

      // Log response details
      output.writeln('🔗 URL: ${streamedResponse.request?.url}');
      output.write('🔒 Status Code: ${streamedResponse.statusCode}');
      if (_loggingMedium) {
        output.writeln();
        output.writeln('📋 Headers:');
        output.writeln(_headersLog(streamedResponse.headers));
      }

      _logger.i('✅ 🌐 Response 🌐 ✅\n$output');

      if (_loggingFull) {
        // Read the response stream and create a new http.Response
        final body = await streamedResponse.stream.bytesToString();
        final response = http.Response(
          body,
          streamedResponse.statusCode,
          headers: streamedResponse.headers,
          request: request as http.Request,
        ); // Cast to http.Request

        _logger.i('📥 Response Data: ${response.body}');
      }

      return streamedResponse;
    } catch (error) {
      // Log request error
      String requestErrorData =
          (request is http.Request) ? '\n❗ Request Data: ${request.body}' : '';
      _logger.e('❌ ❗ ERROR ❗ ❌\n❗ Error Message: $error$requestErrorData');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (!_enableLogging) {
      return await (await _inner)
          .delete(url, headers: headers, body: body, encoding: encoding);
    }
    var output = StringBuffer();
    try {
      // Log delete request details
      _logger.i(_logString('🚀 🌐 DELETE Request 🌐 🚀', url,
          headers: headers, body: body));

      output.clear();

      // Perform the delete request
      final response = await (await _inner)
          .delete(url, headers: headers, body: body, encoding: encoding);
      // Log delete response details
      _logger.i(_logString('✅ 🌐 DELETE Response 🌐 ✅', url,
          statusCode: response.statusCode,
          headers: response.headers,
          body: response.body));
      return response;
    } catch (error) {
      // Log delete error
      _logger.e('❌ ❗ DELETE ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (!_enableLogging) {
      return await (await _inner)
          .post(url, headers: headers, body: body, encoding: encoding);
    }
    try {
      // Log post request details
      _logger.i(_logString('🚀 🌐 POST Request 🌐 🚀', url,
          headers: headers, body: body));

      // Perform the post request
      final response = await (await _inner)
          .post(url, headers: headers, body: body, encoding: encoding);

      // Log post response details
      _logger.i(_logString('✅ 🌐 POST Response 🌐 ✅', url,
          headers: response.headers,
          statusCode: response.statusCode,
          body: response.body));

      return response;
    } catch (error) {
      // Log post error
      _logger.e('❌ ❗ POST ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (!_enableLogging) {
      return await (await _inner)
          .patch(url, headers: headers, body: body, encoding: encoding);
    }
    try {
      // Log patch request details
      _logger.i(_logString('🚀 🌐 PATCH Request 🌐 🚀', url,
          headers: headers, body: body));

      // Perform the patch request
      final response = await (await _inner)
          .patch(url, headers: headers, body: body, encoding: encoding);

      // Log patch response details
      _logger.i(_logString('✅ 🌐 PATCH Response 🌐 ✅', url,
          statusCode: response.statusCode,
          headers: response.headers,
          body: response.body));

      return response;
    } catch (error) {
      // Log patch error
      _logger.e('❌ ❗ PATCH ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (!_enableLogging) {
      return await (await _inner)
          .put(url, headers: headers, body: body, encoding: encoding);
    }
    try {
      // Log put request details
      _logger.i(_logString('🚀 🌐 PUT Request 🌐 🚀', url,
          headers: headers, body: body));

      // Perform the put request
      final response = await (await _inner)
          .put(url, headers: headers, body: body, encoding: encoding);

      // Log put response details
      _logger.i(_logString('✅ 🌐 PUT Response 🌐 ✅', url,
          statusCode: response.statusCode,
          headers: response.headers,
          body: response.body));

      return response;
    } catch (error) {
      // Log put error
      _logger.e('❌ ❗ PUT ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) async {
    if (!_enableLogging) {
      return await (await _inner).head(url, headers: headers);
    }
    try {
      // Log head request details
      _logger.i(_logString('🚀 🌐 HEAD Request 🌐 🚀', url, headers: headers));

      // Perform the head request
      final response = await (await _inner).head(url, headers: headers);

      // Log head response details
      _logger.i(_logString('✅ 🌐 Head Response 🌐 ✅', url,
          statusCode: response.statusCode, headers: response.headers));

      return response;
    } catch (error) {
      // Log head error
      _logger.e('❌ ❗ HEAD ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) async {
    if (!_enableLogging) {
      return await (await _inner).read(url, headers: headers);
    }
    try {
      // Log read request details
      _logger.i(_logString('🚀 🌐 READ Request 🌐 🚀', url, headers: headers));

      // Perform the read request using the http package (replace this with your actual implementation)
      final response = await http.get(url, headers: headers);

      // Log read response details
      _logger.i(_logString('✅ 🌐 READ Response 🌐 ✅', url,
          headers: response.headers, body: response.body));

      return response.body;
    } catch (error) {
      // Log read error
      _logger.e('❌ ❗ READ ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) async {
    if (!_enableLogging) {
      return await (await _inner).readBytes(url, headers: headers);
    }
    try {
      // Log readBytes request details
      _logger.i(
          _logString('🚀 🌐 ReadBytes Request 🌐 🚀', url, headers: headers));

      // Perform the readBytes request using the http package (replace this with your actual implementation)
      final response = await http.get(url, headers: headers);

      // Log readBytes response details
      _logger.i(_logString('✅ 🌐 ReadBytes Response 🌐 ✅', url,
          statusCode: response.statusCode,
          headers: response.headers,
          body: response.bodyBytes));

      return response.bodyBytes;
    } catch (error) {
      // Log readBytes error
      _logger.e('❌ ❗ ReadBytes ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  void close() async => (await _inner).close();

  bool get _loggingMedium => _detail.index >= LoggingDetail.medium.index;

  bool get _loggingFull => _detail.index >= LoggingDetail.full.index;

  String _headersLog(Map<String, String>? headers) =>
      headers != null && headers.isNotEmpty
          ? headers.entries
              .map((entry) => '  • ${entry.key}: ${entry.value}')
              .join('\n')
          : 'None';

  String _logString(String title, Uri url,
      {Map<String, String>? headers, int? statusCode, Object? body}) {
    var buf = StringBuffer();
    buf.writeln(title);
    buf.write('🔗 URL: $url');
    if (statusCode != null) {
      buf.writeln();
      buf.write('🔒 Status Code: $statusCode');
    }
    if (_loggingMedium) {
      buf.writeln();
      buf.writeln('📋 Headers:');
      buf.write(_headersLog(headers));
    }
    if (_loggingFull) {
      buf.writeln();
      String bodyLog = (body != null) ? '📤 Data: $body' : '📤 Data: None';
      buf.write(bodyLog);
    }
    return buf.toString();
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
