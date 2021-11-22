import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/helpers/text_field_helpers.dart';
import 'package:winly/pages/login/login_screen.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.emailAddress}) : super(key: key);

  final String emailAddress;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _onEditing = true;
  bool isHeaden = true;

  String code = '';

  TextEditingController passwordController = TextEditingController();
  final passwordFormKey = GlobalKey<FormState>();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(
      8,
      errorText: 'password must be at least 8 digits long',
    ),
  ]);

  Widget setPassword(AuthController authController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Form(
        key: passwordFormKey,
        child: Column(
          children: <Widget>[
            const Text(
              'Set your new Password',
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
            VerificationCode(
              textStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
              keyboardType: TextInputType.number,
              underlineColor: Colors.green,
              length: 6,
              onCompleted: (String value) {
                setState(() => code = value);
              },
              onEditing: (bool value) {
                setState(() {
                  _onEditing = value;
                });
                if (!_onEditing) FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: TextFieldHelpers.decoration(label: 'New Password')
                  .copyWith(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() => isHeaden = !isHeaden);
                          },
                          icon: Icon(isHeaden
                              ? Icons.visibility
                              : Icons.visibility_off))),
              obscureText: isHeaden,
              validator: passwordValidator,
              controller: passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  print('Code: $code and oassword: ${passwordController.text}');
                  if (passwordFormKey.currentState != null) {
                    passwordFormKey.currentState!.save();
                    if (passwordFormKey.currentState!.validate() &&
                        code.length == 6) {
                      await authController
                          .setNewPassword(
                              code: code, newPass: passwordController.text)
                          .then((value) {
                        value ? Get.offAll(() => const SignInScreen()) : null;
                      });
                    }
                  }
                },
                child: const Text('Submit'))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonLeading(),
        title: const Text('OTP varification'),
      ),
      body: GetBuilder<AuthController>(builder: (controller) {
        return CommonLoadingOverlay(
          loading: controller.isLoading,
          child: Center(child: setPassword(controller)),
        );
      }),
    );
  }
}
