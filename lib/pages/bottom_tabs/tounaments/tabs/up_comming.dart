import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/tournament_controller.dart';
import 'package:winly/pages/home/widget/tournament_widget.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class UpCommingTabs extends StatefulWidget {
  const UpCommingTabs({Key? key}) : super(key: key);

  @override
  _UpCommingTabsState createState() => _UpCommingTabsState();
}

class _UpCommingTabsState extends State<UpCommingTabs> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TournamentController>(
      builder: (controller) {
        return CommonLoadingOverlay(
          loading: controller.isLoading,
          child: ListView.builder(
            padding:
                const EdgeInsets.symmetric(vertical: 10).copyWith(bottom: 100),
            itemCount: controller.tournaments?.length,
            itemBuilder: (context, index) => TournamentItemWidget(
              tournament: controller.tournaments?[index],
            ),
          ),
        );
      },
      init: TournamentController(),
    );
  }
}
