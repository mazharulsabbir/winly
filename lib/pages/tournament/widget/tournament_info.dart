import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/models/tournament.dart';
import 'package:winly/pages/home/widget/tournament_participation.dart';
import 'package:winly/widgets/common_icon_text_widget.dart';

class TournamentInfoWidget extends StatelessWidget {
  final Tournament? tournament;
  final bool isTournamentDetails;
  const TournamentInfoWidget(
      {Key? key, this.tournament, this.isTournamentDetails = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      '${tournament?.title}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(height: 15),
                    CommonIconTextWidget(
                      label: '${tournament?.deadline}',
                      icon: PhosphorIcons.calendar,
                    ),
                    const SizedBox(height: 10),
                    CommonIconTextWidget(
                      label: '${tournament?.requireTickets}',
                      icon: PhosphorIcons.ticket,
                    ),
                    const Divider(),
                    TournamentParticipation(
                      tournament: tournament,
                      isTournamentDetails: isTournamentDetails,
                    )
                  ],
                ),
              ),
              Positioned(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(PhosphorIcons.trophy),
                        SizedBox(width: 5),
                        Text('\$ 7873245'),
                      ],
                    ),
                  ),
                ),
                left: 0,
                right: 0,
                top: -15,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
