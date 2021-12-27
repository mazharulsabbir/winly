import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:winly/globals/configs/admob_ids.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/services/api/ad.dart';

class AdsController extends GetxController {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  final AuthController _authController = Get.find<AuthController>();
  static const AdRequest _request = AdRequest(nonPersonalizedAds: true);

  @override
  void onInit() {
    super.onInit();
    debugPrint("==== ads controller init =====");

    _createInterstitialAd();
    _createRewardVideoAd();
  }

  void _createInterstitialAd() {
    debugPrint("_createInterstitialAd::called()");

    // "ca-app-pub-2245972702677610/3391545597"
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: _request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('$ad loaded');
          _interstitialAd = ad;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          _createInterstitialAd();
          debugPrint("Failed to load ad. ${error.message}");
        },
      ),
    );
  }

  void showInterstitialAd([bool adReward = false]) {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();

        if (adReward) {
          _getAdReward().then((value) {
            DailyEarnings? _earnings = value;
            _authController.updateUserEarnings(_earnings);
          });
        }

        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _createRewardVideoAd() {
    debugPrint("_createRewardVideoAd::called()");

    RewardedAd.load(
      adUnitId: rewardVideoAdUnitId,
      request: _request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          debugPrint('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  void showRewardVideoAd([bool adReward = false]) {
    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          debugPrint('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => debugPrint('$ad impression occurred.'),
    );

    _rewardedAd?.show(onUserEarnedReward: (
      RewardedAd ad,
      RewardItem rewardItem,
    ) {
      // Reward the user for watching an ad.
      if (adReward) {
        _getAdReward().then((value) {
          DailyEarnings? _earnings = value;
          _authController.updateUserEarnings(_earnings);
        });
      }

      // create new reward
      _createRewardVideoAd();
    });
  }

  Future<DailyEarnings?> _getAdReward() async {
    try {
      final _response = await AdAPI.requestForTicket(adStatus: '1');
      DailyEarnings _earnings = DailyEarnings.fromJson(
        _response.data['user_wallet'],
      );
      debugPrint('Ad reward -> ' + _earnings.toString());
      return _earnings;
    } catch (e) {
      debugPrint('Error to add reward -> ' + e.toString());
      return null;
    }
  }

  @override
  void onClose() {
    debugPrint("===ads controller closed===");
    super.onClose();
  }
}
