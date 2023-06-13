import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class VideoItems extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final VideoPlayerController videoPlayerController1;

  final bool? looping;
  final bool autoplay;

  VideoItems({
    required this.videoPlayerController,
    required this.videoPlayerController1,
    this.looping,
    required this.autoplay,
    Key? key,
  }) : super(key: key);

  @override
  _VideoItemsState createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  late ChewieController _chewieController;
  late ChewieController _chewieController1;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping!,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
     _chewieController1 = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping!,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.portraitUp]);
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        height: 100.h,
        width: 50.h,
        child: Chewie(
          controller: _chewieController,
        ),
      ),
      Container(
        height: 100.h,
        width: 50.h,
        child:  Chewie(controller: _chewieController,
        ),
      ),
    ]);
  }
}
