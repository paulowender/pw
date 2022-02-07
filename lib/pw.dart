library pw;

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pw/pwconfig.dart';

import 'pwthemecontroller.dart';
import 'pwutils.dart';

export 'package:pw/pw.dart';
export 'package:pw/pwconfig.dart' show PWConfig;
export 'package:pw/pwerrorlog.dart' show PWErrorLog;
export 'package:pw/pwstoragecontroller.dart' show PWStorageController;
export 'package:pw/pwthemecontroller.dart' show PWThemeController;
export 'package:pw/pwthemeswitch.dart' show PWThemeSwitch;
export 'package:pw/pwutils.dart' show PWUtils;

class PW extends StatelessWidget {
  static Color primary =
      Get.find<PWThemeController>().theme.colorScheme.primary;
  final String title;
  final Widget home;
  final Widget Function(BuildContext, Widget?)? builder;
  final ThemeData? themeLight;
  final ThemeData? themeDark;

  const PW({
    Key? key,
    this.title = PWConfig.appName,
    required this.home,
    required this.builder,
    this.themeLight,
    this.themeDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PWThemeController>(
      init: PWThemeController(),
      builder: (controller) => GetMaterialApp(
        theme: controller.isDark
            ? themeDark ?? controller.theme
            : themeLight ?? controller.theme,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.rightToLeftWithFade,
        title: title,
        home: home,
        builder: builder,
        onInit: EasyLoading.init,
        // translations: Messages(), // Traduções
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: const [
        //   // Locale('pt', 'BR'),
        //   Locale('en', 'US'),
        // ],
        // locale: Get.locale,
      ),
    );
  }

  // BUTTON
  static Tooltip button({
    required String title,
    String? tooltip,
    Color? color,
    Color? borderColor,
    required void Function() onPressed,
  }) {
    return Tooltip(
      message: tooltip ?? '',
      child: ElevatedButton(
        style: buttonStyle(color: color, borderColor: borderColor),
        child: Text(title),
        onPressed: onPressed,
      ),
    );
  }

  // TEXT AREA
  static TextField textArea(String text) {
    return TextField(
      controller: TextEditingController(text: text),
      maxLines: null,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
    );
  }

  // TEXTBUTTON
  static TextButton buttonText({
    required String title,
    required void Function() onPressed,
  }) {
    return TextButton(
      child: Text(title),
      onPressed: onPressed,
    );
  }

  // TEXTBUTTON
  static TextButton buttonTextWithIcon({
    required String title,
    required Icon icon,
    required void Function() onPressed,
  }) {
    return TextButton.icon(
      label: Text(title),
      icon: icon,
      onPressed: onPressed,
    );
  }

  // BUTTON WITH ICON
  static ElevatedButton buttonWithIcon({
    required String title,
    required IconData icon,
    required void Function() onPressed,
  }) {
    return ElevatedButton.icon(
      style: buttonStyle(),
      label: Text(title),
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }

  // BUTTON WITH CONFIRM
  static Widget buttonWithConfirm(
    BuildContext context, {
    required String title,
    String content = 'Deseja realmente executar esta ação?',
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    Color confirmColor = Colors.red,
    Color cancelColor = Colors.grey,
    required Function onConfirm,
  }) {
    return button(
        title: title,
        color: confirmColor,
        onPressed: () {
          confirmDialog(
            context,
            title: title,
            content: content,
            confirmText: confirmText,
            cancelText: cancelText,
            confirmColor: confirmColor,
            cancelColor: cancelColor,
            onConfirm: onConfirm,
          );
        });
  }

  // CONFIRM DIALOG
  static Future<bool> confirmDialog(
    BuildContext context, {
    String title = 'Confirmação',
    String content = '',
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    Color confirmColor = Colors.red,
    Color cancelColor = Colors.grey,
    required Function onConfirm,
  }) async {
    var confirmStyle =
        ButtonStyle(backgroundColor: MaterialStateProperty.all(confirmColor));
    var cancelStyle =
        ButtonStyle(backgroundColor: MaterialStateProperty.all(cancelColor));
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: Text(content, textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            ElevatedButton(
              style: cancelStyle,
              child: Text(cancelText),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              style: confirmStyle,
              child: Text(confirmText),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  // INPUT FORM FIELD
  static Widget formField<T>(
    String label,
    String initialValue,
    void Function(String value)? onSubmited, {
    TextEditingController? controller,
    bool required = false,
  }) {
    final primary = Get.find<PWThemeController>().theme.colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller ?? TextEditingController(text: initialValue),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: primary,
            ),
          ),
        ),
        onFieldSubmitted: onSubmited,
        textInputAction: TextInputAction.next,
        readOnly: onSubmited == null,
        validator: (value) {
          if (required && value == '') {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }

  // INPUT INT FORM FIELD
  static Widget formFieldInt<T>(
      String label, String initialValue, void Function(int value) onSubmited) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: TextEditingController(text: initialValue),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: primary,
            ),
          ),
        ),
        onFieldSubmitted: (value) {
          PWUtils.isNumber(value)
              ? onSubmited(int.parse(value))
              : EasyLoading.showToast('Valor inválido');
        },
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  // INPUT DOUBLE FORM FIELD
  static Widget formFieldDouble<T>(String label, String initialValue,
      void Function(double value) onSubmited) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: TextEditingController(text: initialValue),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: primary,
            ),
          ),
        ),
        onFieldSubmitted: (value) {
          PWUtils.isNumber(value)
              ? onSubmited(double.parse(value))
              : EasyLoading.showToast('Valor inválido');
        },
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  // ICON BUTTON
  static IconButton iconButton({
    required IconData icon,
    String? tooltip,
    Color? color,
    required void Function() onPressed,
  }) {
    return IconButton(
      tooltip: tooltip ?? '',
      icon: Icon(icon, color: color),
      onPressed: onPressed,
    );
  }

  // ICON BUTTON WITH CONFIRM
  static Widget iconButtonWithConfirm(
    BuildContext context, {
    required IconData icon,
    String title = 'Confirmação',
    String content = 'Deseja realmente executar esta ação?',
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    Color confirmColor = Colors.red,
    Color cancelColor = Colors.grey,
    required Function onConfirm,
  }) {
    return iconButton(
        icon: icon,
        tooltip: title,
        color: confirmColor,
        onPressed: () {
          confirmDialog(
            context,
            title: title,
            content: content,
            confirmText: confirmText,
            cancelText: cancelText,
            confirmColor: confirmColor,
            cancelColor: cancelColor,
            onConfirm: onConfirm,
          );
        });
  }

  static buttonStyle({Color? color, Color? borderColor}) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
          color ?? Get.find<PWThemeController>().theme.colorScheme.primary),
      shape: borderColor != null
          ? MaterialStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: borderColor,
                    ),
                  ))
          : null,
    );
  }

  static checkboxTile({
    required void Function(bool?)? onChanged,
    bool? value = false,
    required String title,
    String? subtitle,
  }) {
    final primay = Get.find<PWThemeController>().theme.colorScheme.primary;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        border: Border.all(color: primay),
        borderRadius: BorderRadius.circular(4),
      ),
      child: CheckboxListTile(
        value: value ?? false,
        activeColor: primay,
        onChanged: onChanged,
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
      ),
    );
  }

  static selectDropdown<T>({
    required String title,
    required T selectedValue,
    required List<T> list,
    required void Function(T?) onChanged,
    required Widget Function(T item) itemBuilder,
  }) {
    final primay = Get.find<PWThemeController>().theme.colorScheme.primary;
    return AnimatedContainer(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          border: Border.all(color: primay),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            DropdownButton<T>(
              underline: Container(),
              alignment: Alignment.centerRight,
              borderRadius: BorderRadius.circular(4),
              value: selectedValue,
              items: list.map((e) {
                return DropdownMenuItem<T>(
                  value: e,
                  child: itemBuilder(e),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ],
        ));
  }
}
