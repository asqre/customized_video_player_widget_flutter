import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_widget/video/video_player_web.dart';
import 'package:video_player_widget/video/widget/Video_bottomBar_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerMobile extends StatefulWidget {
  const VideoPlayerMobile({Key? key}) : super(key: key);

  @override
  State<VideoPlayerMobile> createState() => _VideoPlayerMobileState();
}

class _VideoPlayerMobileState extends State<VideoPlayerMobile> {
  VideoPlayerController? _controller;
  late Duration videoLength;
  late Duration videoPosition;
  bool isShowBar = false;
  bool isThumbnailImage = true;

  @override
  void initState() {
    _controller = VideoPlayerController.network(API().dataSource)
      ..initialize().then((_) {
        setState(() {
          videoLength = _controller!.value.duration;
        });
      })
      ..setLooping(true)
      ..addListener(() => setState(() {
            videoPosition = _controller!.value.position;
          }));

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (_controller != null && _controller!.value.isInitialized) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        isShowBar = !isShowBar;
                        isThumbnailImage = false;
                      });
                      _controller!.value.isPlaying
                          ? _controller!.pause()
                          : _controller!.play();
                    },
                    child: isThumbnailImage
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network('https://seeklogo.com/images/Y/youtube-logo-FF3BEE4378-seeklogo.com.png'),
                              const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                            ],
                          )
                        : AbsorbPointer(
                            child: VisibilityDetector(
                                key: const ValueKey<String>('pause'),
                                onVisibilityChanged: (visibilityInfo) {
                                  if (visibilityInfo.visibleFraction == 0) {
                                    _controller!.pause();
                                  }
                                },
                                child: VideoPlayer(_controller!)),
                          ),
                  ),
                ),
              ),
              if (isShowBar && MediaQuery.of(context).size.width > 300)
                VideoControlBottomBar(
                  controller: _controller!,
                  videoLength: videoLength,
                  videoPosition: videoPosition,
                ),
            ] else
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}
