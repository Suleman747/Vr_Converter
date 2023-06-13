// ignore_for_file: use_build_context_synchronously
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/languages.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:vr_converter/Controllers/AdsController.dart';
import '../Utils/Utils.dart';
import '../Widgets/dialog.dart';
import '../Widgets/onwillpopdialog.dart';
import '../Widgets/widgets.dart';
import 'HomePage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var ps;
  var prefs;
  @override
  void initState() {
    super.initState();
    permissionrequest();
    getlang();
    final ads = Provider.of<GetAds>(context, listen: false);
    ads.landingPageBanner();
    ads.createstartint();
  }

  permissionrequest() async {
    ps = await PhotoManager.requestPermissionExtend();
  }

  getlang() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final ads = Provider.of<GetAds>(context);
    return WillPopScope(
        onWillPop: () {
          return openDialog(context);
        },
        child: SafeArea(
          child: Scaffold(
            body: Container(
              padding: const EdgeInsets.all(8.0),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(landingbg), fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: SizedBox(
                        width: 80.w,
                        child: FittedBox(
                            child: mytext(
                                Colors.white, "app_name".tr, FontWeight.bold))),
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Center(
                    child: SizedBox(
                        width: 80.w,
                        child: FittedBox(
                            alignment: Alignment.center,
                            child: mytext(
                                Colors.white, "slogan".tr, FontWeight.normal))),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 25.w,
                          child: FittedBox(
                              child: mytext(Colors.white, "version".tr,
                                  FontWeight.normal))),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              openLanguagePickerDialog();
                            },
                            child: Icon(
                              Icons.g_translate_rounded,
                              size: 10.w,
                              color: Colors.white,
                            ),
                          ),
                          Text("language".tr,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14))
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 65.h,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        // await getxdialog();

                        if (ps == PermissionState.authorized) {
                          ads.showstartint();

                          gallerylist = [];
                          galleryuint = [];
                          totalvideos = [];
                          // Get.back();
                          Get.to(() => const Homepage());
                        } else {
                          // Get.back();
                          addToast("Give permission to continue!");
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5.w),
                        padding: EdgeInsets.only(left: 15.w, right: 4.w),
                        width: 40.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(startbg), fit: BoxFit.fill)),
                        child: FittedBox(
                            child: mytext(Colors.white, "start_button".tr,
                                FontWeight.normal)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Stack(children: [
              Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 7.h,
                  child: ads.islandingbannerloaded == true
                      ? AdWidget(ad: ads.landingPage)
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
          ),
        ));
  }

  final supportedLanguages = [
    Languages.english,
    Languages.french,
    Languages.urdu,
    Languages.portuguese,
    Languages.hindi,
    Languages.arabic,
    Languages.spanish,
    Languages.dutch
  ];

// It's sample code of Dialog Item.
  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          const SizedBox(width: 8.0),
          Flexible(child: Text("(${language.isoCode})"))
        ],
      );

  void openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: LanguagePickerDialog(
                languages: supportedLanguages,
                titlePadding: const EdgeInsets.all(8.0),
                title: const Text('Select your language'),
                onValuePicked: (Language language) async {
                  await prefs.setString('lang', language.isoCode.toString());
                  setState(() {
                    currentlang = language.isoCode;

                    print(currentlang);
                    Get.updateLocale(Locale(language.isoCode));
                  });
                },
                itemBuilder: _buildDialogItem)),
      );
}
