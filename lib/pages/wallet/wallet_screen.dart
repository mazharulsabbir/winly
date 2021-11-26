import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/pages/wallet/widget/withdraw_history.dart';
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

  @override
  void initState() {
    super.initState();
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
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.grey,
                      ),
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
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.5,
                      40,
                    ),
                    primary: Colors.grey.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0.0,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Spacer(),
                const WithdrawHistoryWidget(),
              ],
            ),
          ),
        ));
  }
}
