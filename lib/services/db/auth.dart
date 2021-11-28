import 'dart:convert';

import 'package:flutter/foundation.dart';
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

  static String? getParentReferCode() {
    return _box.read<String>('parent_ref_code');
  }

  static void setParentReferCode({
    required String referCode
  }) {
    _box.write('parent_ref_code', referCode.toString());
  }

  static void removeParentReferCode() {
    _box.remove('parent_ref_code');
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

  static updateUserProfile(User? user) {
    if (user != null) {
      _box.write('user', jsonEncode(user.toJson()));
    }
  }

  static setUserEarning(DailyEarnings dailyEarnings) {
    _box.write('dailyEarnings', dailyEarnings.toJson());
  }

  static DailyEarnings? getEarning() {
    try {
      final earningRaw = _box.read('dailyEarnings');
      if (earningRaw != null) {
        dynamic _result;
        if (earningRaw.runtimeType == String) {
          _result = jsonDecode(earningRaw);
        } else {
          _result = earningRaw;
        }
        return DailyEarnings.fromJson(_result);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static void updateEarningStatus(DailyEarnings? dailyEarnings) {
    if (dailyEarnings != null) {
      User? _user = getUser();
      _user?.earnings = dailyEarnings;
      _box.write('user', jsonEncode(_user?.toJson()));
    }
  }
}
