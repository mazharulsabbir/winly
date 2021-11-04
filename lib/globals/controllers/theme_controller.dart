import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  ThemeController() {
    isDarkMode.value = Get.isDarkMode;
    print('initial theme value $isDarkMode');
    changeTheme(isDarkMode.value);

    update();
  }
  var isDarkMode = false.obs;
  void changeTheme(bool isDark) {
    if (isDark) {
      Get.changeThemeMode(ThemeMode.light);
      isDarkMode.value = false;
      update();
      print('Applied for light mode');
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      print('Applied for dark mode');
      isDarkMode.value = true;
      update();
    }
  }
}
