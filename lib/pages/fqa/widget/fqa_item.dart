import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:winly/models/faq/faq.dart';
import 'package:winly/models/faq/youtube_video_item.dart';
import 'package:winly/pages/fqa/view/video_player.dart';
import 'package:flutter/foundation.dart';

class FqaItemWidget extends StatelessWidget {
  final FaqItem faqItem;
  const FqaItemWidget({Key? key, required this.faqItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("::::: Loading Faq item :::::");
    if (faqItem.type == FaqType.other) {
      FrequentlyAskedQuestion _faq = faqItem.item as FrequentlyAskedQuestion;

      return ListTile(
        title: Text("${_faq.question}"),
        subtitle: Text("${_faq.ans}"),
        trailing: const Icon(Icons.info),
        onTap: () {},
      );
    }

    YoutubeVideoItem _video = faqItem.item as YoutubeVideoItem;
    debugPrint("::::: Loading youtube video item :::::");
    debugPrint(_video.toString());

    return GestureDetector(
      onTap: () {
        Get.to(() => MyYoutubeVideoPlayer(
              videoId: _video.id,
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
                  "${_video.snippet?.thumbnails?.high?.url}",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text("${_video.snippet?.title}"),
              subtitle: Text(
                '${_video.snippet?.publishedAt} | ${_video.statistics?.viewCount} Views',
              ),
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
                children: [
                  const Icon(PhosphorIcons.play_circle_fill),
                  const SizedBox(width: 5),
                  Text('${_video.contentDetails?.duration}'),
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
