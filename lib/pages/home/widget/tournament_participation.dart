import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/globals/controllers/tournament_controller.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/models/tournament.dart';

class TournamentParticipation extends StatelessWidget {
  final Tournament? tournament;
  final TournamentController? tournamentController;
  const TournamentParticipation(
      {Key? key, this.tournament, this.tournamentController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: CircleAvatar(
                      radius: 16,
                      child: Icon(PhosphorIcons.user),
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: CircleAvatar(
                      radius: 16,
                      child: Icon(PhosphorIcons.user),
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: CircleAvatar(
                      radius: 16,
                      child: Text(
                        '+250',
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            const Text('Participants')
          ],
        ),
        GestureDetector(
          onTap: () async {
            // todo: join on tournament
            try {
              dynamic _res = await tournamentController?.joinTournament(
                tournament?.id,
                tournament?.game_name,
              );

              snack(
                  title: 'Message',
                  desc: "${_res.data['return_msg']}",
                  icon: const Icon(Icons.done));
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(PhosphorIcons.ticket),
                const SizedBox(width: 5),
                Text('${tournament?.require_tickets}')
              ],
            ),
          ),
        )
      ],
    );
  }
}
