import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white54,
    content: Row(
      children: [
        const CircularProgressIndicator(
          strokeWidth: 2.0,
          color: Color(0xff011339),
        ),
        Container(
            margin: const EdgeInsets.only(left: 12),
            child: const Text(
              "Loading...",
              style: TextStyle(color: Color(0xff011339)),
            )),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


 getxdialog() {
  Get.defaultDialog(
    title: "Showing Ads",
    content:  const Padding(
      padding: EdgeInsets.only(bottom: 14.0),
      child: spinkitt
    ),
    backgroundColor: const Color(0xff011339),
    barrierDismissible: false,
    titleStyle: const TextStyle(color: Colors.white),
  );
}


const spinkitt = SpinKitWave(
  color: Colors.white,
  size: 50.0,
);
