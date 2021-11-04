import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:winly/pages/nav_bar/bottom_nav_bar.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    super.initState();
    if (SchedulerBinding.instance != null) {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        Get.to(() => const BottomNavBar());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Root screen'),
      ),
    );
  }
}
