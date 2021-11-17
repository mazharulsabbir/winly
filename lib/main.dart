import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:winly/globals/configs/themes.dart';
import 'package:winly/pages/onboard_screen/onboard_screen.dart';
import 'package:winly/pages/signup/signup_screen.dart';
import 'globals/bindings.dart';
import 'globals/configs/constans.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      home: const OnBoardScreen(),
      initialBinding: GlobalBindings(),
      theme: MyAppThemes.lightTheme,
      darkTheme: MyAppThemes.darkTheme,
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(
            300,
            name: MOBILE,
            scaleFactor: .90,
          ),
          ResponsiveBreakpoint.resize(
            450,
            name: MOBILE,
          ),
          ResponsiveBreakpoint.autoScale(
            800,
            name: TABLET,
            scaleFactor: 1.10,
          ),
          ResponsiveBreakpoint.autoScale(
            1000,
            name: TABLET,
            scaleFactor: 1.25,
          ),
          ResponsiveBreakpoint.resize(
            1200,
            name: DESKTOP,
            scaleFactor: 1.40,
          ),
        ],
      ),
    );
  }
}
