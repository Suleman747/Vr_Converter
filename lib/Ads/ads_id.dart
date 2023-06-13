// import 'dart:io';

// import 'package:easy_ads_flutter/easy_ads_flutter.dart';

// class TestAdIdManager extends IAdIdManager {
//   const TestAdIdManager();

//   @override
//   AppAdIds? get admobAdIds => AppAdIds(
//         appId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544~3347511713'
//             : 'ca-app-pub-3940256099942544~1458002511',
//         bannerId: 'ca-app-pub-3940256099942544/6300978111',
//         interstitialId: 'ca-app-pub-3940256099942544/1033173712',
//       );

//   @override
//   AppAdIds? get unityAdIds => const AppAdIds(appId: '');

//   @override
//   AppAdIds? get appLovinAdIds => AppAdIds(
//         appId:
//             'OeKTS4Zl758OIlAs3KQ6-3WE1IkdOo3nQNJtRubTzlyFU76TRWeQZAeaSMCr9GcZdxR4p2cnoZ1Gg7p7eSXCdA',
//         bannerId: Platform.isAndroid ? 'b2c4f43d3986bcfb' : '80c269494c0e45c2',
//         interstitialId:
//             Platform.isAndroid ? 'c48f54c6ce5ff297' : 'e33147110a6d12d2',
//       );

//   @override
//   AppAdIds? get fbAdIds => AppAdIds(
//         appId: '',
//         interstitialId:
//             Platform.isAndroid ? 'YOUR_PLACEMENT_ID' : 'YOUR_PLACEMENT_ID',
//         bannerId:
//             Platform.isAndroid ? 'YOUR_PLACEMENT_ID' : 'YOUR_PLACEMENT_ID',
//       );
// }