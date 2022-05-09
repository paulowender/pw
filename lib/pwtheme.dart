import 'package:flutter/material.dart';

class PWTheme {
  static ThemeData light() {
    ThemeData theme = ThemeData(
        primaryColor: const Color(0XFF43A047),
        dividerColor: Colors.green[400],
        scaffoldBackgroundColor: Colors.blueGrey[50],
        iconTheme: IconThemeData(color: Colors.green[600]),
        toggleableActiveColor: Colors.green[600],
        colorScheme: const ColorScheme.light(
          primary: Color(0XFF43A047),
          secondary: Color(0XFFA5D6A7),
          secondaryContainer: Color(0XFFBBDEFB),
          onPrimary: Colors.white,
          onSecondary: Color(0XFF43A047),
          error: Color(0XFFB72C2C),
          primaryContainer: Colors.white,
        ),
        cardTheme: const CardTheme(
          color: Color(0XFFFFFFFF),
        ));
    return theme;
  }

  static ThemeData dark() {
    ThemeData theme = ThemeData(
        primaryColor: const Color(0XFFFFFFFF),
        dividerColor: const Color(0XFF43A047),
        iconTheme: const IconThemeData(color: Colors.white),
        toggleableActiveColor: Colors.white,
        colorScheme: const ColorScheme.dark(
          primary: Color(0XFF43A047),
          secondary: Colors.green,
          secondaryContainer: Color(0XFF1E88E5),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          error: Color(0XFFB72C2C),
          inversePrimary: Color(0XFF000000),
          // primaryContainer: Color.fromARGB(255, 43, 42, 42),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0XFF43A047)));
    return theme;
  }
}
