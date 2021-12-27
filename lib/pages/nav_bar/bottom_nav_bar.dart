import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/globals/controllers/notification_controller.dart';
import 'package:winly/globals/controllers/tournament_controller.dart';
import 'package:winly/pages/nav_bar/tab_navigation_item.dart';

class BottomNavBar extends StatefulWidget {
  final User? user;
  const BottomNavBar({Key? key, this.index, this.user}) : super(key: key);
  final int? index;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _currentIndex;
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    Get.put<NotificationController>(NotificationController());
    Get.put<TournamentController>(TournamentController());

    _currentIndex = widget.index ?? 0;
    if (widget.user != null) {
      _authController.mUserObx.value = widget.user!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
