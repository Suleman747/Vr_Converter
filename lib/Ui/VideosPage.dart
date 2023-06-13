// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'dart:io';
import 'dart:typed_data';
import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:vr_converter/Controllers/GalleryFolderController.dart';
import '../Controllers/AdsController.dart';
import '../Utils/Utils.dart';
import '../Widgets/dialog.dart';
import '../Widgets/widgets.dart';
import 'VideoPlayer/Videoplayer.dart';

class VideosPage extends StatefulWidget {
  AssetPathEntity item;
  String title;
  VideosPage({Key? key, required this.item, required this.title})
      : super(key: key);

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final playlistBox = Hive.box('playlist');
  bool found = false;
  @override
  void initState() {
    super.initState();
    final ads = Provider.of<GetAds>(context, listen: false);
    ads.createBackInterstitialad();
    ads.videospagebanner();
    ads.CreateVideoiniterstitial();
    WidgetsBinding.instance.addPostFrameCallback((_) => getvideos());
  }

  getvideos() async {
    await showLoaderDialog(context);
    var videocontroller =
        Provider.of<GalleryFolderController>(context, listen: false);
    await videocontroller.videoinfolders(widget.item);
    Future.delayed(const Duration(seconds: 1), (() => Navigator.pop(context)));
  }

  Future<void> createItem(Map<String, dynamic> newItem) async {
    await playlistBox.add(newItem); // update the UI
  }

  void function(index) async {
    final ads = Provider.of<GetAds>(context, listen: false);
    File? file = await videolist[index].file;
    String title = videolist[index].title.toString();
    Uint8List thumbnail = videothumbnailuint[index];
    final data = playlistBox.keys.map((key) {
      final value = playlistBox.get(key);
      return {"key": key, "url": value["url"]};
    }).toList();
    var list = data;
    if (list.isNotEmpty) {
      for (var items in list) {
        if (items["url"].toString() == file?.path) {
          found = true;
        }
      }
    }
    if (found == false) {
      await createItem(
          {"url": file?.path, "title": title, "thumbnail": thumbnail});
    }
    //ads.showvideoint();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Video(
                  f: file!,
                )));
  }

  @override
  Widget build(BuildContext context) {
    var videocontroller = Provider.of<GalleryFolderController>(context);
    final ads = Provider.of<GetAds>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              ads.showbackinterstitial();
              Future.delayed(Duration(seconds: 1), () {
                Navigator.pop(context);
              });
            },
            child: const Icon(Icons.arrow_back)),
        backgroundColor: const Color(0xff011339),
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(homebg), fit: BoxFit.fill)),
        child: videocontroller.isloading
            ? Container()
            : Padding(
                padding: EdgeInsets.all(0.8.h),
                child: videolist.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Lottie.asset(
                                "assets/images/107420-no-data-loader.json"),
                            Text(
                              "No Videos Found!",
                              style: GoogleFonts.poppins(
                                  letterSpacing: 2.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: videolist.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              // await getxdialog();

                              ads.showvideoint();
                              // Get.back();
                              function(index);
                            },
                            child: Container(
                              height: 10.h,
                              padding: const EdgeInsets.only(
                                  left: 6, top: 6, right: 6),
                              margin: EdgeInsets.only(bottom: 0.7.h),
                              decoration:
                                  const BoxDecoration(color: Colors.black26),
                              child: Row(
                                children: [
                                  Stack(children: [
                                    Container(
                                      width: 25.w,
                                      height: 9.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 1)),
                                      child: Image.memory(
                                        videothumbnailuint[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      width: 25.w,
                                      height: 9.h,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                        size: 29,
                                      ),
                                    )
                                  ]),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      SizedBox(
                                        width: 60.w,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          videolist[index].title == ""
                                              ? "<No Name>"
                                              : videolist[index]
                                                  .title
                                                  .toString(),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0.8.w,
                                      ),
                                      Row(
                                        children: [
                                          mytext(Colors.lightBlue, "Duration: ",
                                              FontWeight.w700),
                                          mytext(
                                              Colors.white,
                                              videocontroller.formatTime(
                                                  videolist[index].duration),
                                              FontWeight.w400),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
      ),
      bottomNavigationBar: Stack(children: [
        Container(
            color: Colors.white,
            width: double.infinity,
            height: 7.h,
            child: ads.isvideospagebannerloaded == true
                ? AdWidget(ad: ads.videosPage)
                : Center(
                    child: Container(
                    child: Center(
                        child: Text(
                      "Advertisement",
                      style: TextStyle(color: Colors.black),
                    )),
                  ))),
      ]),
    );
  }
}
