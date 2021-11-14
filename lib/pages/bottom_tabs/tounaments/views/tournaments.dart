import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/pages/bottom_tabs/tounaments/tabs/completed.dart';
import 'package:winly/pages/bottom_tabs/tounaments/tabs/live.dart';
import 'package:winly/pages/bottom_tabs/tounaments/tabs/up_comming.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class Tournaments extends StatelessWidget {
  const Tournaments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLoadingOverlay(
      loading: false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 10,
            bottom: const TabBar(
              tabs: [Text('Upcomming'), Text('Live'), Text('Complited')],
            ),
          ),
          floatingActionButton: const FloatingActionButton(
            onPressed: null,
            child: Icon(PhosphorIcons.sort_ascending),
          ),
          body: const TabBarView(
            children: [UpCommingTabs(), LiveTab(), CompletedTab()],
          ),
        ),
      ),
    );
  }
}
