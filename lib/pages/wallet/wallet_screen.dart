import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/models/wallet_model.dart';
import 'package:winly/pages/withdeaw/withdraw_screen.dart';
import 'package:winly/widgets/common_leading.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  _recentHistory(context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.3),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 5,
                width: 20,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
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
                  TextButton(onPressed: () {}, child: const Text('See all'))
                ],
              ),
              ...List.generate(
                WalletRecentActivityModel.activities.length,
                (index) => ListTile(
                  title: Text(
                    WalletRecentActivityModel.activities[index].title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .merge(const TextStyle(fontSize: 17)),
                  ),
                  subtitle: Text(
                      WalletRecentActivityModel.activities[index].subTitle),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(WalletRecentActivityModel
                        .activities[index].leadingIcon),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        WalletRecentActivityModel
                            .activities[index].trailingTitle,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        WalletRecentActivityModel
                            .activities[index].trailingSubtitle,
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
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
      body: SafeArea(
        child: Center(
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
                  '\$65,000',
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
                _recentHistory(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
