import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:winly/globals/configs/themes.dart';
import 'package:winly/pages/wrapper.dart';

import 'globals/bindings.dart';
import 'globals/configs/constans.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  if (kDebugMode) {
    FacebookAudienceNetwork.init(
      testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
    );
  } else {
    FacebookAudienceNetwork.init();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      home: const Wrapper(),
      initialBinding: GlobalBindings(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        backgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
      ),
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
