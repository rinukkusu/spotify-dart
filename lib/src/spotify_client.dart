// Copyright (c) 2024 IT Path Solutions
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

  final Logger _logger = Logger();

  bool _enableLogging = false;
  get enableLogging => _enableLogging;
  set enableLogging(value) => _enableLogging = value;

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
      String headersLog = headers != null && headers.isNotEmpty
          ? '\n${headers.entries.map((entry) => '  • ${entry.key}: ${entry.value}').join('\n')}'
          : ': None';
          
      output.writeln('Sending GET Request 🌐 🚀');
      output.writeln('🔗 URL: $url');
      if (_loggingMedium) {
        output.write('📋 Headers$headersLog');
      }
      _logger.i(output);

      // Perform the GET request
      final response = await (await _inner).get(url, headers: headers);
      
      // Log GET response details based on the level of detail
      output.clear();
      output.writeln('✅ 🌐 GET Response 🌐 ✅');
      output.writeln('🔗 URL: $url');
      output.writeln('🔒 Status Code: ${response.statusCode}');
      if (_loggingMedium) {
        output.writeln('📋 Headers:');
        output.writeln(response.headers.entries.map((entry) => '  • ${entry.key}: ${entry.value}').join('\n'));
      }
      if (_loggingFull) {
        output.writeln('📥 Response Data: ${response.body}');
      }
      _logger.i(output);

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
      // Log request details
      String requestData = (request is http.Request)
          ? '📤 Request Data: ${request.body}'
          : '📤 Request Data: Not applicable for this type of request';
      
      output.writeln('🚀 🌐 Request 🌐 🚀');
      output.writeln('🔗 URL: ${request.url}');
      output.writeln('🤔 Method: ${request.method}');
    
      if (_loggingMedium) {
        output.writeln('📋 Headers: ${jsonEncode(request.headers)}');
        output.writeln('🔍 Query Parameters: ${request.url.queryParameters}');
      }
      if (_loggingFull) {
        output.writeln(requestData);
      }
      _logger.i(output);
      output.clear();

      // Send the request and get the response
      final streamedResponse = await (await _inner).send(request);

      // Log response details
      output.writeln('🔗 URL: ${streamedResponse.request?.url}');
      output.writeln('🔒 Status Code: ${streamedResponse.statusCode}');
      if (_loggingMedium) {
        output.writeln('📋 Headers: ${jsonEncode(streamedResponse.headers)}');
      }
      
      _logger.i('✅ 🌐 Response 🌐 ✅$output');
      
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
      String headersLog = (headers != null)
          ? '📋 Headers: ${jsonEncode(headers)}'
          : '📋 Headers: None';
      String bodyLog = (body != null)
          ? '📤 Request Data: $body'
          : '📤 Request Data: None';
      output.writeln('🚀 🌐 Delete Request 🌐 🚀');
      output.writeln('🔗 URL: $url');

      if (_loggingMedium) {
        output.write(headersLog);
      }
      if (_loggingFull) {
        output.write(bodyLog);
      }
      _logger.i(output);

      output.clear();

      // Perform the delete request
      final response = await (await _inner)
          .delete(url, headers: headers, body: body, encoding: encoding);
      // Log delete response details
      String responseData =
          '\n🔗 URL: $url\n🔒 Status Code: ${response.statusCode}\n📋 Headers: ${jsonEncode(response.headers)}';
      _logger.i(
          '✅ 🌐 Delete Response 🌐 ✅$responseData\n📥 Response Data: ${response.body}');
      return response;
    } catch (error) {
      // Log delete error
      _logger.e('❌ ❗ Delete ERROR ❗ ❌\n❗ Error Message: $error');
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
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      String bodyLog = (body != null)
          ? '\n📤 Request Data: $body'
          : '\n📤 Request Data: None';
      _logger.i('🚀 🌐 Post Request 🌐 🚀\n🔗 URL: $url$headersLog$bodyLog');

      // Perform the post request
      final response = await (await _inner)
          .post(url, headers: headers, body: body, encoding: encoding);

      // Log post response details
      String responseData =
          '\n🔗 URL: $url\n🔒 Status Code: ${response.statusCode}\n📋 Headers: ${jsonEncode(response.headers)}';
      _logger.i(
          '✅ 🌐 Post Response 🌐 ✅$responseData\n📥 Response Data: ${response.body}');

      return response;
    } catch (error) {
      // Log post error
      _logger.e('❌ ❗ Post ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (!_enableLogging) {
      return await (await _inner).patch(url, headers: headers, body: body, encoding: encoding);
    }
    try {
      // Log patch request details
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      String bodyLog = (body != null)
          ? '\n📤 Request Data: $body'
          : '\n📤 Request Data: None';
      _logger.i('🚀 🌐 Patch Request 🌐 🚀\n🔗 URL: $url$headersLog$bodyLog');

      // Perform the patch request
      final response = await (await _inner)
          .patch(url, headers: headers, body: body, encoding: encoding);

      // Log patch response details
      String responseData =
          '\n🔗 URL: $url\n🔒 Status Code: ${response.statusCode}\n📋 Headers: ${jsonEncode(response.headers)}';
      _logger.i(
          '✅ 🌐 Patch Response 🌐 ✅$responseData\n📥 Response Data: ${response.body}');

      return response;
    } catch (error) {
      // Log patch error
      _logger.e('❌ ❗ Patch ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (!_enableLogging) {
      return await (await _inner).put(url, headers: headers, body: body, encoding: encoding);
    }
    try {
      // Log put request details
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      String bodyLog = (body != null)
          ? '\n📤 Request Data: $body'
          : '\n📤 Request Data: None';
      _logger.i('🚀 🌐 Put Request 🌐 🚀\n🔗 URL: $url$headersLog$bodyLog');

      // Perform the put request
      final response = await (await _inner)
          .put(url, headers: headers, body: body, encoding: encoding);

      // Log put response details
      String responseData =
          '\n🔗 URL: $url\n🔒 Status Code: ${response.statusCode}\n📋 Headers: ${jsonEncode(response.headers)}';
      _logger.i(
          '✅ 🌐 Put Response 🌐 ✅$responseData\n📥 Response Data: ${response.body}');

      return response;
    } catch (error) {
      // Log put error
      _logger.e('❌ ❗ Put ERROR ❗ ❌\n❗ Error Message: $error');
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
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      _logger.i('🚀 🌐 Head Request 🌐 🚀\n🔗 URL: $url$headersLog');

      // Perform the head request
      final response = await (await _inner).head(url, headers: headers);

      // Log head response details
      String responseData =
          '\n🔗 URL: $url\n🔒 Status Code: ${response.statusCode}\n📋 Headers: ${jsonEncode(response.headers)}';
      _logger.i('✅ 🌐 Head Response 🌐 ✅$responseData');

      return response;
    } catch (error) {
      // Log head error
      _logger.e('❌ ❗ Head ERROR ❗ ❌\n❗ Error Message: $error');
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
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      _logger.i('🚀 🌐 Read Request 🌐 🚀\n🔗 URL: $url$headersLog');

      // Perform the read request using the http package (replace this with your actual implementation)
      final response = await http.get(url, headers: headers);

      // Log read response details
      _logger.i(
          '✅ 🌐 Read Response 🌐 ✅\n🔗 URL: $url\n📥 Response Data: ${response.body}');

      return response.body;
    } catch (error) {
      // Log read error
      _logger.e('❌ ❗ Read ERROR ❗ ❌\n❗ Error Message: $error');
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
      String headersLog = (headers != null)
          ? '\n📋 Headers: ${jsonEncode(headers)}'
          : '\n📋 Headers: None';
      _logger.i('🚀 🌐 ReadBytes Request 🌐 🚀\n🔗 URL: $url$headersLog');

      // Perform the readBytes request using the http package (replace this with your actual implementation)
      final response = await http.get(url, headers: headers);

      // Log readBytes response details
      _logger.i(
          '✅ 🌐 ReadBytes Response 🌐 ✅\n🔗 URL: $url\n📥 Response Data: ${response.bodyBytes}');

      return response.bodyBytes;
    } catch (error) {
      // Log readBytes error
      _logger.e('❌ ❗ ReadBytes ERROR ❗ ❌\n❗ Error Message: $error');
      rethrow; // Rethrow the error after logging
    }
  }

  @override
  void close() async => (await _inner).close();

  bool get _loggingSimple => _detail.index >= LoggingDetail.simple.index;

  bool get _loggingMedium => _detail.index >= LoggingDetail.medium.index;

  bool get _loggingFull => _detail.index >= LoggingDetail.full.index;
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