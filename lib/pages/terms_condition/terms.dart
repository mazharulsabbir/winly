import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:winly/globals/controllers/terms_and_condition_controller.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TermsAndConditionController>(
      init: TermsAndConditionController(),
      builder: (controller) {
        return CommonLoadingOverlay(
          loading: controller.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Terms and Conditions'),
              leading: const CommonLeading(),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "${controller.termsAndCondition}",
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
