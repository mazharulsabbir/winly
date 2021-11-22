import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.emailAddress}) : super(key: key);

  final String emailAddress;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _isEmailVerificationTimeout = false;
  bool isLoading = false;
  bool _onEditing = true;

  CountdownTimerController? controller;
  void onEnd() {
    print("TIMEOUT");
  }

  Widget _verify() {
    return Column(
      children: <Widget>[
        const Text(
          'Verify email',
          style: TextStyle(fontSize: 20.0),
        ),
        const SizedBox(
          height: 4,
        ),
        const Text(
          "We have sent a code to your email address",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        if (_isEmailVerificationTimeout)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Verification Timeout',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                  },
                  child: const Text("Resend again")),
            ],
          )
        else
          CountdownTimer(
            controller: controller,
            onEnd: onEnd,
            endTime: 3,
            widgetBuilder: (_, CurrentRemainingTime? time) {
              if (time == null) {
                return const SizedBox();
              }
              return Text(
                "00:${time.sec}",
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        VerificationCode(
          textStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
          keyboardType: TextInputType.number,
          underlineColor: Colors.green,
          length: 6,
          onCompleted: (String value) {},
          onEditing: (bool value) {
            if (!_onEditing) FocusScope.of(context).unfocus();
          },
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(onPressed: () {}, child: const Text('Varify'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonLeading(),
        title: const Text('OTP varification'),
      ),
      body: CommonLoadingOverlay(
        loading: isLoading,
        child: Center(child: _verify()),
      ),
    );
  }
}
