import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winly/services/db.dart';

final _box = GetStorage();

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  ThemeController() {
    isDarkMode.value = ThemeServiceDB.getDarkModeValue();
    setMode(isDarkMode.value);
  }

  void setMode(bool isDark) {
    if (isDark) {
      Get.changeThemeMode(ThemeMode.dark);
      ThemeServiceDB.setDarkModeValue(true);
      isDarkMode.value = true;
      update();
    } else {
      Get.changeThemeMode(ThemeMode.light);
      ThemeServiceDB.setDarkModeValue(false);
      isDarkMode.value = false;
      update();
    }
  }
}
