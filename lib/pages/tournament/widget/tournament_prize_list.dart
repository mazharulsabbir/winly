import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/models/tournament.dart';

class TournamentPrizePositionsWidget extends StatelessWidget {
  final Tournament? tournament;
  const TournamentPrizePositionsWidget({Key? key, this.tournament})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tournament?.positions?.length ?? 0,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(PhosphorIcons.trophy),
            ),
            title: Text(
              '${tournament?.positions?[index].amount}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${tournament?.positions?[index].position}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
