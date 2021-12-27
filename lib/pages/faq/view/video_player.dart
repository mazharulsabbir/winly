import 'package:flutter/material.dart';
import 'package:winly/models/faq/youtube_video_item.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyYoutubeVideoPlayer extends StatefulWidget {
  final YoutubeVideoItem? video;

  const MyYoutubeVideoPlayer({Key? key, this.video}) : super(key: key);

  @override
  State<MyYoutubeVideoPlayer> createState() => _MyYoutubeVideoPlayerState();
}

class _MyYoutubeVideoPlayerState extends State<MyYoutubeVideoPlayer> {
  late YoutubePlayerController? _controller;
  // late PlayerState _playerState;
  // late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: '${widget.video?.id}',
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
      appBar: _isFullScreen
          ? null
          : AppBar(
              title: Text(widget.video?.snippet?.title ?? "Watch Video"),
              elevation: 2.0,
              leading: const CommonLeading(),
            ),
      body: Column(
        children: [
          YoutubePlayerBuilder(
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
            onEnterFullScreen: () {
              setState(() {
                _isFullScreen = true;
              });
            },
            onExitFullScreen: () {
              setState(() {
                _isFullScreen = false;
              });
            },
          ),
          SingleChildScrollView(
            child: ListTile(
              title: Text('${widget.video?.snippet?.title}'),
              subtitle: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text('${widget.video?.snippet?.description}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
