import 'dart:math';

import 'package:flutter/material.dart';
import 'package:winly/models/wallet_model.dart';
import 'package:winly/widgets/common_leading.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  appBarLeading() {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      margin: const EdgeInsets.only(right: 30, bottom: 12, top: 12),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10)),
      height: 10,
      width: 80,
      child: Row(
        children: const [
          Text(
            'USD',
            style: TextStyle(color: Colors.black45),
          ),
          Icon(
            Icons.arrow_downward_sharp,
            color: Colors.black45,
          )
        ],
      ),
    );
  }

  _recentHistory(context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
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
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent history',
                  style: Theme.of(context).textTheme.bodyText1,
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
                subtitle:
                    Text(WalletRecentActivityModel.activities[index].subTitle),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)]
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                      WalletRecentActivityModel.activities[index].leadingIcon),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      WalletRecentActivityModel.activities[index].trailingTitle,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        leading: const CommonLeading(),
        centerTitle: true,
        title: Text(
          'Wallet',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [appBarLeading()],
        backgroundColor: Colors.transparent,
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
                  'Your balace',
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
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
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
