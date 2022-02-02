import 'dart:convert';
import 'dart:io';

import 'package:pw/pwcontroller.dart';

import 'pwthemecontroller.dart';

class PWStorageController extends PWController {
  File configFile = File('config');

  Future replaceConfig(String data) async =>
      await configFile.writeAsString(data);

  Future getConfig() async {
    if (await configFile.exists()) {
      var confString = await configFile.readAsString();
      if (confString != '') {
        var data = jsonDecode(confString);
        return data;
      }
    } else {
      return {PWThemeMode.key: PWThemeMode.light};
    }
  }

  Future<File> setKeyValue(key, value) async {
    var data = await getConfig();
    data[key] = value;
    return await configFile.writeAsString(jsonEncode(data));
  }

  Future getKey(String key) async {
    var data = await getConfig();
    return data != null ? data[key] : null;
  }
}
