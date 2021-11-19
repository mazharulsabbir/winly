import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/helpers/text_field_helpers.dart';
import 'package:winly/models/payments_method.dart';
import 'package:winly/services/api/withdraw.dart';
import 'package:winly/widgets/common_leading.dart';

class WithDrawScreen extends StatefulWidget {
  const WithDrawScreen({Key? key}) : super(key: key);

  @override
  State<WithDrawScreen> createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen> {
  late TextEditingController amountController;
  late TextEditingController phoneNumberController;
  AuthController authController = AuthController();

  final _formKey = GlobalKey<FormState>();

  int selectedIndex = 0;
  bool islOading = false;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  final InputDecoration _inputDecoration = const InputDecoration(
    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
    hintText: "\$0",
  );

  amountField() {
    final phoneValidator = MultiValidator([
      RequiredValidator(errorText: 'Enter amount'),
    ]);
    return SizedBox(
      width: 160,
      child: TextFormField(
        validator: phoneValidator,
        controller: amountController,
        decoration: _inputDecoration,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4!,
      ),
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

  paymentSelectionPart() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.3),
        ),
        child: Column(
          children: [
            Text(
              'Select a methode to withdraw',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() => selectedIndex = index);
                    },
                    title: Text(
                      PaymentmentMathodModel.paymentList[index].tittle,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .merge(const TextStyle(fontSize: 17)),
                    ),
                    tileColor: Theme.of(context).cardColor,
                    trailing: selectedIndex == index
                        ? Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            height: 20,
                            width: 20,
                            child: const Icon(
                              Icons.done,
                              size: 13,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.blue, width: 3)),
                            height: 20,
                            width: 20,
                          ),
                  );
                },
                separatorBuilder: (_, i) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: PaymentmentMathodModel.paymentList.length,
                shrinkWrap: true,
              ),
            )
          ],
        ));
  }

  Future<void> sendWithDrawRequest() async {
    setState(() {
      islOading = true;
    });

    if (authController.token != null) {
      final response = await WithdrawAPI.withdraw(
          authController.token!,
          phoneNumberController.text,
          int.parse(amountController.text),
          PaymentmentMathodModel.paymentList[selectedIndex].tittle);

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
              // snack(
              //   title: 'Resitration Succress',
              //   desc: data['message'],
              //   icon: const Icon(Icons.thumb_up),
              // );
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
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {}
    } else {
      snack(
        title: 'Tocken is not available',
        desc: 'You dont have valid tocken',
        icon: const Icon(Icons.thumb_up),
      );
    }
  }

  withDrawButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState != null) {
          if (_formKey.currentState!.validate()) {
            print(
                'amount${amountController.text} phone number ${phoneNumberController.text} and selected Methode ${PaymentmentMathodModel.paymentList[selectedIndex].tittle}');
            sendWithDrawRequest();
          }
        }
      },
      child: const Text('WithDraw'),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 40)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonLeading(),
        title: const Text('Withdraw'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter Amount',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  amountField(),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(PhosphorIcons.wallet),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Balance: '),
                        Text(
                          '\$ 65,000',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  _phoneNumber(),
                  const SizedBox(
                    height: 20,
                  ),
                  paymentSelectionPart(),
                  const SizedBox(height: 20),
                  withDrawButton()
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(),
    );
  }
}
