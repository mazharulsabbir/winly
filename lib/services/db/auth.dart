import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:winly/models/auth/user_model.dart';

final _box = GetStorage();

class AuthDBService {
  static void setAdLimit({required int limit}) {
    _box.write('ad_limit', limit);
  }

  static int getAdLimit() => _box.read('ad_limit') ?? 0;

  static void setUser({
    required String token,
    required User user,
  }) {
    _box.write('token', token);
    _box.write('user', jsonEncode(user.toJson()));
  }

  static void removeUser() {
    _box.remove('token');
    _box.remove('user');
  }

  static String? getToken() {
    return _box.read<String>('token');
  }

  static User? getUser() {
    final raw = _box.read<String>('user');
    if (raw != null) {
      return User.fromJson(jsonDecode(raw));
    } else {
      return null;
    }
  }

  static setUserEarning(DailyEarnings dailyEarnings) {
    _box.write('dailyEarnings', dailyEarnings.toJson());
  }

  static DailyEarnings? getEarning() {
    try {
      final earningRaw = _box.read('dailyEarnings');
      if (earningRaw != null) {
        var _result;
        if (earningRaw.runtimeType == String) {
          _result = jsonDecode(earningRaw);
        } else {
          _result = earningRaw;
        }
        return DailyEarnings.fromJson(_result);
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static void updateEarningStatus(DailyEarnings dailyEarnings) =>
      _box.write('dailyEarnings', jsonEncode(dailyEarnings.toJson()));
}
