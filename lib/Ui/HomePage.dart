import 'dart:io';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:vr_converter/Controllers/GalleryFolderController.dart';
import 'package:vr_converter/Ui/VideosPage.dart';
import 'package:vr_converter/Widgets/widgets.dart';
import '../Controllers/AdsController.dart';
import '../Utils/Utils.dart';
import '../Widgets/dialog.dart';
import '../Widgets/drawer.dart';
import 'PlayListPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    final ads = Provider.of<GetAds>(context, listen: false);
    ads.homeBanner();

    ads.createfolderint();
    WidgetsBinding.instance.addPostFrameCallback((_) => getvideofolders());
    super.initState();
  }

  getvideofolders() async {
    var gallerycontroller =
        Provider.of<GalleryFolderController>(context, listen: false);
    if (galleryuint.isEmpty || gallerylist.isEmpty || totalvideos.isEmpty) {
      await showLoaderDialog(context);
      await gallerycontroller.galleryfolderlist();
      print("list${gallerylist.length}");
      Future.delayed(
          const Duration(microseconds: 100), (() => Navigator.pop(context)));
    } else {
      gallerycontroller.loader();
    }
  }

  @override
  Widget build(BuildContext context) {
    var gallerycontroller = Provider.of<GalleryFolderController>(context);
    final ads = Provider.of<GetAds>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff011339),
        actions: [
          IconButton(
            tooltip: "Playlist",
            onPressed: () {
              ads.showfolderint();
              Future.delayed(const Duration(seconds: 1), () {});
              Get.to(const PlayListPage());
            },
            icon: const Icon(
              Icons.playlist_play,
              size: 38,
            ),
          ),
          SizedBox(width: 2.w)
        ],
        title: SizedBox(
          width: 60.w,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "app_name".tr,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      drawer: const MainDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(homebg), fit: BoxFit.fill)),
        child: gallerycontroller.isloading
            ? Container()
            : Padding(
                padding: EdgeInsets.all(0.3.h),
                child: gallerylist.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Lottie.asset(
                              'assets/images/107420-no-data-loader.json',
                              repeat: true,
                              animate: true,
                              alignment: Alignment.center,
                            ),
                            Text(
                              "No  Albums Found!",
                              style: GoogleFonts.poppins(
                                  letterSpacing: 2.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ])
                    : ListView.builder(
                        itemCount: gallerylist.length,
                        itemBuilder: (context, index) {
                          print("this is list${gallerylist.length}");
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                // await getxdialog();

                                ads.showfolderint();
                                gallerycontroller.isloading = true;
                                videolist = [];
                                videothumbnailuint = [];
                                final AssetPathEntity item = gallerylist[index];
                                if (item.albumType == 2) {
                                  addToast("The folder can't get Videos");
                                  return;
                                }
                                if (await item.assetCountAsync == 0) {
                                  addToast("The folder has no videos");
                                  return;
                                }
                                // Get.back();
                                Get.to(() => VideosPage(
                                    item: item,
                                    title: gallerylist[index].name == ""
                                        ? "Unknown"
                                        : gallerylist[index].name.toString()));
                              },
                              child: Container(
                                height: 10.h,
                                padding: const EdgeInsets.all(6),
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
                                        // child: CircularProgressIndicator(),
                                        child: galleryuint[index].isEmpty
                                            ? const CircularProgressIndicator()
                                            : Image.memory(
                                                galleryuint[index],
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      Container(
                                        width: 25.w,
                                        height: 9.h,
                                        alignment: Alignment.bottomRight,
                                        child: const Icon(
                                          Icons.folder,
                                          color: Colors.lightBlue,
                                        ),
                                      )
                                    ]),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 2.w,
                                        ),
                                        mytext(
                                            Colors.white,
                                            gallerylist[index].name == ""
                                                ? "Unknown"
                                                : gallerylist[index]
                                                    .name
                                                    .toString(),
                                            FontWeight.w600),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        mytext(
                                            Colors.white,
                                            "Videos:${totalvideos[index]}",
                                            FontWeight.normal),
                                      ],
                                    )
                                  ],
                                ),
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
            child: ads.ishomepagebannerloaded == true
                ? AdWidget(ad: ads.homePage)
                : Center(
                    child: Container(
                    child: Center(
                        child: Text(
                      "Advertisement",
                      style: TextStyle(color: Colors.black),
                    )),
                  ))
                  ),
      ]),
      // bottomNavigationBar: Stack(children: [
      //   Container(
      //     padding: EdgeInsets.all(8),
      //     color: Colors.white,
      //     width: double.infinity,
      //     height: 7.h,
      //     child: FacebookBannerAd(
      //       placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
      //       bannerSize: BannerSize.STANDARD,
      //       listener: (result, value) {
      //         switch (result) {
      //           case BannerAdResult.ERROR:
      //             print("Error: $value");
      //             break;
      //           case BannerAdResult.LOADED:
      //             print("Loaded: $value");
      //             break;
      //           case BannerAdResult.CLICKED:
      //             print("Clicked: $value");
      //             break;
      //           case BannerAdResult.LOGGING_IMPRESSION:
      //             print("Logging Impression: $value");
      //             break;
      //         }
      //       },
      //     ),
      //   ),
      //   Container(
      //       alignment: Alignment.topRight,
      //       width: double.infinity,
      //       color: Colors.transparent,
      //       height: 7.h,
      //       child: Container(
      //         color: Colors.yellow,
      //         child: const Text(
      //           "Ad",
      //           style: TextStyle(color: Colors.black),
      //         ),
      //       )),
      // ])
    );
  }
}
