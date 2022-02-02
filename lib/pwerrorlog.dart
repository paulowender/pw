import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'pwconfig.dart';

class PWErrorLog {
  static void logError(dynamic error) {
    String message = '${DateTime.now()} - ${error.toString()}\n';
    String path = PWAppConfig.errorLogPath;
    Directory(path).createSync();
    File('$path/log.txt').writeAsStringSync(message, mode: FileMode.append);
    EasyLoading.showToast('Houston, we have a problem!',
        duration: const Duration(seconds: 3));
    if (kDebugMode) {
      print(message);
    }
  }

  static List<String> getLogs() {
    String path = PWAppConfig.errorLogPath;
    Directory(path).createSync();
    return File('$path/log.txt').readAsLinesSync();
  }

  static void clearLogs() {
    String path = PWAppConfig.errorLogPath;
    Directory(path).createSync();
    File('$path/log.txt').writeAsStringSync('');
  }
}
