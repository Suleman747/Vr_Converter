import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/Utils.dart';
import 'widgets.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => MainDrawerState();
}

class MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xff011339),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Container(
              height: 25.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color(0xff011339),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    height: 12.h,
                    width: 27.w,
                    child: Image(
                      image: AssetImage(drawericon),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  mytext(Colors.white60, "app_name".tr, FontWeight.w600),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            items(
                text: "more".tr,
                ic: Icons.apps,
                ontap: () {
                  launch(
                      "https://apps.apple.com/in/developer/ashraf-masood/id1638116619");
                }),
            // items(
            //     text: "rate".tr,
            //     ic: Icons.thumb_up_alt_rounded,
            //     ontap: () {
            //       launch(
            //           "https://play.google.com/store/apps/details?id=com.appex.vr.sbs.video.converter.player");
            //     }),
            items(
                text: "feedback".tr,
                ic: Icons.feedback_rounded,
                ontap: () {
                  launchUrl(Uri(
                    scheme: 'mailto',
                    path: 'skhastech@gmail.com',
                    query: 'VR Video Converter & Player',
                  ));
                }),
            // items(
            //     text: "share".tr,
            //     ic: Icons.share,
            //     ontap: () {
            //       Share.share(
            //           'Get the App using link below  \n http://play.google.com/store/apps/details?id=com.appex.vr.sbs.video.converter.player');
            //     }),
            items(
                text: "privacy".tr,
                ic: Icons.privacy_tip_rounded,
                ontap: () {
                  launch(
                      "https://sites.google.com/view/vr-video-convert-privacypolicy/privacy-policy");
                }),
          ],
        ),
      ),
    );
  }
}

class items extends StatefulWidget {
  String text;
  IconData ic;
  VoidCallback ontap;
  items({Key? key, required this.text, required this.ic, required this.ontap})
      : super(key: key);

  @override
  State<items> createState() => _itemsState();
}

class _itemsState extends State<items> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        widget.ic,
        color: Colors.white60,
        size: 25,
      ),
      title: Text(
        widget.text,
        style: drawerstyle(),
      ),
      onTap: widget.ontap,
    );
  }
}

TextStyle drawerstyle() {
  return TextStyle(
    color: Colors.white60,
    // fontWeight: FontWeight.bold,
    fontSize: 13.sp,
    fontFamily: "bariolbold",
  );
}

Future launch(String url) async {
  try {
    await launchUrl(Uri.parse(url));
  } on Exception {
    print("Error");
  }
}
