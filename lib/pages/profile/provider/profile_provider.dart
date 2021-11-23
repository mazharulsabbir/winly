import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/services/db/auth.dart';

final profileChangeNotifierProvider = ChangeNotifierProvider((ref) {
  final _user = AuthDBService.getUser();

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
