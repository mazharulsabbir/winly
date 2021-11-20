import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winly/globals/configs/constans.dart';

import 'package:winly/models/intro_page.dart';
import 'package:winly/pages/root_screen/root_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int pageIndex = 0;

  PageController pageController = PageController();

  _slider(IntroPageModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: SvgPicture.asset(
            model.imageAddress,
            height: 200,
            width: 180,
            fit: BoxFit.cover,
          ),
        ),
        // const Spacer(),
        Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
            onPressed: () async {
              if (pageIndex < legnth - 1) {
                pageController
                    .nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeIn)
                    .then((_) => setState(() => pageIndex));
              } else if (pageIndex == legnth - 1) {
                SharedPreferences _pref = await SharedPreferences.getInstance();
                _pref.setBool(appFirstTimeLoadingKey, false);
                Get.off(() => const RootScreen());
              }
            },
            child: Text(pageIndex == 0
                ? 'Get Started'
                : pageIndex == legnth - 1
                    ? 'Finish'
                    : 'Next')));
  }

  setNewPage(int index) => setState(() => pageIndex = index);

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
            const Spacer(),
            Expanded(
              child: PageView(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: List.generate(IntroPageModel.introPages.length,
                    (index) => _slider(IntroPageModel.introPages[index])),
                onPageChanged: setNewPage,
              ),
              flex: 5,
            ),

            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(IntroPageModel.introPages.length,
                    (index) => _dot(index == pageIndex)),
              ),
            )),

            _button(
              context,
              IntroPageModel.introPages.length,
            ),
            const Spacer()
          ],
        ),
      )),
    );
  }
}
