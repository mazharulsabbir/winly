import 'package:flutter/material.dart';
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
      body: Stack(children: [
        IndexedStack(
          index: _currentIndex,
          children: [for (final p in TabNavigationItem.items) p.page],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomNavigationBar(
            items: [
              for (final i in TabNavigationItem.items)
                BottomNavigationBarItem(icon: Icon(i.icon), label: i.titile)
            ],
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
