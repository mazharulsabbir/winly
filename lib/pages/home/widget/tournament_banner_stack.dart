import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/models/tournament.dart';
import 'package:winly/services/api/api_service.dart';

class TournamentBannerStack extends StatelessWidget {
  final Tournament? tournament;
  const TournamentBannerStack({Key? key, this.tournament}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            "${ApiService.baseUrl}${tournament?.banner_img}",
            height: 170.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(PhosphorIcons.bell),
            ),
          ),
        ),
        Positioned(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.7),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
          bottom: -15,
        ),
        // Positioned(
        //   right: 10,
        //   bottom: -16,
        //   child: GestureDetector(
        //     child: Container(
        //       padding: const EdgeInsets.all(6),
        //       decoration: BoxDecoration(
        //         color: Colors.blue,
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //       child: const Icon(PhosphorIcons.bell),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
