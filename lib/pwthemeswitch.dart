import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pwthemecontroller.dart';

class PWThemeSwitch extends StatelessWidget {
  final bool iconMode;
  const PWThemeSwitch({Key? key, this.iconMode = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (iconMode) {
      return iconButton();
    } else {
      return switchButton();
    }
  }

  static Widget switchButton({String? text}) {
    return GetBuilder<PWThemeController>(
      init: PWThemeController(),
      builder: (theme) {
        return SizedBox(
          width: 250,
          child: SwitchListTile(
            title: Text(text ?? (theme.isDark ? 'Light Mode' : 'Dark Mode')),
            value: theme.isDark,
            onChanged: theme.changeThemeMode,
            activeColor: Colors.grey[600],
          ),
        );
      },
    );
  }

  static Widget iconButton({String? text}) {
    return GetBuilder<PWThemeController>(
      init: PWThemeController(),
      builder: (theme) {
        return SizedBox(
          width: 250,
          child: IconButton(
            tooltip: text ?? (theme.isDark ? 'Light Mode' : 'Dark Mode'),
            icon: Icon(
              theme.isDark ? Icons.wb_sunny : Icons.brightness_2,
              color: theme.isDark ? Colors.white : Colors.grey[600],
            ),
            onPressed: () => theme.changeThemeMode(!theme.isDark),
          ),
        );
      },
    );
  }
}
