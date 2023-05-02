import 'package:flutter/material.dart';

class VideoBloc extends ChangeNotifier{

  ///video
  bool isFullScreen = false;
  void fullScreen() {
    isFullScreen = !isFullScreen;
    notifyListeners();
  }

  ///mute button
  bool isMute = false;
  double volume = 0.5;
  double changedVolume = 0.5;
  void clickMute() {
    isMute = !isMute;
    notifyListeners();
  }

}