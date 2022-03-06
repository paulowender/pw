import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'pwconfig.dart';

class PWErrorLog {
  static void logError(dynamic error, {bool showToast = false}) {
    String message = '${DateTime.now()} - ${error.toString()}\n';
    String path = PWConfig.errorLogPath;
    Directory(path).createSync();
    File('$path/log.txt').writeAsStringSync(message, mode: FileMode.append);
    if (showToast) {
      EasyLoading.showError('Error: $error');
    }
    if (kDebugMode) {
      print(message);
    }
  }

  static void saveLog(
    String fileName,
    String functionName,
    dynamic error, {
    bool showToast = false,
  }) {
    String message =
        '${DateTime.now()} - $fileName - $functionName - ${error.toString()}\n';
    String path = PWConfig.errorLogPath;
    Directory(path).createSync();
    File('$path/log.txt').writeAsStringSync(message, mode: FileMode.append);
    if (showToast) {
      EasyLoading.showError('Error: $error');
    }
    if (kDebugMode) {
      print(message);
    }
  }

  static List<String> getLogs() {
    String path = PWConfig.errorLogPath;
    Directory(path).createSync();
    return File('$path/log.txt').readAsLinesSync();
  }

  static void clearLogs() {
    String path = PWConfig.errorLogPath;
    Directory(path).createSync();
    File('$path/log.txt').writeAsStringSync('');
  }
}
