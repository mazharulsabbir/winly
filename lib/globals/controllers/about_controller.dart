import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/db/auth.dart';

class AboutController extends getx.GetxController {
  String? token;
  bool isLoading = false;

  String? about;

  AboutController() {
    token = AuthDBService.getToken();
    getApplicationInfo();
  }

  Future<void> getApplicationInfo() async {
    isLoading = true;
    update();

    try {
      final _response = await ApiService.get(
        "api/about",
        token: token,
      );

      if (_response != null && _response.data != null) {
        about = _response.data['message'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    update();
  }
}
