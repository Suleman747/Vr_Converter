import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:vr_converter/Controllers/AdsController.dart';
import 'package:vr_converter/Ui/LandingScreen.dart';
import '../Utils/Utils.dart';
import '../Widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var prefs;
  @override
  void initState() {
    getlang();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LandingPage()));
    });
    super.initState();
  }

  getlang() async {
    prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('lang');
    log("mylang=${action}");
    if(action==null){
  Get.updateLocale(Locale('en'));
    }
    else{
  Get.updateLocale(Locale(action.toString()));
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(splashbg), fit: BoxFit.fill)),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 18.h,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 4.h,
              ),
            ),
            SizedBox(
              height: 45.w,
              width: 45.w,
              child: Image.asset(
                vriconoutline,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 2.h,
              ),
            ),
            Center(
              child: SizedBox(
                  width: 80.w,
                  child: FittedBox(
                      child: mytext(
                          Colors.white, "app_name".tr, FontWeight.bold))),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
                width: 25.w,
                child: FittedBox(
                    alignment: Alignment.center,
                    child:
                        mytext(Colors.white, "version".tr, FontWeight.normal))),
            Expanded(
              child: SizedBox(
                height: 3.h,
              ),
            ),
            Lottie.asset(splashloader),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}
