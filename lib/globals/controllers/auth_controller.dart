import 'package:get/get.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/services/db/auth.dart';

class AuthController extends GetxController {
  var loggedIn = false;
  User? user;
  String? token;

  AuthController() {
    user = AuthDBService.getUser();
    token = AuthDBService.getToken();

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

  void logIn(User user, String token) {
    AuthDBService.setUser(token: token, user: user);
    // AuthDBService.setUserEarning();
    this.user = user;

    this.token = token;
    loggedIn = true;

    update();
  }

  void logOut() {
    this.loggedIn = false;
    this.user = null;
    this.token = null;
    AuthDBService.removeUser();
    // todo: go to signin screen
    // Get.offAll(SignInScreen());
  }
}
