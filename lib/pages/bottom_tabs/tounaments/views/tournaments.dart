import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/tournament_controller.dart';
import 'package:winly/models/tournament.dart';
import 'package:winly/pages/tournament/view/tournamnet_list.dart';
import 'package:winly/widgets/common_appbar.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class Tournaments extends StatelessWidget {
  const Tournaments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLoadingOverlay(
      loading: false,
      child: GetBuilder<TournamentController>(
        builder: (controller) {
          List<Tournament>? _completedEvents = controller.tournaments
              ?.where((element) => element.status == "0")
              .toList();
          List<Tournament>? _upcommingEvents = controller.tournaments
              ?.where((element) => element.status == "1")
              .toList();
          List<Tournament>? _liveEvents = controller.tournaments
              ?.where((element) => element.status == "2")
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
                        text: 'Upcomming'.toUpperCase() +
                            " (${_upcommingEvents?.length})",
                      ),
                      Tab(
                        text:
                            'Live'.toUpperCase() + " (${_liveEvents?.length})",
                      ),
                      Tab(
                        text: 'Completed'.toUpperCase() +
                            " (${_completedEvents?.length})",
                      )
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    TournamentListWidget(
                      tournaments: _upcommingEvents,
                      tournamentController: controller,
                    ),
                    TournamentListWidget(
                      tournaments: _liveEvents,
                      tournamentController: controller,
                    ),
                    TournamentListWidget(
                      tournaments: _completedEvents,
                      tournamentController: controller,
                    )
                  ],
                ),
              ),
            ),
          );
        },
        init: TournamentController(),
      ),
    );
  }
}
