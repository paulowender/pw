library pw;

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pw/pwconfig.dart';
import 'package:pw/pwerrorlog.dart';

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
  final Widget Function(BuildContext, Widget) builder;
  final ThemeData themeLight;
  final ThemeData themeDark;
  final bool initModeDark;

  static get close => Get.back;

  const PW({
    Key key,
    this.title = PWConfig.appName,
    @required this.home,
    this.builder,
    this.themeLight,
    this.themeDark,
    this.initModeDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PWThemeController>(
      init: PWThemeController(isDark: initModeDark),
      builder: (controller) {
        return GetMaterialApp(
          theme: controller.isDark
              ? themeDark ?? controller.theme
              : themeLight ?? controller.theme,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.rightToLeftWithFade,
          title: title,
          home: home,
          builder: builder,
          onInit: EasyLoading.init,
        );
      },
    );
  }

  // BUTTON
  static Tooltip button({
    @required String title,
    String tooltip,
    Color color,
    Color borderColor,
    @required void Function() onPressed,
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
    @required String title,
    @required void Function() onPressed,
  }) {
    return TextButton(
      child: Text(title),
      onPressed: onPressed,
    );
  }

  // TEXTBUTTON
  static TextButton buttonTextWithIcon({
    @required String title,
    @required Icon icon,
    @required void Function() onPressed,
  }) {
    return TextButton.icon(
      label: Text(title),
      icon: icon,
      onPressed: onPressed,
    );
  }

  // BUTTON WITH ICON
  static ElevatedButton buttonWithIcon({
    @required String title,
    @required IconData icon,
    @required void Function() onPressed,
    Color color,
  }) {
    return ElevatedButton.icon(
      style: buttonStyle(color: color),
      label: Text(title),
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }

  // BUTTON WITH CONFIRM
  static Widget buttonWithConfirm(
    BuildContext context, {
    @required String title,
    String content = 'Deseja realmente executar esta ação?',
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    Color confirmColor = Colors.red,
    Color cancelColor = Colors.grey,
    @required Function onConfirm,
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

  // BUTTON WITH CONFIRM
  static Widget buttonWithConfirmIcon(
    BuildContext context, {
    @required String title,
    String content = 'Deseja realmente executar esta ação?',
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    Color confirmColor = Colors.red,
    Color cancelColor = Colors.grey,
    @required Function onConfirm,
    IconData icon = Icons.check,
  }) {
    return buttonWithIcon(
        title: title,
        icon: icon,
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
    String title = 'Confirmar',
    String content = '',
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    Color confirmColor = Colors.red,
    Color cancelColor = const Color.fromARGB(255, 56, 56, 56),
    @required Function onConfirm,
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
                Navigator.of(context).pop(true);
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  // CONFIRM DIALOG
  static Future<bool> messageDialog(
    BuildContext context, {
    String title = 'Atenção',
    String content = '',
    String confirmText = 'OK',
    Color confirmColor = Colors.red,
    @required Function onConfirm,
    bool dismissible = true,
  }) async {
    var confirmStyle =
        ButtonStyle(backgroundColor: MaterialStateProperty.all(confirmColor));
    return await showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) {
        return AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: Text(content, textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            ElevatedButton(
              style: confirmStyle,
              child: Text(confirmText),
              onPressed: () {
                Navigator.of(context).pop(true);
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  // INPUT FORM FIELD
  static Widget textField<T>({
    String label = '',
    String initialValue = '',
    void Function(String value) onSubmited,
    void Function(String value) onChanged,
    TextEditingController controller,
    bool required = false,
    Widget suffix,
    int maxLines = 1,
    bool readOnly = false,
    bool obscureText = false,
    String errorText,
  }) {
    final primary = Get.find<PWThemeController>().theme.colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller ?? TextEditingController(text: initialValue),
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: primary,
            ),
          ),
          suffix: suffix,
        ),
        onFieldSubmitted: onSubmited,
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        readOnly: readOnly == true,
        obscureText: obscureText == true,
        autovalidateMode: required == true ? AutovalidateMode.always : null,
        validator: (value) {
          if (required && value == '') {
            return errorText ?? 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }

  // INPUT FORM FIELD
  static Widget formField<T>(
    String label,
    String initialValue,
    void Function(String value) onSubmited, {
    TextEditingController controller,
    bool required = false,
    Widget suffix,
    int maxLines = 1,
    int maxLength,
    bool readOnly = false,
  }) {
    final primary = Get.find<PWThemeController>().theme.colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller ?? TextEditingController(text: initialValue),
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: primary,
            ),
          ),
          suffix: suffix,
        ),
        onFieldSubmitted: onSubmited,
        textInputAction: TextInputAction.next,
        readOnly: onSubmited == null || readOnly == true,
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
    String label,
    String initialValue,
    void Function(int value) onSubmited, {
    TextEditingController controller,
    bool required = false,
    Widget suffix,
    int maxLines = 1,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller ?? TextEditingController(text: initialValue),
        maxLines: maxLines,
        readOnly: onSubmited == null || readOnly == true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: primary,
            ),
          ),
        ),
        onFieldSubmitted: (value) {
          if (onSubmited != null) {
            PWUtils.isNumber(value)
                ? onSubmited(int.parse(value))
                : EasyLoading.showToast('Valor inválido');
          }
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
    @required IconData icon,
    String tooltip,
    Color color,
    @required void Function() onPressed,
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
    @required IconData icon,
    String title = 'Confirmação',
    String content = 'Deseja realmente executar esta ação?',
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    Color confirmColor = Colors.red,
    Color cancelColor = const Color.fromARGB(255, 41, 41, 41),
    @required Function onConfirm,
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

  static buttonStyle({Color color, Color borderColor}) {
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

  static container({
    @required Widget child,
    Color color,
    Color borderColor,
    EdgeInsets padding,
    EdgeInsets margin,
  }) {
    final primay = Get.find<PWThemeController>().theme.colorScheme.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: margin ?? const EdgeInsets.all(4),
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor ?? primay),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }

  static checkboxTile({
    @required void Function(bool) onChanged,
    double width,
    bool value = false,
    @required String title,
    String subtitle,
    bool decorate = true,
  }) {
    final primay = Get.find<PWThemeController>().theme.colorScheme.primary;

    _buidSubtitle(subtitle) {
      if (subtitle == null) return null;
      if (subtitle == '') return null;
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: width,
      decoration: decorate
          ? BoxDecoration(
              border: Border.all(color: primay),
              borderRadius: BorderRadius.circular(4),
            )
          : null,
      child: title != ''
          ? CheckboxListTile(
              value: value ?? false,
              activeColor: primay,
              onChanged: onChanged,
              title: Text(title),
              subtitle: _buidSubtitle(subtitle),
            )
          : Checkbox(value: value, onChanged: onChanged, activeColor: primay),
    );
  }

  static selectDropdown<T>({
    @required String title,
    @required T selectedValue,
    @required List<T> list,
    @required void Function(T) onChanged,
    @required Widget Function(T item) itemBuilder,
  }) {
    final primay = Get.find<PWThemeController>().theme.colorScheme.primary;
    try {
      if (list.isEmpty) return Container();
      if (list.length == 1) return itemBuilder(list.first);
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
    } catch (e) {
      PWErrorLog.logError('PWDropdown Error $e');
      return Container();
    }
  }

  static inputDialog({
    @required String title,
    @required List<InputDialog> inputs,
    @required List<Tooltip> actions,
  }) {
    final primay = Get.find<PWThemeController>().theme.colorScheme.primary;
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: inputs.map((inputDialog) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TextFormField(
              controller: inputDialog.controller,
              decoration: InputDecoration(
                labelText: inputDialog.hintText,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primay,
                  ),
                ),
              ),
              onFieldSubmitted: (value) {
                inputDialog.validator(value);
              },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
          );
        }).toList(),
      ),
    );
  }

  static Future<T> showSelector<T>({
    @required String title,
    @required List<T> items,
    @required Widget Function(T item) itemBuilder,
  }) {
    // Mostra o selector
    return showDialog<T>(
      context: Get.overlayContext,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: items.map((item) => itemBuilder(item)).toList(),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          PW.button(
            title: 'Ok',
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  static Widget buildInfo(String text, String tooltip, {IconData icon}) {
    return Tooltip(
      message: tooltip,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            if (icon != null) Icon(icon),
            const SizedBox(width: 8),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildInfoExpanded(String text, String tooltip,
      {int flex = 1, IconData icon}) {
    return Expanded(
      flex: flex,
      child: Tooltip(
        message: tooltip,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (icon != null) Icon(icon),
              const SizedBox(width: 8),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputDialog {
  InputDialog({
    this.initialText,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.prefixText,
    this.suffixText,
    this.minLines,
    this.maxLines = 1,
    @required this.controller,
  });
  final String initialText;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final String prefixText;
  final String suffixText;
  final int minLines;
  final int maxLines;
  final TextEditingController controller;
}
