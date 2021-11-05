import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:winly/globals/configs/constans.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  _pages() {
    return [
      PageViewModel(
          title: 'Win big',
          body:
              'Participate in the prised tournament and win cash and prices with your skill',
          image: Center(
              child: Image.network(
            IntroImages.winingImage,
            height: 300,
            width: 300,
            fit: BoxFit.cover,
          ))),
      PageViewModel(
          title: 'Reffer your friends',
          body: 'Reffer your freinds and earn more tickets',
          image: Center(child: Image.network(IntroImages.winingImage))),
      PageViewModel(
          title: '',
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(height: 60, width: 60, child: FlutterLogo()),
              SizedBox(
                height: 10,
              ),
              Text('WinLy')
            ],
          ),
          // body: '',
          footer: const Text('RAY INTERNATIONAL PRIVATE LIMITED'))
    ];
  }

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          key: introKey,
          pages: _pages(),
          showNextButton: true,
          showSkipButton: true,
          showDoneButton: true,
          next: ElevatedButton(
            onPressed: () {},
            child: const Text('Next'),
          ),
          skip: TextButton(
            child: const Text('Skip'),
            onPressed: () {},
          ),
          done: ElevatedButton(
            child: const Text('Done'),
            onPressed: () {},
          ),
          onChange: (i) {},
          onDone: () {},
          onSkip: () {},
        ),
      ),
    );
  }
}
