import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:winly/models/about.dart';
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/db/auth.dart';

class AboutController extends getx.GetxController {
  String? token;
  bool isLoading = false;

  List<AboutUs> about = [];

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
        List<dynamic> _data = _response.data;
        for (var element in _data) {
          AboutUs _a = AboutUs.fromJson(element);
          about.add(_a);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    update();
  }
}
