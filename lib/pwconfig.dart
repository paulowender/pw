import 'dart:io';

class PWConfig {
  static const String appName = 'PW FLUTTER APP';
  static const String appVersion = "1.0.0";
  static const String appAuthor = "App Author";
  static const String appAuthorEmail = "";
  static const String appLogo = "assets/logo.png";
  static const String hourFormat = 'HH';
  static const String minFormat = 'mm';
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = hourFormat + ':' + minFormat;
  static const String dateTimeFormat = 'dd/MM/yyyy ' + timeFormat;
  static const String moneyFormat = currencySymbolPosition == 'before'
      ? '$currencySymbol ###,##0.00'
      : '###,##0.00 $currencySymbol';
  static const String localeFormat = 'pt_BR';
  static const String currencyFormat = 'BRL';
  static const String currencySymbol = 'R\$';
  static const String currencySymbolPosition = 'before';
  static const String currencyDecimalDigits = '2';

  // Pasta para armazenar os arquivos de log
  static String errorLogPath = '${Directory.current.path}/logs';
}
