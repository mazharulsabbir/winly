import 'package:flutter/material.dart';
import 'package:winly/globals/controllers/faq_controller.dart';
import 'package:get/get.dart';
import 'package:winly/pages/faq/widget/fqa_item.dart';
import 'package:winly/widgets/common_appbar.dart';
import 'package:winly/widgets/common_loading_overly.dart';
import 'package:winly/widgets/empty_list.dart';

class FQATab extends StatelessWidget {
  const FQATab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaqController>(
        init: FaqController(),
        builder: (controller) {
          return CommonLoadingOverlay(
            loading: controller.isLoading,
            child: Scaffold(
              appBar: buildCommonAppbar(),
              body: controller.faqItems.isEmpty
                  ? const CommonEmptyScreenWidget()
                  : RefreshIndicator(
                      onRefresh: () async {
                        return await controller.getFaqs();
                      },
                      child: ListView.builder(
                        itemCount: controller.faqItems.length,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemBuilder: (context, index) => FqaItemWidget(
                          faqItem: controller.faqItems[index],
                        ),
                      ),
                    ),
            ),
          );
        });
  }
}
