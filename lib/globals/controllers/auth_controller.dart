import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/pages/login/login_screen.dart';
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/api/auth.dart';
import 'package:winly/services/db/auth.dart';

import 'dart:convert' as convert;

class AuthController extends GetxController {
  var loggedIn = false;
  User? user;
  String? token;

  AuthController() {
    user = AuthDBService.getUser();
    token = AuthDBService.getToken();

    if (token != null) {
      getUserProfile(token!);
    }

    if (token != null && user != null) {
      // print('token: $token');
      loggedIn = true;
    }
  }

  int adLimit() => AuthDBService.getAdLimit();

  void setAdLimit({required int limit}) {
    AuthDBService.setAdLimit(limit: limit);
    update();
  }

  void getUserProfile(String token) async {
    try {
      final _response = await AuthAPI.profile(token);
      user = User.fromJson(_response.data);
      if (user != null) {
        if (user?.isSuspended != null && user?.isSuspended != 0) {
          logOut();
          // snack(
          //   title: 'Profile Suspended!',
          //   desc:
          //       'Your profile has been suspended! Please contact with customer care.',
          //   icon: const Icon(Icons.block),
          // );
        } else {
          logIn(user!, token);
          loggedIn = true;
        }
      } else {
        logOut();
      }
    } catch (e) {
      // print(e);
      logOut();
    }
  }

  void logIn(User user, String token) {
    AuthDBService.setUser(token: token, user: user);
    // AuthDBService.setUserEarning();
    this.user = user;

    this.token = token;
    loggedIn = true;

    update();
  }

  void logOut() {
    loggedIn = false;
    user = null;
    token = null;
    AuthDBService.removeUser();
    // todo: go to signin screen
    Get.offAll(const SignInScreen());
  }
}
