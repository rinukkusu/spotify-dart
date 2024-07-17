part of '../spotify.dart';

abstract class SpotifyLogger {
  void d(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace});

  void e(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace});

  void i(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace});

  void w(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace});

  void f(String message,
      {DateTime? time, Object? error, StackTrace? stackTrace});
}

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
