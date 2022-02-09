import 'package:flutter/material.dart';

class PWTheme {
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

  static ThemeData light() {
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
          primaryContainer: Colors.white,
        ),
        cardTheme: const CardTheme(
          color: cardLight,
        ));
    return theme;
  }

  static ThemeData dark() {
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
          // primaryContainer: Color.fromARGB(255, 43, 42, 42),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: green));
    return theme;
  }
}
