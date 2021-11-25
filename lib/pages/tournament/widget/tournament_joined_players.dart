import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/tournament_controller.dart';

class TournamentJoinedPlayers extends StatelessWidget {
  TournamentJoinedPlayers({Key? key}) : super(key: key);

  final TournamentController tournamentController =
      Get.find<TournamentController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: tournamentController.tournamentPlayers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "${tournamentController.tournamentPlayers[index].name}",
            ),
            subtitle: Text(
              "Position: ${tournamentController.tournamentPlayers[index].position}",
            ),
          );
        },
      );
    });
  }
}
