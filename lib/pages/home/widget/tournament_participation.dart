import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/models/tournament.dart';
import 'package:winly/pages/tournament/view/join_tournament.dart';
import 'package:winly/services/api/tournament_api.dart';

class TournamentParticipation extends StatelessWidget {
  final Tournament? tournament;
  final bool isTournamentDetails;
  const TournamentParticipation(
      {Key? key, this.tournament, this.isTournamentDetails = false})
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
                    child: _image(tournament?.photos?.first),
                  ),
                ),
                Positioned(
                  left: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: _image(tournament?.photos?.last),
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
                        '+${tournament?.players}',
                        style: const TextStyle(fontSize: 8),
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
          onTap: () => Get.to(() => JoinTournament(tournament: tournament)),
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
            child: isTournamentDetails
                ? const Padding(
                    padding: EdgeInsets.all(6),
                    child: Text('JOIN'),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(PhosphorIcons.ticket),
                      const SizedBox(width: 5),
                      Text('${tournament?.requireTickets}')
                    ],
                  ),
          ),
        )
      ],
    );
  }

  Widget _image(ProfileImage? image) {
    debugPrint(image?.profileImage.toString());
    if (image == null || image.profileImage == null) {
      return const CircleAvatar(
        radius: 16,
        child: Icon(PhosphorIcons.user),
      );
    } else if (image.toString().contains('http')) {
      return CircleAvatar(
        radius: 16,
        backgroundImage: Image.network(
          image.profileImage!,
          errorBuilder: (ctx, b, err) => const Icon(PhosphorIcons.user),
        ).image,
      );
    } else {
      return CircleAvatar(
        radius: 16,
        child: Text('${image.profileImage}'),
      );
    }
  }
}
