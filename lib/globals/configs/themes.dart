import 'package:flutter/material.dart';
import 'package:winly/globals/configs/colors.dart';

class MyAppThemes {
  static ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: Colors.white,
      accentColor: Colors.black,
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Paints.backGroundColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(color: Colors.black),
          unselectedLabelStyle: const TextStyle(color: Colors.red),
          backgroundColor: Paints.backGroundColor),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.black,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ));

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      textTheme: const TextTheme(subtitle2: TextStyle(color: Colors.red)));
}
