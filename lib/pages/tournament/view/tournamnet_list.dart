import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/tournament_controller.dart';
import 'package:winly/models/tournament/tournament.dart';
import 'package:winly/pages/home/widget/tournament_widget.dart';

class TournamentListWidget extends StatelessWidget {
  final List<Tournament>? tournaments;
  TournamentListWidget({Key? key, this.tournaments}) : super(key: key);

  final TournamentController tournamentController =
      Get.find<TournamentController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await tournamentController.getTournaments();
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10).copyWith(bottom: 100),
        itemCount: tournaments?.length,
        itemBuilder: (context, index) => TournamentItemWidget(
          tournament: tournaments?[index],
        ),
      ),
    );
  }
}
