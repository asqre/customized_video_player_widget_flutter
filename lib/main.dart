import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player_widget/video/bloc/video_bloc.dart';
import 'package:video_player_widget/video/video_player_web.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => VideoBloc(),
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: VideoPlayerWeb()),
    ),
  );
}
