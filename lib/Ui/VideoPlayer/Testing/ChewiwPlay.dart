import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'ChewiwPlayer.dart';

class ChewiePlay extends StatefulWidget {
  File f;
  ChewiePlay({Key? key, required this.f}) : super(key: key);

  @override
  State<ChewiePlay> createState() => _ChewiePlayState();
}

class _ChewiePlayState extends State<ChewiePlay> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: VideoItems(
        videoPlayerController: VideoPlayerController.file(widget.f),
        videoPlayerController1: VideoPlayerController.file(widget.f),
        looping: false,
        autoplay: true,
      ),
    );
  }
}
