import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/pages/home/widget/tournament_participation.dart';
import 'package:winly/widgets/common_icon_text_widget.dart';

class TournamentInfoWidget extends StatelessWidget {
  const TournamentInfoWidget({Key? key}) : super(key: key);

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
                  children: const [
                    SizedBox(height: 20),
                    Text(
                      'Tournament Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Jan 15 - Jan 25'),
                    SizedBox(height: 15),
                    CommonIconTextWidget(
                      label: 'Jan 15 - Jan 25',
                      icon: PhosphorIcons.calendar,
                    ),
                    SizedBox(height: 10),
                    CommonIconTextWidget(
                      label: '5',
                      icon: PhosphorIcons.ticket,
                    ),
                    Divider(),
                    TournamentParticipation()
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
