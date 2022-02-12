import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pw/pw.dart';

class PWController extends PWThemeController {
  // Tela aberta na direita
  Widget? openedMenu;
  String openedMenuName = "";

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

  // is menu opened
  bool isMenuOpened(String menu) => openedMenuName == menu;

  // set page opened
  void openMenu(Widget menu, String name) {
    if (!isMenuOpened(name)) {
      openedMenu = menu;
      openedMenuName = name;
      update();
    }
  }

  // close page opened
  void closeMenu() {
    openedMenu = null;
    openedMenuName = "";
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
    Get.back<T>();
  }
}
