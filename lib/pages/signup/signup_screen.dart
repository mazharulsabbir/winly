import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/helpers/text_field_helpers.dart';
import 'package:winly/models/auth/auth_form_model.dart';
import 'package:winly/services/api/auth.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  CountdownTimerController? controller;
  AuthFormModel _formModel = AuthFormModel();

  int _step = 0;
  bool _isEmailVerificationTimeout = false;

  bool _onEditing = true;
  String? _code;
  bool _loading = false;

  void onEnd() {
    print("TIMEOUT");
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: '');
    userNameController = TextEditingController(text: '');
    emailController = TextEditingController(text: 'example@gmail.com');
    phoneNumberController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');

    controller = CountdownTimerController(
        endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60,
        onEnd: onEnd);
  }

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Widget _nameForm() {
    final nameValidator = RequiredValidator(errorText: 'name is required');

    return TextFormField(
      decoration: TextFieldHelpers.decoration(
        label: 'Name',
        hint: "John",
      ),
      validator: nameValidator,
      controller: nameController,
    );
  }

  Widget _userNameForm() {
    final usernameValidator = MultiValidator([
      RequiredValidator(errorText: 'username is required'),
    ]);

    return TextFormField(
      decoration: TextFieldHelpers.decoration(
        label: 'Username',
        hint: "abdur_rahman",
      ),
      validator: usernameValidator,
      controller: userNameController,
    );
  }

  Widget _emailForm() {
    final emailValidator = MultiValidator([
      RequiredValidator(errorText: 'name is required'),
      EmailValidator(errorText: 'enter a valid email'),
    ]);

    return TextFormField(
      decoration: TextFieldHelpers.decoration(
        label: 'Email',
        hint: "someone@example.domain",
      ),
      validator: emailValidator,
      controller: emailController,
    );
  }

  Widget _phoneNumber() {
    final phoneValidator = MultiValidator([
      RequiredValidator(errorText: 'phone is required'),
      MinLengthValidator(11, errorText: 'Please enter a valid mobile number'),
      MaxLengthValidator(11, errorText: 'Please enter a valid mobile number')
    ]);

    return TextFormField(
      decoration: TextFieldHelpers.decoration(
        label: 'Phone number',
        hint: "01234567891",
      ),
      keyboardType: TextInputType.number,
      validator: phoneValidator,
      controller: phoneNumberController,
    );
  }

  Widget _passwordForm() {
    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'password is required'),
      MinLengthValidator(8,
          errorText: 'password must be at least 8 digits long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'passwords must have at least one special character')
    ]);

    return TextFormField(
      decoration: TextFieldHelpers.decoration(label: 'Password'),
      obscureText: true,
      validator: passwordValidator,
      controller: passwordController,
    );
  }

  Widget _confirmPasswordForm() {
    final confirmPassValidarior = MultiValidator([
      RequiredValidator(errorText: 'Confirm password is required'),
    ]);
    return TextFormField(
      decoration: TextFieldHelpers.decoration(label: 'Confirm Password'),
      obscureText: true,
      validator: (value) {},
    );
  }

  Widget _formBox() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _nameForm(),
          const SizedBox(
            height: 18,
          ),
          _userNameForm(),
          const SizedBox(
            height: 18,
          ),
          _emailForm(),
          const SizedBox(
            height: 18,
          ),
          _phoneNumber(),
          const SizedBox(
            height: 18,
          ),
          _passwordForm(),
          const SizedBox(
            height: 18,
          ),
          _confirmPasswordForm(),
        ],
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        isActive: _step == 0,
        title: const Text("Account"),
        content: _formBox(),
      ),
      Step(
        isActive: _step == 1,
        title: const Text("Preview"),
        content: _preview(),
      ),
      Step(
        isActive: _step == 2,
        title: const Text("Verify"),
        content: _verify(),
      ),
    ];
  }

  Widget _preview() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text(
              "Name",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            subtitle: Text(
              _formModel.name ?? '',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.email, color: Colors.red),
            title: const Text(
              "Email",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            subtitle: Text(
              '${_formModel.email}',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.call, color: Colors.green),
            title: const Text(
              "Phone number",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            subtitle: Text(
              '${_formModel.phoneNumber}',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
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
                      _loading = true;
                    });

                    try {
                      final response = await AuthAPI.resendVerificationEmail(
                        email: _formModel.email!,
                      );

                      if (response != null) {
                        dynamic responseBody = jsonDecode(response.body);
                        if (responseBody['error'] != null) {
                          snack(
                            title: 'Failed',
                            desc: responseBody['error'],
                            icon: Icon(Icons.error, color: Colors.red),
                          );
                        } else if (responseBody['message'] != null) {
                          manageCountdownTimer();
                          snack(
                            title: 'Success',
                            desc: responseBody['message'],
                            icon: const Icon(Icons.done, color: Colors.green),
                          );
                        }
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                    } finally {
                      setState(() {
                        _loading = false;
                      });
                    }
                  },
                  child: const Text("Resend again")),
            ],
          )
        else
          CountdownTimer(
            controller: controller,
            onEnd: onEnd,
            widgetBuilder: (_, CurrentRemainingTime? time) {
              if (time == null) {
                return SizedBox();
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
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
    });

    final response = await AuthAPI.register(_formModel);

    try {
      if (response != null) {
        final data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          if (data['errors'] != null) {
            //On error
            String errorMessageBuilder = "";
            Map<String, dynamic> errors = data['errors'];
            errors.forEach((index, value) {
              errorMessageBuilder += '$value\n';
            });

            snack(
              title: data['message'],
              desc: errorMessageBuilder,
              icon: const Icon(Icons.error, color: Colors.red),
            );
          } else {
            snack(
              title: 'Resitration Succress',
              desc: data['message'],
              icon: const Icon(Icons.thumb_up),
            );
          }
        } else if (response.statusCode == 422) {
          final data = jsonDecode(response.body);
          String errorMessageBuilder = "";

          Map<String, dynamic> errors = data['errors'];

          errors.forEach((index, value) {
            errorMessageBuilder += '$value\n';
          });

          snack(
            title: data['message'],
            desc: errorMessageBuilder,
            icon: const Icon(Icons.error, color: Colors.red),
          );
        } else if (response.statusCode == 201) {
          debugPrint('Rewsponce code 201');
          setState(() {
            _step++;
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _loading = false;
        _step++;
      });
    }
  }

  // void _verifyCode() async {
  //   setState(() {
  //     _loading = true;
  //   });

  //   if (_code != null) {
  //     final response = await AuthAPI.verify(
  //       email: _formModel.email!,
  //       code: _code!,
  //     );

  //     try {
  //       if (response != null) {
  //         final data = jsonDecode(response.body);
  //         if (response.statusCode == 200) {
  //           if (data['error'] != null) {
  //             snack(
  //               title: "Error",
  //               desc: data['error'],
  //               icon: Icon(Icons.error, color: Colors.red),
  //             );
  //           } else {
  //             Get.off(() => SignInScreen());
  //             snack(
  //               title: "Success",
  //               desc: data['message'],
  //               icon: Icon(Icons.done, color: Colors.green),
  //             );
  //           }
  //         }
  //       }
  //     } catch (_) {
  //     } finally {
  //       setState(() {
  //         _loading = false;
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       _loading = true;
  //     });
  //     snack(
  //         title: "Error",
  //         desc: "Code is not valid",
  //         icon: Icon(Icons.error, color: Colors.red));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SIGN UP"),
          leading: const CommonLeading(),
        ),
        body: CommonLoadingOverlay(
          loading: _loading,
          child: Stepper(
            steps: getSteps(),
            type: StepperType.horizontal,
            currentStep: _step,
            onStepContinue: () async {
              final isLastStep = _step == getSteps().length - 1;
              controller?.disposeTimer();

              if (_step == 0) {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  _formModel = AuthFormModel(
                    name: nameController.text,
                    username: userNameController.text,
                    email: emailController.text,
                    phoneNumber: phoneNumberController.text,
                    password: passwordController.text,
                  );
                  setState(() => _step++);
                  print(_formModel.phoneNumber);
                }
              } else if (_step == 1) {
                print('Step forward');

                await _submit().then((value) {
                  print('Submit called');
                });
                manageCountdownTimer();
              } else if (isLastStep) {
                controller?.disposeTimer();
                // _verifyCode();
              }
            },
            onStepCancel: _step == 0 ? null : () => setState(() => _step--),
          ),
        ));
  }

  void manageCountdownTimer() {
    if (mounted) {
      controller?.disposeTimer();
    }

    setState(() {
      _isEmailVerificationTimeout = false;
    });

    controller = CountdownTimerController(
        endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60,
        onEnd: onEnd);

    controller?.addListener(() {
      if (controller?.currentRemainingTime?.sec == 1) {
        controller?.disposeTimer();
        setState(() {
          _isEmailVerificationTimeout = true;
        });
      }
    });

    controller?.start();
  }
}
