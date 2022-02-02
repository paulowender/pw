import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PWController extends GetxController {
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
}
