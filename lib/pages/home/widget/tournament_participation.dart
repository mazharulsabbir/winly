import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:winly/models/tournament/tournament.dart';
import 'package:winly/pages/tournament/view/join_tournament.dart';

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
        _joiningButton(
          tournament?.joinStatus,
          tournament?.status,
          isTournamentDetails,
        ),
      ],
    );
  }

  Widget _joiningButton(
    bool? isJoined,
    String? state,
    bool isTournamentDetails,
  ) {
    if (state == '0') {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('Closed'),
      );
    } else if (state == '2') {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('Live'),
      );
    }

    return isJoined == true
        ? Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('JOINED'),
          )
        : GestureDetector(
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
              child: _joiningButtonStatus(isTournamentDetails),
            ),
          );
  }

  Widget _joiningButtonStatus(isTournamentDetails) {
    return isTournamentDetails
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
          );
  }

  Widget _image(ProfileImage? image) {
    debugPrint("Image: ${image?.profileImage.toString()}");

    if (image == null || image.profileImage == null) {
      return const CircleAvatar(
        radius: 16,
        child: Icon(PhosphorIcons.user),
      );
    } else if (image.toString().contains('http')) {
      return CircleAvatar(
        radius: 16,
        backgroundImage: CachedNetworkImageProvider(
          "${tournament?.bannerImg}",
          errorListener: () => const Icon(PhosphorIcons.user),
        ),
      );
    } else {
      return CircleAvatar(
        radius: 16,
        child: Text(
          '${image.profileImage}',
          style: const TextStyle(fontSize: 10),
        ),
      );
    }
  }
}
