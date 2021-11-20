import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:winly/globals/configs/colors.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/helpers/text_field_helpers.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/pages/nav_bar/bottom_nav_bar.dart';
import 'package:winly/pages/signup/signup_screen.dart';
import 'package:winly/services/api/auth.dart';
import 'package:winly/widgets/common_loading_overly.dart';
import 'package:winly/widgets/custom_button_sizer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  String email = "";
  String password = "";

  bool _loading = false;

  void _submit() async {
    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      try {
        final response = await AuthAPI.login(email: email, password: password);
        if (response != null) {
          final data = jsonDecode(response.body);

          if (response.statusCode == 200) {
            final token = data['token'];
            final userDataRaw = await AuthAPI.me(token);

            if (userDataRaw != null) {
              try {
                final userParsed = jsonDecode(userDataRaw.body);
                final User user = User.fromJson(userParsed);
                snack(
                  title: "Success",
                  desc: data['message'],
                  icon: const Icon(Icons.done, color: Colors.green),
                );
                _authController.logIn(user, token);
                Get.offAll(() => const BottomNavBar());
              } catch (e) {
                snack(
                  title: "Error",
                  desc: "Something went wrong",
                  icon: const Icon(Icons.error, color: Colors.red),
                );
              }
            }
          } else if (response.statusCode == 401) {
            snack(
              title: "Error",
              desc: data['error'],
              icon: const Icon(Icons.error, color: Colors.red),
            );
          } else {
            snack(
                title: 'Error',
                desc: data['errors'],
                icon: const Icon(Icons.error));
          }
        }
      } catch (_) {
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
    // Get.offAll(() => HomeScreen());
  }

  Widget _signInText() {
    return Column(
      children: [
        Text(
          "Welcome To the winly app!",
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 6,
        ),
        const Text(
          "Play & Earn ",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  Widget _formBox() {
    final emailValidator = MultiValidator([
      RequiredValidator(errorText: 'email is required'),
      EmailValidator(errorText: 'enter a valid email address')
    ]);

    final passwordValidator =
        RequiredValidator(errorText: 'password is required');

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            decoration: TextFieldHelpers.decoration(
              label: 'Email',
              hint: "yourname@example.com",
            ).copyWith(labelStyle: Theme.of(context).textTheme.subtitle1),
            validator: emailValidator,
            onSaved: (value) => email = value!,
          ),
          const SizedBox(
            height: 18,
          ),
          TextFormField(
            decoration: TextFieldHelpers.decoration(label: 'Password')
                .copyWith(labelStyle: Theme.of(context).textTheme.subtitle1),
            obscureText: true,
            validator: passwordValidator,
            onSaved: (value) => password = value!,
          ),
          TextButton(
            onPressed: () {
              // Get.to(() => ForgotPasswordScreen());
            },
            child: const Text(
              "Forgot Password ? ",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            if (await _authController.signInWithFacebook()) {
              Get.off(() => const BottomNavBar());
            }
          },
          icon: const Icon(PhosphorIcons.facebook_logo),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          onPressed: () async {
            if (await _authController.signInWithGoogle()) {
              Get.off(() => const BottomNavBar());
            } else {
              snack(
                  title: 'Google sign in unsuccessful',
                  desc: 'Authentication problem',
                  icon: const Icon(Icons.error));
            }
          },
          icon: const Icon(PhosphorIcons.google_logo),
        )
      ],
    );
  }

  Widget _bottomPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonButtonSizer(
          child: ElevatedButton(
            onPressed: _submit,
            child: const Text("LOGIN"),
          ),
        ),
        SizedBox(
          child: RichText(
            text: TextSpan(
              text: "Don't have an account ? ",
              style: Theme.of(context).textTheme.subtitle1,
              children: [
                TextSpan(
                    text: "Sign up now !",
                    style: const TextStyle(
                      color: Paints.primayColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(() => const SignUpScreen());
                      }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonLoadingOverlay(
      loading: _loading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // CommonLogo(),
                  const SizedBox(
                    height: 60,
                  ),
                  _signInText(),
                  const SizedBox(
                    height: 50,
                  ),
                  _formBox(),
                  const SizedBox(
                    height: 60,
                  ),

                  _bottomPart(),
                  const SizedBox(
                    height: 10,
                  ),
                  _socialButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
