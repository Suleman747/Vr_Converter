import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../Ads/Adsids.dart';

enum AdLoadState { notLoaded, loading, loaded }

class GetAds extends ChangeNotifier {
  bool loading = true;
  // banner at landing page
  late BannerAd landingPage;
  bool islandingbannerloaded = false;
  // banner at landing page
  late BannerAd homePage;
  bool ishomepagebannerloaded = false;
  // banner at videos page
  late BannerAd videosPage;
  bool isvideospagebannerloaded = false;
  // banner at playlist page
  late BannerAd playlistPage;
  bool isplaylistpagebannerloaded = false;

  onloading() async {
    loading = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    loading = false;
    notifyListeners();
  }

  homeBanner() {
    homePage = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        ishomepagebannerloaded = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        ishomepagebannerloaded = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    homePage.load();
  }

  videospagebanner() {
    videosPage = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        isvideospagebannerloaded = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        isvideospagebannerloaded = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    videosPage.load();
  }

  landingPageBanner() {
    landingPage = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        islandingbannerloaded = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        islandingbannerloaded = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    landingPage.load();
  }

  playlistpageBanner() {
    playlistPage = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        isplaylistpagebannerloaded = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        isplaylistpagebannerloaded = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    playlistPage.load();
  }

  static AdRequest request = const AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd? startint;
  InterstitialAd? folderint;
  InterstitialAd? backint;
  InterstitialAd? cardint;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  createstartint() {
    InterstitialAd.load(
        adUnitId: AdIds.startint,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('\n $ad loaded');
            startint = ad;
            _numInterstitialLoadAttempts = 0;
            startint!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('\nInterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            startint = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createstartint();
            }
          },
        ));
  }

  createfolderint() {
    InterstitialAd.load(
        adUnitId: AdIds.folderint,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('\n $ad loaded');
            folderint = ad;
            _numInterstitialLoadAttempts = 0;
            folderint!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('\nInterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            folderint = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createfolderint();
            }
          },
        ));
  }

  createBackInterstitialad() {
    InterstitialAd.load(
        adUnitId: AdIds.backint,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('\n $ad loaded');
            backint = ad;
            _numInterstitialLoadAttempts = 0;
            backint!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('\nInterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            backint = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createBackInterstitialad();
            }
          },
        ));
  }

  CreateVideoiniterstitial() {
    InterstitialAd.load(
        adUnitId: AdIds.videoint,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('\n $ad loaded');
            cardint = ad;
            _numInterstitialLoadAttempts = 0;
            cardint!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('\nInterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            cardint = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              CreateVideoiniterstitial();
            }
          },
        ));
  }

  showfolderint() {
    if (folderint == null) {
      print('\nWarning: attempt to show interstitial before loaded.');
      load_applovin_inter();
      return;
    }
    folderint!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('\nad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createfolderint();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createfolderint();
      },
    );
    folderint!.show();
    folderint = null;
  }

  showstartint() {
    if (startint == null) {
      print('\nWarning:1 attempt to show interstitial before loaded.');
      load_applovin_inter();
      return;
    }
    startint!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('\nad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createstartint();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createstartint();
      },
    );
    startint!.show();
    startint = null;
  }

  showbackinterstitial() {
    if (backint == null) {
      print('\nWarning: attempt to show interstitial before loaded.');
      load_applovin_inter();
      return;
    }
    backint!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('\nad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createBackInterstitialad();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createBackInterstitialad();
      },
    );
    backint!.show();
    backint = null;
  }

  showvideoint() {
    if (cardint == null) {
      print('\nWarning: attempt to show interstitial before loaded.');
      load_applovin_inter();
      return;
    }
    cardint!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('\nad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        CreateVideoiniterstitial;
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        CreateVideoiniterstitial();
      },
    );
    cardint!.show();
    cardint = null;
  }

  //APPLOVIN

  final String sdkkey =
      "LTVla0Ir4MFk1XkJtPoDUfB2qvtJTTFXrNTTf9ROZIQZUtWXBwAZPd4IgfzhqJA2QdhWnzUFo-Z-e6_Wb_z4zy";

// final String _interstitial_ad_unit_id = Platform.isAndroid ? "ed2ccb449fa0d67e" : "IOS_INTER_AD_UNIT_ID";
  final String _interstitial_ad_unit_id = "66e719a1be64dd7b";

// Create states
  var _isInitialized = false;
  var _interstitialLoadState = AdLoadState.notLoaded;
  var _interstitialRetryAttempt = 0;
  var _statusText = "";

  Future<void> initialize_applovin() async {
    print("initialize_applovin called");
    // logStatus("Initializing SDK...");
    // _isInitialized = true;
    // attachAdListeners();
    Map? configuration = await AppLovinMAX.initialize(sdkkey);
    if (configuration != null) {
      _isInitialized = true;

      // logStatus("SDK Initialized: $configuration");

      attachAdListeners();
    }
  }

  void attachAdListeners() {
    print("inside attachAdListeners");

    /// Interstitial Ad Listeners
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        _interstitialLoadState = AdLoadState.loaded;

        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialAdReady(_interstitial_ad_unit_id) will now return 'true'
        // logStatus('Interstitial ad loaded from ' + ad.networkName);

        // Reset retry attempt
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        print("app lovin failed ti load");
        _interstitialLoadState = AdLoadState.notLoaded;

        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();
        // logStatus('Interstitial ad failed to load with code ' + error.code.toString() + ' - retrying in ' + retryDelay.toString() + 's');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          print("\nDelayed called for apploving");
          AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);
        });
      },
      onAdDisplayedCallback: (ad) {
        // logStatus('Interstitial ad displayed');
      },
      onAdDisplayFailedCallback: (ad, error) {
        _interstitialLoadState = AdLoadState.notLoaded;
        // logStatus('Interstitial ad failed to display with code ' + error.code.toString() + ' and message ' + error.message);
      },
      onAdClickedCallback: (ad) {
        // logStatus('Interstitial ad clicked');
      },
      onAdHiddenCallback: (ad) {
        _interstitialLoadState = AdLoadState.notLoaded;
        // logStatus('Interstitial ad hidden');
      },
    ));
  }
  bool isReady =false;
  void load_applovin_inter() async {
    print("load_applovin_inter called");
    AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);

      isReady=  (await AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id))!;
    print("enter");
    if (isReady) {
      print("AppLovinMAX.showInterst called");
      AppLovinMAX.showInterstitial(_interstitial_ad_unit_id);
    } else {
      print("khurram");
      //   print("pLovinMAX.loadInterstiti called");
      // // logStatus('Loading interstitial ad...');
      // _interstitialLoadState = AdLoadState.loading;
      // AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);
    }
  }
}
