import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/services/db/auth.dart';
import 'package:get/get.dart';

final futureProvider = FutureProvider((ref) => []);

final profileChangeNotifierProvider = ChangeNotifierProvider((ref) {
  final _user = AuthDBService.getUser();

  AuthController _authController = Get.find<AuthController>();
  _authController.getUserProfile(_authController.token!).then((value) {
    debugPrint("=== Profile Change Notifier Provider Updated ===");
    final _user = AuthDBService.getUser();
    print(_user.toString());
    return ProfileChangeNotifier(_user);
  });

  debugPrint("=== Profile Change Notifier Provider ===");
  return ProfileChangeNotifier(_user);
});

class ProfileChangeNotifier extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  ProfileChangeNotifier(User? user) {
    _user = user;
  }

  void updateUser(User user) {
    _user = user;
    notifyListeners();
  }

  void updateUserEarnings(DailyEarnings? earnings) {
    if (earnings != null) {
      _user!.earnings = earnings;
      notifyListeners();
    }
  }
}
