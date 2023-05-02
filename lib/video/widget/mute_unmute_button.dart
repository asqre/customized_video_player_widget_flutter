import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../bloc/video_bloc.dart';
import '../functions/common_functions.dart';

class MuteUnMuteButton extends StatefulWidget {
  final VideoPlayerController controller;
  const MuteUnMuteButton({required this.controller, Key? key})
      : super(key: key);

  @override
  State<MuteUnMuteButton> createState() => _MuteUnMuteButtonState();
}

class _MuteUnMuteButtonState extends State<MuteUnMuteButton> {

  @override
  Widget build(BuildContext context) {
    final websiteBloc = Provider.of<VideoBloc>(context,listen: true);
    return Row(children: [
      IconButton(
        onPressed: () {
          if(!websiteBloc.isMute){
            widget.controller.setVolume(0);
            websiteBloc.volume=0;
          }else{
            websiteBloc.volume=websiteBloc.changedVolume;
            widget.controller.setVolume(websiteBloc.volume);
          }
          setState(() {
            websiteBloc.clickMute();
          });
        },
        icon: Icon(
          animatedVolumeIcon(websiteBloc),
          color: Colors.white,
        ),
      ),
      // const SizedBox(width: 10,),
      if (MediaQuery.of(context).size.width > 800)
        Slider(
          value: websiteBloc.volume,
          min: 0,
          max: 1,
          // divisions: 100,
          // activeColor: Colors.green,
          // inactiveColor: Colors.orange,
          thumbColor: Colors.white,
          // label: widget.volume.round().toString(),
          onChanged: (changedVolume) {
            setState(() {
              websiteBloc.changedVolume=changedVolume;
              websiteBloc.volume = changedVolume;
              if(changedVolume>0){
                websiteBloc.isMute=false;
              }
              widget.controller.setVolume(changedVolume);
            });
          },
        )
    ]);
  }
}
