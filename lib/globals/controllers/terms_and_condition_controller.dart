import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:winly/models/terms_and_condition.dart';
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/db/auth.dart';

class TermsAndConditionController extends getx.GetxController {
  String? token;
  bool isLoading = false;

  List<TermsAndCondition> termsAndCondition = [];

  TermsAndConditionController() {
    token = AuthDBService.getToken();
    getTermsAndConditions();
  }

  Future<void> getTermsAndConditions() async {
    isLoading = true;
    update();

    try {
      final _response = await ApiService.get(
        "api/terms",
        token: token,
      );

      if (_response != null && _response.data != null) {
        List<dynamic> _data = _response.data;
        _data.forEach((element) {
          TermsAndCondition _tc = TermsAndCondition.fromJson(element);
          termsAndCondition.add(_tc);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    update();
  }
}
