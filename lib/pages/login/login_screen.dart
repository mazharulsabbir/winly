import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:winly/globals/configs/colors.dart';
import 'package:winly/helpers/text_field_helpers.dart';
import 'package:winly/widgets/common_loading_overly.dart';
import 'package:winly/widgets/custom_button_sizer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  bool _loading = false;

  void _submit() async {
    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
    }
    // Get.offAll(() => HomeScreen());
  }

  Widget _signInText() {
    return Column(
      children: const [
        Text(
          "Welcome To the winly app!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
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
            ),
            validator: emailValidator,
            onSaved: (value) => email = value!,
          ),
          const SizedBox(
            height: 18,
          ),
          TextFormField(
            decoration: TextFieldHelpers.decoration(label: 'Password'),
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

  Widget _bottomPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonButtonSizer(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Paints.backGroundColor,
            ),
            onPressed: _submit,
            child: const Text("LOGIN"),
          ),
        ),
        TextButton(
          child: RichText(
            text: const TextSpan(
              text: "Don't have an account ? ",
              children: [
                TextSpan(
                  text: "Sign up now !",
                  style: TextStyle(
                    color: Paints.primayColor,
                  ),
                ),
              ],
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonLoadingOverlay(
      loading: _loading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // CommonLogo(),
                const SizedBox(
                  height: 20,
                ),
                _signInText(),
                const SizedBox(
                  height: 40,
                ),
                _formBox(),
                const SizedBox(
                  height: 60,
                ),
                _bottomPart()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
