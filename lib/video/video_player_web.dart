import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_widget/video/widget/Video_bottomBar_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'bloc/video_bloc.dart';


class API{
  String dataSource =
      'https://firebasestorage.googleapis.com/v0/b/upload-bugsmirror-videos.appspot.com/o/About%20%23Bugsmirror%20%23google%20%23bugs%20%23vulnerability%20(1)%20(1).mp4?alt=media&token=eaf8dd6a-34fe-43e5-b5a2-273ff7fff23a';
  String images =
      'https://firebasestorage.googleapis.com/v0/b/upload-bugsmirror-videos.appspot.com/o/diego-ph-fIq0tET6llw-unsplash.jpg?alt=media&token=52a8f43e-3b2f-4b45-b153-db5ea85e389b';
}

double aspectRatio(
    BoxConstraints constraints, bool isFullScreen, BuildContext context) {
  if (!isFullScreen) {
    return MediaQuery.of(context).size.width *
        .75 /
        MediaQuery.of(context).size.height *
        .7;
  } else {
    return constraints.maxWidth / constraints.maxHeight;
  }
}

class VideoPlayerWeb extends StatefulWidget {
  const VideoPlayerWeb({Key? key}) : super(key: key);

  @override
  State<VideoPlayerWeb> createState() => _VideoPlayerWebState();
}

class _VideoPlayerWebState extends State<VideoPlayerWeb> {
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
    final websiteBloc = Provider.of<VideoBloc>(context);
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      children: [
        if (_controller != null && _controller!.value.isInitialized) ...[
          Padding(
            padding: websiteBloc.isFullScreen
                ? const EdgeInsets.symmetric(horizontal: 0)
                : const EdgeInsets.symmetric(horizontal: 30),
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                color: Colors.black,
                height: (websiteBloc.isFullScreen)
                    ? constraints.maxHeight
                    : MediaQuery.of(context).size.height * .7,
                width: (websiteBloc.isFullScreen)
                    ? constraints.maxWidth
                    : MediaQuery.of(context).size.width * .75,
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
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .7,
                              width: MediaQuery.of(context).size.width * .75,
                              child: Image.network('https://seeklogo.com/images/Y/youtube-logo-FF3BEE4378-seeklogo.com.png',
                                  fit: BoxFit.contain),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width:
                                    MediaQuery.of(context).size.width * 0.2,
                                child: const Icon(Icons.play_arrow_rounded,
                                    color: Colors.white, size: 150)),
                          ],
                        )
                      : AbsorbPointer(
                          child: VisibilityDetector(
                              key: const ValueKey<String>('pause'),
                              onVisibilityChanged: (visibilityInfo){
                                if(visibilityInfo.visibleFraction == 0){
                                  _controller!.pause();
                                }
                              },
                              child: VideoPlayer(_controller!)),
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: isShowBar
                ? VideoControlBottomBar(
                    controller: _controller!,
                    videoLength: videoLength,
                    videoPosition: videoPosition,
                  )
                : Container(),
          )
        ] else
          const Center(
            child: CircularProgressIndicator(),
          )
      ],
    );
  }
}
