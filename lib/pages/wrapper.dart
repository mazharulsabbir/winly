import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winly/globals/configs/constans.dart';
import 'package:winly/pages/onboard_screen/onboard_screen.dart';
import 'package:winly/pages/root_screen/root_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            SharedPreferences? _pref = snapshot.data;
            bool _isFirstTimeLoading =
                _pref?.getBool(appFirstTimeLoadingKey) ?? true;

            debugPrint('_isFirstTimeLoading: $_isFirstTimeLoading');

            return _isFirstTimeLoading
                ? const OnBoardScreen()
                : const RootScreen();
          }

          return const SizedBox();
        });
  }
}
