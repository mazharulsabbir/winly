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
        leadingIcon: PhosphorIcons.arrow_up,
        title: 'Entry fee',
        subTitle: 'July 25',
        trailingTitle: '25\$',
        trailingSubtitle: 'Dhaka'),
    WalletRecentActivityModel(
        leadingIcon: PhosphorIcons.arrow_down,
        title: 'Cash transfer',
        subTitle: 'Jun 04',
        trailingTitle: '190\$',
        trailingSubtitle: 'Chittagong'),
    WalletRecentActivityModel(
        leadingIcon: PhosphorIcons.arrow_up,
        title: 'Entry fee',
        subTitle: 'July 25',
        trailingTitle: '25\$',
        trailingSubtitle: 'Dhaka'),
    WalletRecentActivityModel(
        leadingIcon: PhosphorIcons.arrow_down,
        title: 'Entry fee',
        subTitle: 'July 25',
        trailingTitle: '25\$',
        trailingSubtitle: 'Dhaka'),
  ];
}
