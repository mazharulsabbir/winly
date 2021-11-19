import 'package:get/get.dart';
import 'package:flutter/material.dart';

void snack({
  required String title,
  required String desc,
  required Icon icon,
}) {
  Get.snackbar(
    title,
    desc,
    icon: icon,
    snackPosition: SnackPosition.BOTTOM,
  );
}
