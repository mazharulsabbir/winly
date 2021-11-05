import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class TournamentParticipation extends StatelessWidget {
  const TournamentParticipation({Key? key}) : super(key: key);

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
        Container(
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
            children: const [
              Icon(PhosphorIcons.ticket),
              SizedBox(
                width: 5,
              ),
              Text('5')
            ],
          ),
        )
      ],
    );
  }
}
