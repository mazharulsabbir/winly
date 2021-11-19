import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:winly/models/withdraws.dart';
import 'package:winly/services/api/withdraw.dart';
import 'package:winly/services/db/auth.dart';

class WithdrawController extends GetxController {
  var isLoading = false.obs;
  List<Withdraw> withdraws = [];
  String? token = AuthDBService.getToken();

  @override
  void onInit() {
    _getWithdrawTimeline();
    super.onInit();
  }

  Future<void> _getWithdrawTimeline() async {
    if (token == null) {
      return;
    }

    isLoading.value = true;

    WithdrawAPI.withdraws(token!).catchError((_) {
      isLoading.value = false;
      update();
    }).then((response) {
      isLoading.value = false;

      if (response != null) {
        dynamic result = convert.jsonDecode(response.body);
        // debugPrint(result.toString());
        WithdrawHistory _history = WithdrawHistory.fromJson(result);

        if (_history.withdraws != null) {
          withdraws = _history.withdraws!;
        }
      }

      update();
    });
  }
}
