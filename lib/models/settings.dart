import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/auth_controller.dart';

class SettingsModel {
  final String title;
  final IconData iconData;
  final Color leadingBackC;
  Function()? onTap;

  SettingsModel(
      {required this.title,
      required this.leadingBackC,
      required this.iconData,
      this.onTap});

  static List<SettingsModel> settings = [
    SettingsModel(
        title: 'Account', leadingBackC: Colors.blue, iconData: Icons.person),
    SettingsModel(
        title: 'Notifications',
        leadingBackC: Colors.orange,
        iconData: Icons.notifications),
    SettingsModel(
        title: 'Security',
        leadingBackC: Colors.green,
        iconData: Icons.settings),
    SettingsModel(
        title: 'Privacy', leadingBackC: Colors.redAccent, iconData: Icons.lock),
    SettingsModel(
        title: 'About WinlLy',
        leadingBackC: Colors.blue,
        iconData: Icons.calendar_view_day),
    SettingsModel(
        title: 'Sign out',
        leadingBackC: Colors.redAccent,
        iconData: PhosphorIcons.sign_out,
        onTap: () {
          final AuthController authController = Get.find<AuthController>();
          authController.logOut();
        })
  ];
}
