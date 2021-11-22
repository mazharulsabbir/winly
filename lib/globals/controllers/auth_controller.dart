import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/pages/login/login_screen.dart';
import 'package:winly/services/api/auth.dart';
import 'package:winly/services/db/auth.dart';

class AuthController extends GetxController {
  var loggedIn = false;
  User? user;
  String? token;
  bool isLoading = false;

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

  Future<bool> forgatePassword(email) async {
    isLoading = true;
    update();
    try {
      final response = await AuthAPI.sendForgetPassResquest(email);

      if (response != null) {
        final data = jsonDecode(response.body);
        print(data);
        if (data['error'] == null) {
          snack(
              title: 'Success',
              desc: 'An OPT has sent to the mail.',
              icon: const Icon(Icons.error));
          return true;
        } else {
          snack(
              title: 'Erorr',
              desc: data['error'],
              icon: const Icon(Icons.error));
          return false;
        }
      } else {
        snack(
            title: 'Erorr',
            desc: 'Some thing went wrong',
            icon: const Icon(Icons.error));
        return false;
      }
    } catch (e) {
      snack(title: 'Erorr', desc: e.toString(), icon: const Icon(Icons.error));
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => value.user != null);
  }

  Future<bool> signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      if (loginResult.accessToken?.token != null) {
        debugPrint(loginResult.accessToken?.token);
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential)
            .then((value) => value.user != null);
      } else {
        debugPrint('Token not found!');
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  void logOut() {
    //usually called after the user logs out of your app
    OneSignal.shared.removeExternalUserId();

    loggedIn = false;
    user = null;
    token = null;
    AuthDBService.removeUser();
    FirebaseAuth.instance.signOut();
    // todo: go to signin screen
    Get.offAll(const SignInScreen());
  }
}
