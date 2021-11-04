import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:winly/globals/controllers/theme_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
  }
}
