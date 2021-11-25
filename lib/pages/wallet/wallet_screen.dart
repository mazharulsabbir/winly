import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/globals/controllers/withdraw_controller.dart';
import 'package:winly/pages/withdeaw/withdraw_screen.dart';
import 'package:winly/widgets/common_leading.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool islOading = false;
  AuthController authController = Get.find<AuthController>();
  _recentHistoryList() {
    return GetBuilder<WithdrawController>(
        init: WithdrawController(),
        builder: (controller) {
          return LoadingOverlay(
              isLoading: controller.isLoading.value,
              child: (controller.withdraws.isEmpty)
                  ? const Center(
                      child: Text('No withdraw to show'),
                    )
                  : ListView.builder(
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text(
                            'Cash out',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .merge(const TextStyle(fontSize: 17)),
                          ),
                          subtitle: Text(
                              controller.withdraws[index].createdAt.toString()),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(PhosphorIcons.share),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                controller.withdraws[index].amount ?? '0',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Dhaka',
                                style: Theme.of(context).textTheme.subtitle1,
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: controller.withdraws.length,
                      shrinkWrap: true,
                    ));
        });
  }

  _recentHistoryPart(
    context,
  ) {
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
          Expanded(child: _recentHistoryList())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: const CommonLeading(),
          centerTitle: true,
          title: const Text('Wallet'),
          elevation: 0,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Your balance',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '৳ ${authController.user?.earnings?.totalBalance ?? 0}',
                  style: Theme.of(context).textTheme.headline4!
                  // .copyWith(color: Colors.black)
                  ,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const WithDrawScreen());
                  },
                  child: Text(
                    'Withdraw',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.5, 40),
                      primary: Colors.grey.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0.0),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Spacer(),
                // _recentHistoryList()
                _recentHistoryPart(context)
              ],
            ),
          ),
        ));
  }
}
