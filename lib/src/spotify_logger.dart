part of '../spotify.dart';

abstract class SpotifyLogger {
  /// Debug
  void d(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace});

  /// Error
  void e(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace});

  /// Information
  void i(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace});

  /// Warning
  void w(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace});

  /// Fatal
  void f(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace});
}

/// Default Logger, that emits when in debug mode
class DefaultLogger implements SpotifyLogger {
  @override
  void d(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    log(message, time: time, level: 400, error: error, stackTrace: stackTrace);
  }

  @override
  void e(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    log(message, time: time, level: 1000, error: error, stackTrace: stackTrace);
  }

  @override
  void f(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    log(message, time: time, level: 1200, error: error, stackTrace: stackTrace);
  }

  @override
  void i(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    log(message, time: time, level: 800, error: error, stackTrace: stackTrace);
  }

  @override
  void w(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    log(message, time: time, level: 900, error: error, stackTrace: stackTrace);
  }
}
