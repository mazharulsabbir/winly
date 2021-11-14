import 'package:flutter/material.dart';

class UpCommingTabs extends StatefulWidget {
  const UpCommingTabs({Key? key}) : super(key: key);

  @override
  _UpCommingTabsState createState() => _UpCommingTabsState();
}

class _UpCommingTabsState extends State<UpCommingTabs> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Upcomming tournaments'),
    );
  }
}
