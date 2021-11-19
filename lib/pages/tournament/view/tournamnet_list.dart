import 'package:flutter/material.dart';
import 'package:winly/globals/controllers/tournament_controller.dart';
import 'package:winly/models/tournament.dart';
import 'package:winly/pages/home/widget/tournament_widget.dart';

class TournamentListWidget extends StatelessWidget {
  final List<Tournament>? tournaments;
  final TournamentController? tournamentController;
  const TournamentListWidget(
      {Key? key, this.tournaments, this.tournamentController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await TournamentController().getTournaments();
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10).copyWith(bottom: 100),
        itemCount: tournaments?.length,
        itemBuilder: (context, index) => TournamentItemWidget(
          tournament: tournaments?[index],
          tournamentController: tournamentController,
        ),
      ),
    );
  }
}
