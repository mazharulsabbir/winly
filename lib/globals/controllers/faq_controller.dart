import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:winly/models/faq/faq.dart';
import 'package:winly/models/faq/youtube_video_item.dart';
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/api/url.dart';
import 'package:winly/services/db/auth.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FaqController extends getx.GetxController {
  String? token;
  bool isLoading = false;

  List<FaqItem> faqItems = [];

  FaqController() {
    token = AuthDBService.getToken();
    getFaqs();
  }

  Future<void> getFaqs() async {
    isLoading = true;
    update();

    try {
      final _response = await ApiService.get(
        "api/faqs",
        token: token,
      );

      if (_response != null && _response.data != null) {
        List<dynamic> _faqs = _response.data;
        List<FrequentlyAskedQuestion> faqs =
            _faqs.map((e) => FrequentlyAskedQuestion.fromJson(e)).toList();

        faqItems = [];
        Future.forEach(faqs, (faq) async {
          FrequentlyAskedQuestion _faq = faq as FrequentlyAskedQuestion;
          String? videoId = YoutubePlayer.convertUrlToId("${_faq.ans}");

          if (videoId != null) {
            String _url = youtubeUrlBuilder('/youtube/v3/videos', params: [
              'part=snippet,contentDetails,statistics',
              'id=$videoId',
              'key=AIzaSyAdzUrWgxjn_gyNMQ7fNQPHsk32fttkML4'
            ]);

            final _videoDetails = await ApiService.getVideoDetails(_url);

            if (_videoDetails.data['items'] != null) {
              _videoDetails.data['items'].forEach((e) {
                YoutubeVideoItem item = YoutubeVideoItem.fromJson(e);

                FaqItem faqItem = FaqItem(type: FaqType.youtube, item: item);
                faqItems.add(faqItem);
              });

              update();
            }
          } else {
            FaqItem faqItem = FaqItem(type: FaqType.other, item: _faq);
            faqItems.add(faqItem);
          }
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    update();
  }
}
