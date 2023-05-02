import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'icon_button_widget.dart';

class PlayPause extends StatefulWidget {
  final VideoPlayerController controller;
  const PlayPause({required this.controller, Key? key}) : super(key: key);

  @override
  State<PlayPause> createState() => _PlayPauseState();
}

class _PlayPauseState extends State<PlayPause> {
  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      toolTip: widget.controller.value.isPlaying ? 'Pause' : 'Play',
      icon: Icon(
        widget.controller.value.isPlaying
            ? Icons.pause
            : Icons.play_arrow,
      ),
      onPressed: () => setState(
            () {
          widget.controller.value.isPlaying
              ? widget.controller.pause()
              : widget.controller.play();
        },
      ),
    );
  }
}
