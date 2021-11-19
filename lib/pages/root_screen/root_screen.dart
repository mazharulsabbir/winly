import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:winly/globals/configs/images.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/pages/login/login_screen.dart';
import 'package:winly/pages/nav_bar/bottom_nav_bar.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final AuthController authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    if (SchedulerBinding.instance != null) {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        if (authController.loggedIn) {
          Get.off(() => const BottomNavBar());
        } else {
          Get.off(() => const SignInScreen());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(appIconTransparent),
      ),
    );
  }
}
