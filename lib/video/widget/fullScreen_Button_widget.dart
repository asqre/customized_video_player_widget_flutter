import 'dart:html';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/video_bloc.dart';
import 'icon_button_widget.dart';

class FullScreenButtonWidget extends StatefulWidget {
  const FullScreenButtonWidget({Key? key}) : super(key: key);

  @override
  State<FullScreenButtonWidget> createState() => _FullScreenButtonWidgetState();
}

class _FullScreenButtonWidgetState extends State<FullScreenButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final websiteBloc = Provider.of<VideoBloc>(context);
    return IconButtonWidget(
      toolTip: websiteBloc.isFullScreen ? 'Exit full Screen' : 'Full screen',
      icon: websiteBloc.isFullScreen
          ? const Icon(Icons.fullscreen_exit)
          : const Icon(Icons.fullscreen),
      onPressed: () {
        // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
        if (!websiteBloc.isFullScreen) {
          document.documentElement?.requestFullscreen();
        } else {
          document.exitFullscreen();
        }
        setState(
          () {
            websiteBloc.fullScreen();
          },
        );
      },
    );
  }
}
