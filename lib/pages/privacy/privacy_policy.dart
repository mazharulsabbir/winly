import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:winly/globals/controllers/privacy_controller.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_list_tile.dart';
import 'package:winly/widgets/common_loading_overly.dart';
import 'package:winly/widgets/empty_list.dart';

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
            body: controller.privacyPolicy.isEmpty
                ? const CommonEmptyScreenWidget()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: controller.privacyPolicy.length,
                    itemBuilder: (context, index) => CommonListTile(
                      title: "${controller.privacyPolicy[index].title}",
                      details: "${controller.privacyPolicy[index].details}",
                    ),
                  ),
          ),
        );
      },
    );
  }
}
