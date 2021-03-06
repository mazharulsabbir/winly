import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/ads_controller.dart';
import 'package:winly/globals/controllers/tournament_controller.dart';
import 'package:winly/models/tournament/tournament.dart';
import 'package:winly/pages/tournament/view/tournament_details.dart';
import 'tournament_banner_stack.dart';
import 'tournament_participation.dart';

class TournamentItemWidget extends StatelessWidget {
  final Tournament? tournament;
  const TournamentItemWidget({Key? key, this.tournament}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        AdsController _adsController = Get.find<AdsController>();
        _adsController.showInterstitialAd();

        TournamentController _tc = Get.find<TournamentController>();
        _tc.getTournamentPlayers(tournament!.id.toString());

        Get.to(() => TournamentDetail(tournament: tournament));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TournamentBannerStack(tournament: tournament),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      '${tournament?.title}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('${tournament?.deadline}'),
                    const Divider(),
                    TournamentParticipation(tournament: tournament)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
