import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

abstract interface class AppLogger {
  void trace(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]);
  void debug(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]);
  void info(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]);
  void warning(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]);
  void error(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]);
  void fatal(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]);
}

class AppLoggerImpl implements AppLogger {
  AppLoggerImpl({required this.logger});

  final Logger logger;
  // factory AppLoggerImpl() {
  //   return _instance;
  // }

  // AppLogger._internal();

  // final Logger logger =

  /// Singleton instance of the CustomLogger.
  // static final AppLogger _instance = AppLogger._internal();

  /// Logs a verbose message.
  /// Only prints if `kDebugMode` is true.
  @override
  void trace(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    if (kDebugMode) {
      logger.t(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs a debug message.
  /// Only prints if `kDebugMode` is true.
  @override
  void debug(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    if (kDebugMode) {
      logger.d(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs an info message.
  /// Only prints if `kDebugMode` is true.
  @override
  void info(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    if (kDebugMode) {
      logger.i(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs a warning message.
  /// Only prints if `kDebugMode` is true.
  @override
  void warning(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    if (kDebugMode) {
      logger.w(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs an error message.
  /// Only prints if `kDebugMode` is true.
  @override
  void error(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    if (kDebugMode) {
      logger.e(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Logs a "What a Terrible Failure" message.
  /// Only prints if `kDebugMode` is true.
  @override
  void fatal(
    final dynamic message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    if (kDebugMode) {
      logger.f(message, error: error, stackTrace: stackTrace);
    }
  }
}
