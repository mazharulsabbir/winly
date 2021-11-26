import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/configs/facebook_audience.dart';
import 'package:winly/globals/configs/strings.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/models/quizz.dart';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:winly/services/api/ad.dart';

class QuizeScreen extends StatefulWidget {
  const QuizeScreen({Key? key}) : super(key: key);

  @override
  State<QuizeScreen> createState() => _QuizeScreenState();
}

class _QuizeScreenState extends State<QuizeScreen> {
  final List<QuizzQuestion> dummyQestion = quizzQuestions;
  final AuthController authController = Get.find<AuthController>();

  int selectedIndex = 0;
  int _questionIndex = 0;

  bool _isInterstitialAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  _questionTitle() {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: 'Question ${dummyQestion[_questionIndex].id}',
        style: const TextStyle(fontSize: 25, color: Colors.blue),
      ),
      TextSpan(
        text: '/${dummyQestion.length}',
        style: const TextStyle(color: Colors.grey),
      )
    ]));
  }

  _questionBody(QuizzQuestion question) {
    return Text(
      "${question.question}",
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
    );
  }

  _answerPart(List<String>? answers) {
    answerTile(bool isSelected, String? data, int index) {
      const double circleraduis = 20;
      return GestureDetector(
        onTap: () {
          setState(() => selectedIndex = index);
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(13)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$data",
                style: const TextStyle(fontSize: 16),
              ),
              isSelected
                  ? Container(
                      height: circleraduis,
                      width: circleraduis,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: const Icon(
                        Icons.done,
                        size: 12,
                      ),
                    )
                  : Container(
                      height: circleraduis,
                      width: circleraduis,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                    )
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (_, index) {
        return answerTile(index == selectedIndex, answers![index], index);
      },
      separatorBuilder: (_, i) {
        return const SizedBox(
          height: 15,
        );
      },
      itemCount: answers?.length ?? 0,
      shrinkWrap: true,
    );
  }

  button() {
    return ElevatedButton(
      onPressed: () async {
        if (_isInterstitialAdLoaded) {
          DailyEarnings? _earnings = await _showInterstitialAd();
          authController.updateUserEarnings(_earnings);
        } else {
          debugPrint('Ad is not loaded');
        }

        setState(() {
          selectedIndex = 0;
          if (_questionIndex == dummyQestion.length - 1) {
            _questionIndex = 0;
          } else {
            _questionIndex++;
          }
        });
      },
      child: const Text('Next'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child: _questionTitle(),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          _questionBody(dummyQestion[_questionIndex]),
          const Spacer(),
          _answerPart(dummyQestion[_questionIndex].answers),
          const SizedBox(
            height: 20,
          ),
          button()
        ],
      ),
    );
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: adUnitId,
      listener: (result, value) {
        debugPrint(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED) {
          _isInterstitialAdLoaded = true;
        }

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }

  Future<DailyEarnings?> _showInterstitialAd() async {
    if (_isInterstitialAdLoaded == true) {
      await FacebookInterstitialAd.showInterstitialAd();
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
    } else {
      debugPrint("Interstitial Ad not yet loaded!");
      return null;
    }
  }
}
