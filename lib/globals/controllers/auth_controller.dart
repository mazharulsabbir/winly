import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/pages/login/login_screen.dart';
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/api/auth.dart';
import 'package:winly/services/db/auth.dart';

class AuthController extends GetxController {
  var loggedIn = false;
  User? user;
  String? token;
  bool isLoading = false;

  var mUserObx = User().obs;

  User get userObx {
    debugPrint("Printing new data" + mUserObx.value.toString());
    return mUserObx.value;
  }

  AuthController() {
    user = AuthDBService.getUser();
    token = AuthDBService.getToken();
    if (token != null && user != null) {
      mUserObx.value = user!;
      // print('token: $token');
      loggedIn = true;
    }
  }

  int adLimit() => AuthDBService.getAdLimit();

  void setAdLimit({required int limit}) {
    AuthDBService.setAdLimit(limit: limit);
    update();
  }

  Future<void> getUserProfile(String token) async {
    try {
      final _response = await AuthAPI.profile(token);

      user = User.fromJson(_response.data);
      if (user != null) {
        mUserObx.value = user!;

        if (user?.isSuspended != null && user?.isSuspended != "0") {
          logOut();
        } else {
          logIn(user!, token);
          // Setting External User Id with Callback Available in SDK Version 3.9.3+
          OneSignal.shared.setExternalUserId("${user!.id}").then((results) {
            debugPrint("One Signal: " + results.toString());
          }).catchError((error) {
            debugPrint("One Signal Error: " + error.toString());
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

  void updateUserEarnings(DailyEarnings? earnings) {
    AuthDBService.updateEarningStatus(earnings);
    User? user = AuthDBService.getUser();
    if (user != null) {
      this.user = user;
      mUserObx.value = user;
    }
  }

  void updateUserProfile(User? user) {
    debugPrint("***** Updating user profile *****");
    if (user != null) {
      AuthDBService.updateUserProfile(user);
      this.user = user;
      mUserObx.value = user;
      update();
    }
  }

  Future<dynamic> updateProfile({
    required String? name,
    required String? email,
    required String? phoneNumber,
  }) async {
    try {
      final response = await AuthAPI.updateProfile(
        token: token,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
      );

      if (response != null) {
        final data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          if (data['user'] != null) {
            User? _user = user?.copyWith(
              profileImage: data['user']['profile_image'],
              name: data['user']['name'],
              email: data['user']['email'],
              phoneNumber: data['user']['phone'],
            );

            updateUserProfile(_user);
            return Future.value(data['message']);
          } else {
            return Future.error(data['message']);
          }
        } else if (response.statusCode == 401) {
          if (data['error'] != null) {
            return Future.error(data['error']);
          } else if (data['errors'] != null) {
            String _errorMessage = "";

            Map<String, dynamic> _errors = data['errors'];
            _errors.forEach((key, value) {
              _errorMessage += "$value\n";
            });

            return Future.error(_errorMessage);
          } else {
            return Future.error(
              'Something unexpected happenned! Try again later.',
            );
          }
        } else if (response.statusCode == 422) {
          final data = jsonDecode(response.body);
          String _errorMessage = "";

          Map<String, dynamic> errors = data['errors'];
          errors.forEach((index, value) {
            _errorMessage += '$value\n';
          });

          return Future.error(_errorMessage);
        }
      } else {
        return Future.error(
          'Something unexpected happenned! Try again later.',
        );
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<dynamic> updateProfileImage({
    required XFile image,
  }) async {
    try {
      final response = await ApiService.postMultipart(
        "api/user",
        image,
        token: token,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['user'] != null) {
          User? _user = user?.copyWith(
            profileImage: data['user']['profile_image'],
            name: data['user']['name'],
            email: data['user']['email'],
            phoneNumber: data['user']['phone'],
          );

          updateUserProfile(_user);
          return Future.value(data['message']);
        } else {
          return Future.error(data['message']);
        }
      } else {
        String errorMessageBuilder = "";

        Map<String, dynamic> errors = response.data['errors'];

        errors.forEach((index, value) {
          errorMessageBuilder += '$value\n';
        });

        return Future.error(errorMessageBuilder);
      }
    } catch (_) {
      return Future.error(
        'Something unexpected happenned! Try again later.',
      );
    }
  }

  Future<void> logIn(User user, String token) async {
    AuthDBService.setUser(token: token, user: user);
    // AuthDBService.setUserEarning();
    this.user = user;
    mUserObx.value = user;

    this.token = token;
    loggedIn = true;
  }

  Future<bool> forgatePassword(email) async {
    isLoading = true;
    update();
    try {
      final response = await AuthAPI.sendForgetPassResquest(email);

      if (response != null) {
        final data = jsonDecode(response.body);
        if (data['error'] == null) {
          snack(
              title: 'Success',
              desc: 'An OPT has sent to the mail.',
              icon: const Icon(Icons.error));
          return true;
        } else {
          snack(
              title: 'Error',
              desc: data['error'],
              icon: const Icon(Icons.error));
          return false;
        }
      } else {
        snack(
            title: 'Error',
            desc: 'Something went wrong',
            icon: const Icon(Icons.error));
        return false;
      }
    } catch (e) {
      snack(title: 'Error', desc: e.toString(), icon: const Icon(Icons.error));
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<bool> setNewPassword({
    required String code,
    required String newPass,
  }) async {
    isLoading = true;
    update();
    try {
      final response = await AuthAPI.setNewPassword(code, newPass);

      if (response != null) {
        final data = jsonDecode(response.body);
        debugPrint("$data");
        if (data['errors'] == null || data['error'] == null) {
          return true;
        } else if (data['error'] == "Password Reset Successful") {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      snack(title: 'Error', desc: e.toString(), icon: const Icon(Icons.error));
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<dynamic> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    isLoading = true;
    update();
    try {
      final response = await AuthAPI.login(email: email, password: password);
      if (response != null) {
        final data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          final token = data['token'];
          final userDataRaw = await AuthAPI.me(token);

          if (userDataRaw != null) {
            try {
              final userParsed = jsonDecode(userDataRaw.body);
              final User user = User.fromJson(userParsed);
              mUserObx.value = user;

              String? _refCode = AuthDBService.getParentReferCode();
              if (_refCode != null) {
                AuthDBService.removeParentReferCode();
                AuthAPI.setReferCode(referCode: _refCode)
                    .onError((error, stackTrace) {
                  debugPrint(error.toString());
                });
              }

              logIn(user, token);
              return Future.value(user);
            } catch (e) {
              return Future.error(e.toString());
            }
          }
        } else if (response.statusCode == 401) {
          return Future.error(data['error']);
        } else {
          return Future.error(
            "There was something unexpected happened! Try again later.",
          );
        }
      } else {
        return Future.error(
          "There was something unexpected happened! Try again later.",
        );
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  int _loginCount = 0;

  Future<dynamic> loginWithSocialMedia({
    required String? name,
    required String? email,
    required String? profileImg,
  }) async {
    isLoading = true;
    update();
    try {
      final response = await AuthAPI.loginWithSocialMedia(
          name: name, email: email, profileImg: profileImg);
      if (response != null) {
        final data = jsonDecode(response.body);

        if (data['token'] == null && _loginCount == 0) {
          _loginCount++;
          return loginWithSocialMedia(
            name: name,
            email: email,
            profileImg: profileImg,
          );
        }

        if (response.statusCode == 200) {
          final token = data['token'];
          final userDataRaw = await AuthAPI.me(token);

          if (userDataRaw != null) {
            try {
              final userParsed = jsonDecode(userDataRaw.body);
              final User user = User.fromJson(userParsed);
              mUserObx.value = user;

              logIn(user, token);
              return Future.value(user);
            } catch (e) {
              return Future.error(e.toString());
            }
          }
        } else if (response.statusCode == 401) {
          return Future.error(data['error']);
        } else {
          return Future.error(
            "There was something unexpected happened! Try again later.",
          );
        }
      } else {
        return Future.error(
          "There was something unexpected happened! Try again later.",
        );
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final String? name = googleUser?.displayName;
      final String? email = googleUser?.email;
      final String? profileImg = googleUser?.photoUrl;

      dynamic _response = await loginWithSocialMedia(
        name: name,
        email: email,
        profileImg: profileImg,
      );

      if (_response != null) {
        try {
          return Future.value(_response);
        } catch (e) {
          return Future.error(e.toString());
        }
      }
    } catch (e) {
      return Future.error("Login failed! $e");
    }
  }

  Future<dynamic> signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final String? name = userData['name'];
      final String? email = userData['email'];
      final String? profileImg = userData["picture"]["data"]["url"];

      dynamic _response = await loginWithSocialMedia(
        name: name,
        email: email,
        profileImg: profileImg,
      );

      if (_response != null) {
        try {
          return Future.value(_response);
        } catch (e) {
          return Future.error(e.toString());
        }
      }
    } catch (e) {
      return Future.error("Login failed! $e");
    }
  }

  Future<void> logOut() async {
    //usually called after the user logs out of your app
    OneSignal.shared.removeExternalUserId();

    loggedIn = false;
    user = null;
    token = null;
    AuthDBService.removeUser();
    FirebaseAuth.instance.signOut();
    // go to sign-in screen
    Get.offAll(const SignInScreen());

    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
  }
}
