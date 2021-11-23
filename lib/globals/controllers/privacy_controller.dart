import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:winly/models/privacy_policy.dart';
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/db/auth.dart';

class PrivacyController extends getx.GetxController {
  String? token;
  bool isLoading = false;

  List<PrivacyPolicy> privacyPolicy = [];

  PrivacyController() {
    token = AuthDBService.getToken();
    getPrivacyPolicy();
  }

  Future<void> getPrivacyPolicy() async {
    isLoading = true;
    update();

    try {
      final _response = await ApiService.get(
        "api/privacy",
        token: token,
      );

      if (_response != null && _response.data != null) {
        List<dynamic> _data = _response.data;
        _data.forEach((element) {
          PrivacyPolicy _p = PrivacyPolicy.fromJson(element);
          privacyPolicy.add(_p);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    update();
  }
}
