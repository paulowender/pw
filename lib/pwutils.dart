import 'package:clipboard/clipboard.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:pw/pwcrypto.dart';

import 'pwconfig.dart';
import 'pwerrorlog.dart';

class PWUtils {
  // Retorna a data no formato definido
  static String getDate(DateTime date) =>
      DateFormat(PWConfig.dateFormat).format(date);

  // Retorna a data no formato definido
  static String getTime(DateTime date) =>
      DateFormat(PWConfig.timeFormat).format(date);

  // Retorna a data no formato definido
  static String getDateTime(DateTime date) =>
      DateFormat(PWConfig.dateTimeFormat).format(date);

  // Retorna o valor no formato definido
  static String getMoney(double money) =>
      NumberFormat(PWConfig.moneyFormat, PWConfig.localeFormat).format(money);

  // Retorna o valor no formato definido
  static String formatCurrency(double money) =>
      NumberFormat(PWConfig.moneyFormat, PWConfig.localeFormat).format(money);

  static double stringToDouble(String money) {
    try {
      if (money.contains(RegExp(r'[A-Z]'))) {
        return 0.0;
      }
      return double.parse(money.replaceAll(',', '.'));
    } catch (e) {
      // PWErrorLog.logError(e);
      return 0.0;
    }
  }

  // Retorna o valor no formato definido
  static getDateFromString(String? valor) {
    try {
      if (valor == null) {
        return DateFormat(PWConfig.dateFormat).parse(DateTime.now().toString());
      } else {
        return DateFormat(PWConfig.dateFormat).parse(valor);
      }
    } catch (e) {
      PWErrorLog.logError(e);
      return valor;
    }
  }

  static formatDateSped(String? date) {
    try {
      if (date != null) {
        return '${date.substring(0, 2)}/${date.substring(2, 4)}/${date.substring(4, 8)}';
      } else {
        return date;
      }
    } catch (e) {
      PWErrorLog.logError(e);
      return date;
    }
  }

  // Retorna o valor do map referente ao nome da chave
  static String translate(String key, Map<String, String> traducoes) =>
      traducoes[key] ?? key;

  static copyToClipboard(String text) {
    FlutterClipboard.copy(text).then((value) {
      EasyLoading.showSuccess('Valor copiado\n$text');
    }).onError((error, stackTrace) {
      EasyLoading.showError('Falha ao copiar');
    });
  }

  static get isDesktop =>
      GetPlatform.isWindows || GetPlatform.isLinux || GetPlatform.isMacOS;

  // Retorna se é double
  static bool isDouble(String value) {
    try {
      double.parse(value);
      return !isInt(value);
    } catch (e) {
      return false;
    }
  }

  // Retorna se é int
  static bool isInt(String value) {
    try {
      int.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Retorna se é um numero
  static bool isNumber(String value) {
    return isDouble(value) || isInt(value);
  }

  static encrypt(String senha) {
    return PWCrypto.stringToHex(senha);
  }

  static decrypt(String senha) {
    return PWCrypto.hexToString(senha);
  }
}
