import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:winly/globals/controllers/privacy_controller.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivacyController>(
      init: PrivacyController(),
      builder: (controller) {
        return CommonLoadingOverlay(
          loading: controller.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Privacy Policy'),
              leading: const CommonLeading(),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "${controller.privacyPolicy}",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
