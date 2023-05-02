import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/video_bloc.dart';

launchURL() async {
  var url = Uri.parse('https://www.youtube.com/watch?v=gLrsJeK2NvQ');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

String convertToMinutesSeconds(Duration duration) {
  final parsedMinutes = duration.inMinutes % 60;
  final minutes =
  parsedMinutes < 10 ? '0$parsedMinutes' : parsedMinutes.toString();
  final parsedSeconds = duration.inSeconds % 60;
  final seconds =
  parsedSeconds < 10 ? '0$parsedSeconds' : parsedSeconds.toString();

  return '$minutes:$seconds';
}

IconData animatedVolumeIcon(VideoBloc websiteBloc) {
  if (websiteBloc.volume == 0) {
    return Icons.volume_off;
  } else if (websiteBloc.volume < 0.5) {
    return Icons.volume_down;
  } else {
    return Icons.volume_up;
  }
}

