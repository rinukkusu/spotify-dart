part of '../spotify.dart';


class SpotifyInterceptor implements interceptor.InterceptorContract {

  final Logger _logger = Logger('spotify-dart');

  /// Set this to `true` to enable logging with the amount of
  /// [LoggingDetail]
  bool _shouldIntercept;

  /// Set this how detailed the logging should be.
  /// Default's to [LoggingDetail.full].
  LoggingDetail loggingDetail;

  SpotifyInterceptor({required bool shouldIntercept, this.loggingDetail = LoggingDetail.full}) : _shouldIntercept = shouldIntercept;

  set shouldIntercept(value) {
    assert(() {
      // This block only runs in debug mode.
      _shouldIntercept = value;
      return true;
    }());
    
  }

  @override
  Future<bool> shouldInterceptRequest() async => _shouldIntercept;
  
  @override
  Future<bool> shouldInterceptResponse() async => _shouldIntercept;
  
  @override
  Future<http.BaseRequest> interceptRequest({required http.BaseRequest request}) async {
    var index = loggingDetail.index;
    StringBuffer buffer = StringBuffer();
    if (index <= LoggingDetail.simple.index) {
      var url = request.url.toString();
      buffer.writeln('--> $url');
    } else if (index <= LoggingDetail.medium.index) {
      var headers = request.headers;
      buffer.writeAll(headers.entries, '\n');
    } else if (index <= LoggingDetail.full.index) {
      if (request is http.Request) {
        var body = request.body;
        buffer.write(body);
      } else {
        buffer.writeln('-- no body --');
      }
    }
    _logger.info(buffer);
    return request;
  }
  
  @override
  Future<http.BaseResponse> interceptResponse({required http.BaseResponse response}) async {
    return response;
  }  
}

class ExpiredTokenRetryPolicy implements interceptor.RetryPolicy {

  int retryLimit = 5;

  ExpiredTokenRetryPolicy({required this.retryLimit});

  @override
  int get maxRetryAttempts => retryLimit;

  @override
  Future<bool> shouldAttemptRetryOnException(Exception reason, http.BaseRequest request) async {
    return (reason.runtimeType == ApiRateException);
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(http.BaseResponse response) async => false;

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