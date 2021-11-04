import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/pages/tabs/tabs.dart';

class TabNavigationItem {
  TabNavigationItem({
    required this.title,
    required this.icon,
    required this.page,
    required this.index,
  });

  final String title;
  final IconData icon;
  final Widget page;
  final int index;

  static List<TabNavigationItem> items = [
    TabNavigationItem(
      title: 'Tournaments ',
      icon: PhosphorIcons.game_controller,
      page: const Tournaments(),
      index: 0,
    ),
    TabNavigationItem(
      title: 'Earn Tickets',
      page: const EarnTicketTab(),
      index: 1,
      icon: PhosphorIcons.ticket,
    ),
    TabNavigationItem(
      title: 'FQA',
      icon: PhosphorIcons.question,
      page: const FQATab(),
      index: 2,
    ),
    TabNavigationItem(
      title: 'Profile',
      icon: PhosphorIcons.user,
      page: const ProfileTab(),
      index: 3,
    )
  ];
}
