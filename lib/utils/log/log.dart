// Log Tag
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Tag {
  DB,
  API,
  RIVERPOD,
  ADD,
  DELETE,
  UPDATE,
  SELECT,
  JSON,
  REQUEST,
  RESPONSE,
  SCREEN,
  AUDIO,
  NONE;

  String get title => toString().split('.').last;
}

// Log Level
enum LogLevel {
  TRACE,
  DEBUG,
  WARNING,
  ERROR,
  FATAL,
  NONE,
}

// Log Class
class Log {
  static LogLevel _logLevel = LogLevel.TRACE;
  static final Map<String, List<Tag>> _logTagMap = {};

  Log._internal();

  static final Log _instance = Log._internal();

  factory Log() => _instance;

  static void setLogLevel(LogLevel logLevel) {
    _logLevel = logLevel;
  }

  String _getKey(int stackCount) {
    final location = getCalledFileName(stackCount);
    final package = location['package'];
    final line = location['line'];
    return '$package:$line';
  }

  // Tag 설정 메서드
  Log tag(Tag tag) {
    final key = _getKey(3);

    _setTags([tag], key);
    return _instance;
  }

  // 다중 Tag 설정 메서드
  Log tags(List<Tag> tags) {
    final key = _getKey(3);
    _setTags(tags, key);
    return _instance;
  }

  void _setTags(List<Tag> tags, String key) {
    if (_logTagMap.containsKey(key)) {
      _logTagMap[key]!.addAll(tags);
    } else {
      _logTagMap[key] = tags.toList();
    }
  }

  void _printLog(String message, LogLevel logLevel, {bool showStack = true}) {
    final key = _getKey(4);

    var tags = _logTagMap[key] ?? [];

    if (tags.isEmpty) {
      tags = [Tag.NONE];
    }

    tags.sort((a, b) => a.index.compareTo(b.index));

    if (_shouldNotPrintLog(logLevel)) {
      tags.clear();
      return;
    }

    final tagString = tags.map((tag) => "[${tag.title}]").join();
    final emoji = logLevel.index > LogLevel.DEBUG.index ? '❌' : '🟢';
    final location = showStack ? getCalledFileName(3) : {};
    final splitMsg = message.split('\n');

    for (int i = 0; i < splitMsg.length; i++) {
      final msg = splitMsg[i];
      final logMessage = showStack
          ? "$emoji [${logLevel.name}] $tagString [${location['file']}:${location['line']}]: - $msg"
          : "$emoji [${logLevel.name}] $tagString: - $msg";

      // const subStringCount = 120;
      // debugPrint(logMessage.length > subStringCount ? logMessage.substring(0, subStringCount) : logMessage);
      debugPrint(logMessage);
    }

    tags.clear();
  }

  void t(String message) {
    _printLog(message, LogLevel.TRACE);
  }

  void d(String message) {
    _printLog(message, LogLevel.DEBUG);
  }

  void w(String message) {
    _printLog(message, LogLevel.WARNING);
  }

  void e(String message) {
    _printLog(message, LogLevel.ERROR);
  }

  void f(String message) {
    _printLog(message, LogLevel.FATAL);
  }

  void xt(String message) {
    _printLog(message, LogLevel.TRACE, showStack: false);
  }

  void xd(String message) {
    _printLog(message, LogLevel.DEBUG, showStack: false);
  }

  void xw(String message) {
    _printLog(message, LogLevel.WARNING, showStack: false);
  }

  void xe(String message) {
    _printLog(message, LogLevel.ERROR, showStack: false);
  }

  void xf(String message) {
    _printLog(message, LogLevel.FATAL, showStack: false);
  }

  bool _shouldNotPrintLog(LogLevel logLevel) {
    switch (_logLevel) {
      case LogLevel.TRACE:
        return false;
      case LogLevel.DEBUG:
        return logLevel == LogLevel.TRACE;
      case LogLevel.WARNING:
        return logLevel == LogLevel.TRACE || logLevel == LogLevel.DEBUG;
      case LogLevel.ERROR:
        return logLevel == LogLevel.TRACE ||
            logLevel == LogLevel.DEBUG ||
            logLevel == LogLevel.WARNING;
      case LogLevel.FATAL:
        return logLevel != LogLevel.FATAL;
      case LogLevel.NONE:
        return true;
    }
  }

  Map<String, String> getCalledFileName(int stackCount) {
    try {
      throw Exception(); // 스택 트레이스를 생성
    } catch (e, stackTrace) {
      const unknownName = "unknown file";
      const unknownLine = 'unknown line';
      final stacks = stackTrace.toString().split('\n'); // 호출 정보를 포함한 두 번째 줄
      if (stacks.length < stackCount) {
        return {
          'file': unknownName,
          'line': unknownLine,
        };
      }
      final match = RegExp(r'(.+?):(\d+):\d+')
          .firstMatch(stacks[stackCount]); // 패키지와 라인 번호 추출
      if (match != null) {
        final split = (match.group(1) ?? unknownName).split('(');
        final package =
            split.isNotEmpty ? split[split.length - 1] : unknownName;
        final packageSplit = package.split('/');
        final file = packageSplit.isNotEmpty
            ? packageSplit[packageSplit.length - 1]
            : unknownName;
        return {
          'file': file,
          'line': match.group(2) ?? unknownLine,
        };
      }
    }
    return {'package': 'unknown_package', 'line': 'unknown_line'};
  }
}

extension prettyJson on Map<String, dynamic> {
  String toPrettyString() {
    return const JsonEncoder.withIndent('  ').convert(this);
  }
}

class RiverpodObserver extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    // ubLog.tag(Tag.RIVERPOD).xd('[Update] [Provider] provider - $provider, pv - $previousValue, nv - $newValue');
  }

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    super.didAddProvider(provider, value, container);
    // ubLog.tag(Tag.RIVERPOD).xd('[Add] [Provider] provider - $provider');
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    super.didDisposeProvider(provider, container);
    // ubLog.tag(Tag.RIVERPOD).xd('[Dispose] [Provider] provider - $provider');
  }
}
