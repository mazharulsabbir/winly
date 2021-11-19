import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/globals/controllers/one_signal_controller.dart';
import 'package:winly/globals/controllers/theme_controller.dart';
import 'package:winly/globals/controllers/withdraw_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController());
    Get.put(OneSignalController());
    Get.put(WithdrawController());
  }
}
