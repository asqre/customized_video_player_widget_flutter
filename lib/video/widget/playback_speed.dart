import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BuildSpeed extends StatelessWidget {
  final VideoPlayerController controller;
  static const List<double> allSpeeds = [0.25, 0.5, 1, 1.5, 2];
  const BuildSpeed({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TooltipTheme(
      data: TooltipThemeData(
        textStyle: const TextStyle(fontSize: 15, color: Colors.white),
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: PopupMenuButton(
        initialValue: controller.value.playbackSpeed,
        tooltip: 'Playback speed',
        onSelected: controller.setPlaybackSpeed,
        itemBuilder: (context) => allSpeeds
            .map<PopupMenuEntry<double>>((speed) => PopupMenuItem(
                  value: speed,
                  child: Text('${speed}x'),
                ))
            .toList(),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text('${controller.value.playbackSpeed}x',
              style: const TextStyle(
                color: Colors.white,
                backgroundColor: Colors.transparent,
              )),
        ),
      ),
    );
  }
}
