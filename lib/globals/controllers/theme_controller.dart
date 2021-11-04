import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/services/db.dart';

class ThemeController extends GetxController {
  ThemeController() {
    isDarkMode.value = ThemeServiceDB.getDarkModeValue();
    update();
    print('initial theme value $isDarkMode');
    setMode(isDarkMode.value);
  }
  var isDarkMode = false.obs;

  void setMode(bool isDark) {
    if (isDark) {
      Get.changeThemeMode(ThemeMode.dark);
      ThemeServiceDB.setDarkModeValue(true);
      isDarkMode.value = true;
      update();
      print('Applied for dark mode');
    } else {
      Get.changeThemeMode(ThemeMode.light);
      ThemeServiceDB.setDarkModeValue(false);
      print('Applied for light mode');
      isDarkMode.value = false;
      update();
    }
  }
}
