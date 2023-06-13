// ignore_for_file: file_names

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_manager/photo_manager.dart';

//Asset images
String splashbg = "assets/images/splash_bg.png";
String landingbg = "assets/images/landing_bg.png";
String startbg = "assets/images/start_bg.png";
String vriconoutline = "assets/images/vr_icon_outline.png";
String splashloader = "assets/images/9844-loading-40-paperplane.json";
String drawericon = "assets/images/vr_icon.png";
String homebg = "assets/images/bg_film_blue.png";
String vricon = "assets/images/vricon.svg";
String novricon = "assets/images/vricon12.svg";

//lists used in video album getting

List<Uint8List> galleryuint = <Uint8List>[];
List<AssetPathEntity> gallerylist = <AssetPathEntity>[];
List<int> totalvideos = [];

//lists used in getting videos from every album

List<AssetEntity> videolist = <AssetEntity>[];
List<Uint8List> videothumbnailuint = <Uint8List>[];
bool refreshing = false;
int assetcount = 0;

//language
String currentlang = "en";


//toast
   void addToast(String toastMessage) {
    Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey.shade500,
        textColor: Colors.white
    );
  }