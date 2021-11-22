import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/helpers/text_field_helpers.dart';
import 'package:winly/pages/forgot_password/otp_screen.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailFormKey = GlobalKey<FormState>();

  String email = '';

  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'enter a valid email address')
  ]);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        leading: const CommonLeading(),
        title: const Text('Fotgot password'),
      ),
      body: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (controller) {
            return CommonLoadingOverlay(
              loading: controller.isLoading,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Form(
                  key: _emailFormKey,
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: const Text('Input your valid email here')),
                      TextFormField(
                        decoration: TextFieldHelpers.decoration(
                          label: 'Email',
                          hint: "yourname@example.com",
                        ),
                        validator: _emailValidator,
                        onSaved: (value) => email = value!,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_emailFormKey.currentState != null) {
                            _emailFormKey.currentState!.save();
                            if (_emailFormKey.currentState!.validate()) {
                              print(email);
                              await controller.forgatePassword(email).then(
                                  (value) => value
                                      ? Get.to(
                                          () => OtpScreen(emailAddress: email))
                                      : null);
                            }
                          }
                        },
                        child: const Text('Send OTP'),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    ));
  }
}
