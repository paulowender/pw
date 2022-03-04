import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pw/pwtheme.dart';

import 'pwstoragecontroller.dart';

class PWThemeController extends GetxController {
  bool isDark = false;
  PWThemeController({this.isDark = false});

  ThemeData get theme => isDark ? PWTheme.dark() : PWTheme.light();

  void changeThemeMode(bool nIsDark) {
    isDark = nIsDark;
    var storage = PWStorageController();
    storage.setKeyValue(
        PWThemeMode.key, nIsDark ? PWThemeMode.dark : PWThemeMode.light);
    update();
  }

  void toggleTheme() {
    changeThemeMode(!isDark);
    update();
  }

  @override
  void onInit() async {
    var storage = PWStorageController();
    var value = await storage.getKey(PWThemeMode.key);
    if (value.toString() == 'dark') {
      isDark = true;
      update();
    }
    super.onInit();
  }
}

class PWThemeMode {
  static const String key = 'themeMode';
  static const String light = 'light';
  static const String dark = 'dark';
}
