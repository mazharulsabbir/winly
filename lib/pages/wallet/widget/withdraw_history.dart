import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/withdraw_controller.dart';
import 'package:winly/pages/wallet/widget/withdraw_history_list_builder.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class WithdrawHistoryWidget extends StatelessWidget {
  const WithdrawHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawController>(
      init: WithdrawController(),
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 5,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent history',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  TextButton(onPressed: () {}, child: const Text('See all')),
                ],
              ),
              Expanded(
                child: CommonLoadingOverlay(
                  loading: controller.isLoading.value,
                  child: WithdrawHistoryListBuilder(
                    withdraws: controller.withdraws,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
