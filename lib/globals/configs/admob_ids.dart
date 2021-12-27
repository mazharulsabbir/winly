import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

String interstitialAdUnitId = !kReleaseMode
    ? InterstitialAd.testAdUnitId
    : "ca-app-pub-2245972702677610/3391545597";

String rewardVideoAdUnitId = !kReleaseMode
    ? RewardedAd.testAdUnitId
    : "ca-app-pub-2245972702677610/5796951737";
