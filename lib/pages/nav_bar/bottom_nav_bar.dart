import 'package:flutter/material.dart';
import 'package:winly/globals/configs/constans.dart';
import 'package:winly/pages/nav_bar/tab_navigation_item.dart';

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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text(APP_NAME),
      ),
      body: Stack(children: [
        IndexedStack(
          index: _currentIndex,
          children: List.generate(
            TabNavigationItem.items.length,
            (index) => TabNavigationItem.items[index].page,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomNavigationBar(
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
        )
      ]),
    );
  }
}
