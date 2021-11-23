import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:winly/globals/controllers/terms_and_condition_controller.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_list_tile.dart';
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
            body: ListView.builder(
              itemCount: controller.termsAndCondition.length,
              itemBuilder: (context, index) => CommonListTile(
                title: "${controller.termsAndCondition[index].title}",
                details: "${controller.termsAndCondition[index].details}",
              ),
            ),
          ),
        );
      },
    );
  }
}
