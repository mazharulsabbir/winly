import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:winly/pages/fqa/view/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FqaItemWidget extends StatelessWidget {
  const FqaItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String? videoId;
        videoId = YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=BBAyRBTfsOU",
        );
        Get.to(() => MyYoutubeVideoPlayer(
              videoId: videoId,
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.grey.withOpacity(0.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "https://images.firstpost.com/fpimages/1200x800/fixed/jpg/2019/01/PUBG-Lite-copy.jpg",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const ListTile(
              title: Text('Video Name'),
              subtitle: Text('3 Days ago | 1.5k Views'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(PhosphorIcons.play_circle_fill),
                  SizedBox(width: 5),
                  Text('3 Mins'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
