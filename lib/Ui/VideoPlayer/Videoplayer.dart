// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:vr_converter/Utils/Utils.dart';

class Video extends StatefulWidget {
  File f;
  Video({Key? key, required this.f}) : super(key: key);

  @override
  State<Video> createState() => VideoState();
}

class VideoState extends State<Video> {
  bool isdouble = true;
  bool isvisible = true;
  late VideoPlayerController controller;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.initState();
    controller = VideoPlayerController.file(widget.f)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          // controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    bool ismuted = controller.value.volume == 0;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            controller != null && controller.value.isInitialized
                ? Stack(children: [
                    Row(
                        children: isdouble
                            ? [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Center(
                                          child: AspectRatio(
                                              aspectRatio:
                                                  controller.value.aspectRatio,
                                              child: VideoPlayer(controller)))),
                                ),
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Center(
                                          child: AspectRatio(
                                              aspectRatio:
                                                  controller.value.aspectRatio,
                                              child: VideoPlayer(controller)))),
                                ),
                              ]
                            : [
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Center(
                                            child: AspectRatio(
                                                aspectRatio: controller
                                                    .value.aspectRatio,
                                                child:
                                                    VideoPlayer(controller))))),
                              ]),
                    Positioned.fill(
                        child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        isvisible == true
                            ? isvisible = false
                            : isvisible = true;
                        // if (isvisible == true) {
                        //   Future.delayed(Duration(seconds: 3), () {
                        //     isvisible = false;
                        //     setState(() {});
                        //   });
                        // }

                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          // controller.value.isPlaying
                          //     ? Container()
                          //     : Container(
                          //         color: Colors.black26,
                          //         alignment: Alignment.center,
                          //         child: const Icon(
                          //           Icons.play_arrow,
                          //           size: 80,
                          //           color: Colors.white,
                          //         )),
                          Visibility(
                            visible: isvisible,
                            child: Positioned(
                              bottom: 30,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.value.isPlaying
                                          ? controller.pause()
                                          : controller.play();
                                    },
                                    child: Container(
                                        color: Colors.transparent,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          controller.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 40,
                                          color: Colors.white,
                                        )),
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: controller,
                                    builder: (context, VideoPlayerValue value,
                                        child) {
                                      //Do Something with the value.
                                      return Text(value.position
                                          .toString()
                                          .split(".")[0]);
                                    },
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: VideoProgressIndicator(controller,
                                          colors: VideoProgressColors(
                                              playedColor: Colors.red,
                                              backgroundColor: Colors.white12,
                                              bufferedColor:
                                                  Colors.grey.shade600),
                                          allowScrubbing: true),
                                    ),
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: controller,
                                    builder: (context, VideoPlayerValue value,
                                        child) {
                                      //Do Something with the value.
                                      return Text(value.duration
                                          .toString()
                                          .split(".")[0]);
                                    },
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ])
                : const Center(
                    child: SizedBox(
                        height: 200,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.blueGrey,
                          strokeWidth: 2,
                        ))),
                  ),
            if (controller.value.isInitialized)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: isvisible,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios)),
                      ),
                      Visibility(
                        visible: isvisible,
                        child: InkWell(
                          onTap: () {
                            if (isdouble) {
                              isdouble = false;
                            } else {
                              isdouble = true;
                            }
                            setState(() {});
                            //controller.setVolume(ismuted ? 1 : 0);
                          },
                          child: SizedBox(
                            height: 5.h,
                            width: 5.h,
                            child: SvgPicture.asset(
                              isdouble ? vricon : novricon,
                              semanticsLabel: 'Acme Logo',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<Duration?> getduration() async {
    Duration? duration = await controller.position;
    return duration;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    controller.dispose();
  }
}
