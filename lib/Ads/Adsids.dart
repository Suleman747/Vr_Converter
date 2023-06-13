import 'dart:io';

class AdIds {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6044006890313003/7107390712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6044006890313003/8864124547';
    }
    return "";
  }

  static String get startint {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6044006890313003/5455413608';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6044006890313003/2298716194';
    }
    return "";
  }

  static String get backint {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6044006890313003/6676888759';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6044006890313003/8480981163';
    }
    return "";
  }

  static String get videoint {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6044006890313003/4242297100';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6044006890313003/8330019499';
    }
    return "";
  }


  static String get folderint {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6044006890313003/6641480729';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6044006890313003/2107144505';
    }
    return "";
  }

  static String get applovinint {
    return 'd4c24bfd0bf46cc5';
  }
}
