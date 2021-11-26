import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/tournament_controller.dart';
import 'package:winly/models/tournament/tournament.dart';
import 'package:winly/pages/tournament/view/tournamnet_list.dart';
import 'package:winly/widgets/common_appbar.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class Tournaments extends StatelessWidget {
  Tournaments({Key? key}) : super(key: key);

  final TournamentController controller = Get.find<TournamentController>();

  @override
  Widget build(BuildContext context) {
    return CommonLoadingOverlay(
      loading: false,
      child: Obx(() {
        List<Tournament>? _completedEvents = controller.tournaments
            .where((element) => element.status == "0")
            .toList();
        List<Tournament>? _upcommingEvents = controller.tournaments
            .where((element) => element.status == "1")
            .toList();
        List<Tournament>? _liveEvents = controller.tournaments
            .where((element) => element.status == "2")
            .toList();

        return CommonLoadingOverlay(
          loading: controller.isLoading,
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: buildCommonAppbar(
                bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                      text: 'Upcoming'.toUpperCase() +
                          " (${_upcommingEvents.length})",
                    ),
                    Tab(
                      text: 'Live'.toUpperCase() + " (${_liveEvents.length})",
                    ),
                    Tab(
                      text: 'Completed'.toUpperCase() +
                          " (${_completedEvents.length})",
                    )
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  TournamentListWidget(tournaments: _upcommingEvents),
                  TournamentListWidget(tournaments: _liveEvents),
                  TournamentListWidget(tournaments: _completedEvents)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
