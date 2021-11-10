import 'package:flutter/cupertino.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class WalletRecentActivityModel {
  final IconData leadingIcon;
  final String title;
  final String subTitle;
  final String trailingTitle;
  final String trailingSubtitle;

  WalletRecentActivityModel(
      {required this.leadingIcon,
      required this.title,
      required this.subTitle,
      required this.trailingTitle,
      required this.trailingSubtitle});
  static List<WalletRecentActivityModel> activities = [
    WalletRecentActivityModel(
        leadingIcon: PhosphorIcons.share,
        title: 'Cash Out',
        subTitle: 'July 25',
        trailingTitle: '25\$',
        trailingSubtitle: 'Dhaka'),
    WalletRecentActivityModel(
        leadingIcon: PhosphorIcons.share,
        title: 'Cash Out',
        subTitle: 'Jun 04',
        trailingTitle: '190\$',
        trailingSubtitle: 'Chittagong'),
    WalletRecentActivityModel(
        leadingIcon: PhosphorIcons.share,
        title: 'Cash Out',
        subTitle: 'July 25',
        trailingTitle: '25\$',
        trailingSubtitle: 'Dhaka'),
    WalletRecentActivityModel(
        leadingIcon: PhosphorIcons.share,
        title: 'Cash Out',
        subTitle: 'July 25',
        trailingTitle: '25\$',
        trailingSubtitle: 'Dhaka'),
  ];
}
