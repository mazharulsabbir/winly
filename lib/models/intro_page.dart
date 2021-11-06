import 'package:winly/globals/configs/constans.dart';

class IntroPageModel {
  const IntroPageModel(
      {required this.imageAddress,
      required this.title,
      required this.subTitle});
  final String imageAddress, title, subTitle;

  static List<IntroPageModel> introPages = const [
    IntroPageModel(
        imageAddress: IntroImages.winingImage,
        title: 'Win big!',
        subTitle:
            'Participante in prized tournament and win cash and prizes with your skilks'),
    IntroPageModel(
        title: 'Play Tournaments',
        subTitle: 'Earn tickets and join tournaments of your favorite games',
        imageAddress: IntroImages.winingImage),
    IntroPageModel(
        imageAddress: IntroImages.winingImage,
        title: 'Reffer your freinds',
        subTitle: 'Reffer your friends and earn more ticket'),
  ];
}
