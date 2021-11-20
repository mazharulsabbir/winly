import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/pages/login/login_screen.dart';
import 'package:winly/services/api/auth.dart';
import 'package:winly/services/db/auth.dart';

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
          // Setting External User Id with Callback Available in SDK Version 3.9.3+
          OneSignal.shared.setExternalUserId("${user!.id}").then((results) {
            debugPrint(results.toString());
          }).catchError((error) {
            debugPrint(error.toString());
          });
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
    //usually called after the user logs out of your app
    OneSignal.shared.removeExternalUserId();

    loggedIn = false;
    user = null;
    token = null;
    AuthDBService.removeUser();
    // todo: go to signin screen
    Get.offAll(const SignInScreen());
  }
}
