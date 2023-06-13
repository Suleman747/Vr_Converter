import 'dart:io';

import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../Controllers/AdsController.dart';
import '../Utils/Utils.dart';
import '../Widgets/dialog.dart';
import 'VideoPlayer/Videoplayer.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({Key? key}) : super(key: key);

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  List<Map<String, dynamic>> _items = [];

  final playlistBox = Hive.box('playlist');

  @override
  void initState() {
    super.initState();
    final ads = Provider.of<GetAds>(context, listen: false);
    ads.playlistpageBanner();
    ads.CreateVideoiniterstitial();
    _refreshItems(); // Load data when app starts
  }

  void _refreshItems() async {
    final data = playlistBox.keys.map((key) {
      final value = playlistBox.get(key);
      return {
        "key": key,
        "url": value["url"],
        "title": value["title"],
        "thumbnail": value["thumbnail"]
      };
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      // we use "reversed" to sort items in order from the latest to the oldest
    });
  }

  // Retrieve a single item from the database by using its key
  // Our app won't use this function but I put it here for your reference
  Map<String, dynamic> readItem(int key) {
    final item = playlistBox.get(key);
    return item;
  }

  // Delete a single item
  Future<void> _deleteItem(int itemKey) async {
    await playlistBox.delete(itemKey);
    _refreshItems();
  }

  @override
  Widget build(BuildContext context) {
    final ads = Provider.of<GetAds>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff011339),
        title: SizedBox(
          width: 20.w,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "Playlist",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(homebg), fit: BoxFit.fill)),
        child: Padding(
          padding: EdgeInsets.all(0.3.h),
          child: _items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Lottie.asset("assets/images/107420-no-data-loader.json"),
                      Text(
                        "Empty playlist!",
                        style: GoogleFonts.poppins(
                            letterSpacing: 2.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          await getxdialog();
                          Future.delayed(const Duration(seconds: 1), () {
                            ads.showvideoint();
                            Get.to(Video(
                              f: File(_items[index]["url"]),
                            ));
                          });
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
                                  child: Image.memory(
                                    _items[index]["thumbnail"],
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 47.w,
                                    child: Text(
                                      _items[index]["title"],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  _deleteItem(_items[index]['key']);
                                },
                                child: CircleAvatar(
                                    backgroundColor: const Color(0xff011999),
                                    radius: 2.h,
                                    child: const Icon(Icons.delete)),
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
            child: ads.isplaylistpagebannerloaded == true
                ? AdWidget(ad: ads.playlistPage)
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
