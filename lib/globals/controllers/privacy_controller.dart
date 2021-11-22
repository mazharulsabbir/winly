import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/db/auth.dart';

class PrivacyController extends getx.GetxController {
  String? token;
  bool isLoading = false;

  String? privacyPolicy;

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
        privacyPolicy = _response.data['message'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    update();
  }
}
