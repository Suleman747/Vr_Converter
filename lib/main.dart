import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:vr_converter/Controllers/AdsController.dart';
import 'package:vr_converter/Controllers/GalleryFolderController.dart';
import 'package:vr_converter/Ui/SplashScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Locale/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  MobileAds.instance.initialize();
  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk('shopping_box');
  await Hive.openBox('playlist');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    GetAds applovin = GetAds();
    applovin.initialize_applovin();
  }

  @override
  Widget build(BuildContext context) {
    GalleryFolderController gallerycontroller = GalleryFolderController();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context) => gallerycontroller),
          ),
          ChangeNotifierProvider(
            create: ((context) => GetAds()),
          ),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return GetMaterialApp(
              translations: Languages(),
              locale: Get.deviceLocale,
              fallbackLocale: const Locale('en', 'US'),
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark(),
              home: const SplashScreen());
        }));
  }
}
