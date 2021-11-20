import 'package:flutter/material.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyYoutubeVideoPlayer extends StatefulWidget {
  final String? token;
  final String? title;
  final String? videoId;

  const MyYoutubeVideoPlayer({Key? key, this.videoId, this.token, this.title})
      : super(key: key);

  @override
  State<MyYoutubeVideoPlayer> createState() => _MyYoutubeVideoPlayerState();
}

class _MyYoutubeVideoPlayerState extends State<MyYoutubeVideoPlayer> {
  late YoutubePlayerController? _controller;
  // late PlayerState _playerState;
  // late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  // DailyEarningController dailyEarningController =
  //     Get.find<DailyEarningController>();

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: '${widget.videoId}',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller!.value.isFullScreen) {
      setState(() {
        // _playerState = _controller!.value.playerState;
        // _videoMetaData = _controller!.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "Watch Video"),
        elevation: 2.0,
        leading: const CommonLeading(),
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
          onReady: () {
            _isPlayerReady = true;
          },
          onEnded: (data) {
            // AdsAPI.getRewardFromAd(widget.token!, 'custom_ad')
            //     .catchError((error) {
            //   print(error);
            // }).then((reward) {
            //   if (reward?.body != null) {
            //     var data = convert.jsonDecode(reward!.body);
            //     if (data['usr_wallet'] != null) {
            //       // DailyEarnings _earnings =
            //       //     DailyEarnings.fromJson(data['usr_wallet']);
            //       // dailyEarningController.updateEarnings(_earnings);
            //     }
            //   }
            // });
            // _controller?.dispose();
            // _isPlayerReady = false;
          },
        ),
        builder: (_, player) {
          return player;
        },
      ),
    );
  }
}
