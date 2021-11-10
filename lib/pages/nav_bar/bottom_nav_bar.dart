import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:winly/globals/configs/constans.dart';
import 'package:winly/pages/nav_bar/tab_navigation_item.dart';
import 'package:winly/pages/notification/view/notification_screen.dart';
import 'package:winly/pages/wallet/wallet_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, this.index}) : super(key: key);
  final int? index;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => Get.to(() => const WalletScreen()),
            icon: const Icon(PhosphorIcons.wallet),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const NotificationScreen()),
            icon: const Icon(PhosphorIcons.bell),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          TabNavigationItem.items.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(TabNavigationItem.items[index].icon),
            label: TabNavigationItem.items[index].title,
          ),
        ),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() => _currentIndex = i);
        },
      ),
      body: Stack(children: [
        IndexedStack(
          index: _currentIndex,
          children: List.generate(
            TabNavigationItem.items.length,
            (index) => TabNavigationItem.items[index].page,
          ),
        )
      ]),
    );
  }
}
