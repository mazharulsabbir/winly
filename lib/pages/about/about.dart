import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:winly/globals/configs/constans.dart';
import 'package:winly/globals/controllers/about_controller.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_list_tile.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutController>(
      init: AboutController(),
      builder: (controller) {
        return CommonLoadingOverlay(
          loading: controller.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('About $appName'),
              leading: const CommonLeading(),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: controller.about.length,
              itemBuilder: (context, index) => CommonListTile(
                title: "${controller.about[index].title}",
                details: "${controller.about[index].details}",
              ),
            ),
          ),
        );
      },
    );
  }
}
