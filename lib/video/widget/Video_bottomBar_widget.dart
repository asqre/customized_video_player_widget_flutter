import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_widget/video/widget/play_pause_widget.dart';
import 'package:video_player_widget/video/widget/playback_speed.dart';
import '../functions/common_functions.dart';
import 'fullScreen_Button_widget.dart';
import 'icon_button_widget.dart';
import 'mute_unmute_button.dart';

class VideoControlBottomBar extends StatelessWidget {
  final VideoPlayerController controller;
  final Duration videoLength;
  final Duration videoPosition;

  const VideoControlBottomBar(
      {required this.controller,
        required this.videoLength,
        required this.videoPosition,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double contextWidth = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        width: contextWidth > 700 ? contextWidth / 1.5 : contextWidth ,
        child: Column(
          children: [
            VideoProgressIndicator(
              controller,
              allowScrubbing: true,
              padding: const EdgeInsets.all(10),
            ),
            Row(
              children: [
                PlayPause(controller: controller),
                Text(
                  '${convertToMinutesSeconds(videoPosition)} / ${convertToMinutesSeconds(videoLength)}',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                MuteUnMuteButton(controller: controller),
                const Spacer(),
                BuildSpeed(controller: controller),
                const IconButtonWidget(
                    toolTip: 'Info',
                    icon: Icon(Icons.info),
                    onPressed: launchURL),
                IconButtonWidget(
                  toolTip: controller.value.isLooping
                      ? 'Loop off'
                      : 'Loop on',
                  icon: Icon(Icons.loop,
                      color: controller.value.isLooping
                          ? Colors.green
                          : Colors.white),
                  onPressed: () {
                    controller
                        .setLooping(!controller.value.isLooping);
                  },
                ),
                (contextWidth > 600) ?  const FullScreenButtonWidget() : const Text(''),
              ],
            ),
            Container(
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}




