import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pw/pw.dart';
import 'package:pw/pwthemecontroller.dart';

class PWController extends PWThemeController {
  // loading
  bool loading = true;

  // start loading
  startLoading() {
    loading = true;
    update();
  }

  // stop loading
  stopLoading() {
    loading = false;
    update();
  }

  // Abre a tela no dialog simulando uma nova tela
  Future<T> openPage<T>(Widget iten) async {
    // Abre a tela
    return await showDialog(
      context: Get.overlayContext!,
      builder: (context) => iten,
    );
  }

  void closePage<T>() {
    // Fecha a tela
    return Get.back<T>();
  }

  showSelector<T>(
      {required String title,
      required List<T> items,
      required Widget Function(T item) itemBuilder}) {
    // Mostra o selector
    return showDialog<T>(
      context: Get.overlayContext!,
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

  showCustomDialog<T>({required String title, required child}) {
    // Mostra o dialog
    return showDialog<T>(
      // title: title,
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (context) => child,
      // builder: (context) => AlertDialog(
      //   title: Text(title),
      //   content: child,
      //   actionsAlignment: MainAxisAlignment.center,
      //   actions: [
      //     PW.button(
      //       title: 'Ok',
      //       onPressed: () => Get.back(),
      //     ),
      //   ],
      // ),
    );
  }
}
