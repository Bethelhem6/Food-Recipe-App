import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

Logger logger = Logger("App Logger");

void initRootLogger() {
  // only enable logging for debug mode
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
  } else {
    Logger.root.level = Level.OFF;
  }
  hierarchicalLoggingEnabled = true;

  Logger.root.onRecord.listen((record) {
    if (!kDebugMode) {
      return;
    }

    var start = '\x1b[90m'; // Default to grey
    const end = '\x1b[0m';

    switch (record.level.name) {
      case 'INFO':
        start = '\x1b[32m'; // Green
        break;
      case 'WARNING':
        start = '\x1b[33m'; // Yellow
        break;
      case 'SEVERE':
        start = '\x1b[31m'; // Red
        break;
      case 'SHOUT':
        start = '\x1b[35m'; // Magenta
        break;
    }

    final message = '$start${record.message}$end';
    developer.log(
      message,
      level: record.level.value,
    );
  });
}
