import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pwthemecontroller.dart';

class PWThemeSwitch extends StatelessWidget {
  final bool iconMode;
  final Color iconColor;
  const PWThemeSwitch({Key key, this.iconMode = false, this.iconColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (iconMode) {
      return iconButton(iconColor: iconColor);
    } else {
      return switchButton();
    }
  }

  static Widget switchButton({String text}) {
    return GetBuilder<PWThemeController>(
      init: PWThemeController(),
      builder: (theme) {
        return SizedBox(
          width: 250,
          child: SwitchListTile(
            title: Text(text ?? 'Modo Escuro'),
            value: theme.isDark,
            onChanged: theme.changeThemeMode,
            activeColor: Colors.grey[600],
          ),
        );
      },
    );
  }

  static Widget iconButton({String text, Color iconColor}) {
    return GetBuilder<PWThemeController>(
      init: PWThemeController(),
      builder: (theme) {
        return IconButton(
          tooltip: text ?? (theme.isDark ? 'Tema Claro' : 'Tema Escuro'),
          icon: Icon(
            theme.isDark ? Icons.wb_sunny : Icons.brightness_2,
            color: iconColor,
          ),
          onPressed: () => theme.changeThemeMode(!theme.isDark),
        );
      },
    );
  }
}
