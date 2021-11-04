import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/pages/tabs/tabs.dart';

class TabNavigationItem {
  TabNavigationItem(
      {required this.titile,
      required this.icon,
      required this.page,
      required this.index});

  final String titile;
  final IconData icon;
  final Widget page;
  final int index;

  static List<TabNavigationItem> items = [
    TabNavigationItem(
        titile: 'Tournaments ',
        icon: Icons.home,
        page: const Tournaments(),
        index: 0),
    TabNavigationItem(
        titile: 'Earn Tickets',
        page: const EarnTicketTab(),
        index: 1,
        icon: PhosphorIcons.coin),
    TabNavigationItem(
        titile: 'FQA',
        icon: PhosphorIcons.question,
        page: const FQATab(),
        index: 2),
    TabNavigationItem(
        titile: 'Profile',
        icon: PhosphorIcons.person,
        page: const ProfileTab(),
        index: 3)
  ];
}
