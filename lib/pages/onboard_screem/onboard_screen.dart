import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:winly/models/intro_page.dart';
import 'package:winly/pages/nav_bar/bottom_nav_bar.dart';
import 'package:winly/pages/root_screen/root_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int pageIndex = 0;

  _slider(IntroPageModel model) {
    return Column(
      children: [
        Center(
          child: Image.network(
            model.imageAddress,
            height: 300,
            width: 300,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
            flex: 2,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  model.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  child: Text(
                    model.subTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }

  _dot(isActive) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey, shape: BoxShape.circle),
    );
  }

  _button(context, int legnth) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        child: ElevatedButton(
            onPressed: () {
              if (pageIndex < legnth - 1) {
                setState(() => pageIndex++);
              } else if (pageIndex == legnth - 1) {
                Get.off(() => const RootScreen());
              }
            },
            child: Text(pageIndex == 0
                ? 'Get Started'
                : pageIndex == legnth - 1
                    ? 'Finish'
                    : 'Next')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.off(() => const RootScreen());
                    },
                    child: const Text('Skip'),
                  ),
                )),
            // ..._slider(),
            Expanded(
              child: IndexedStack(
                index: pageIndex,
                children: List.generate(IntroPageModel.IntroPages.length,
                    (index) => _slider(IntroPageModel.IntroPages[index])),
              ),
              flex: 5,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(IntroPageModel.IntroPages.length,
                        (index) => _dot(index == pageIndex)),
                  ),
                )),

            _button(
              context,
              IntroPageModel.IntroPages.length,
            ),
            const Spacer()
          ],
        ),
      )),
    );
  }
}
