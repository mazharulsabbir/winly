import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:winly/globals/configs/constans.dart';

class CommonEmptyScreenWidget extends StatelessWidget {
  const CommonEmptyScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Lottie.asset(Lotties.noItem),
          ),
          const Text('Nothing to show!')
        ],
      ),
    );
  }
}
