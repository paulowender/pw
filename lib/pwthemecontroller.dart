import 'package:flutter/material.dart';
import 'package:pw/pwcontroller.dart';

import 'pwstoragecontroller.dart';

class PWThemeController extends PWController {
  bool isDark = false;
  static const Color white = Color(0XFFFFFFFF);
  static const Color black = Color(0XFF000000);
  static const Color cardLight = Color(0XFFFFFFFF);
  static const Color redLight = Color(0XFFEF9A9A);
  static const Color redDark = Color(0XFFB72C2C);
  static const Color green = Color(0XFF43A047);
  static const Color greenAcenpt = Color(0XFFA5D6A7);
  static const Color errorLight = Color(0XFFFFCDD2);
  static const Color errorDark = Color(0XFFB71C1C);
  static const Color blueLight = Color(0XFFBBDEFB);
  static const Color blueDark = Color(0XFF1E88E5);

  ThemeData get theme => isDark ? buildDarkTheme() : buildLightTheme();

  ThemeData buildLightTheme() {
    ThemeData theme = ThemeData(
        primaryColor: green,
        dividerColor: Colors.green[400],
        scaffoldBackgroundColor: Colors.blueGrey[50],
        iconTheme: IconThemeData(color: Colors.green[600]),
        colorScheme: const ColorScheme.light(
          primary: green,
          secondary: greenAcenpt,
          secondaryContainer: blueLight,
          onPrimary: Colors.white,
          onSecondary: Color(0XFF43A047),
          error: redDark,
          primaryContainer: white,
        ),
        cardTheme: const CardTheme(
          color: cardLight,
        ));
    return theme;
  }

  ThemeData buildDarkTheme() {
    ThemeData theme = ThemeData(
        primaryColor: white,
        dividerColor: green,
        iconTheme: const IconThemeData(color: Colors.white),
        colorScheme: const ColorScheme.dark(
          primary: green,
          secondary: Colors.green,
          secondaryContainer: blueDark,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          error: redDark,
          inversePrimary: black,
        ),
        appBarTheme: const AppBarTheme(backgroundColor: green));
    return theme;
  }

  void changeThemeMode(bool nIsDark) {
    isDark = nIsDark;
    var storage = PWStorageController();
    storage.setKeyValue(
        PWThemeMode.key, nIsDark ? PWThemeMode.dark : PWThemeMode.light);
    update();
  }

  void toggleTheme() {
    changeThemeMode(!isDark);
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
