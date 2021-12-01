import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/helpers/snack.dart';
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
    hintText: "৳ 0",
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
      RequiredValidator(errorText: 'Account is required'),
      MinLengthValidator(11, errorText: 'Please enter a valid account number'),
      MaxLengthValidator(12, errorText: 'Please enter a valid account number')
    ]);

    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Account Number',
        hintText: '01XXXXXXXXX',
        prefixIcon: Icon(Icons.phone),
      ),
      keyboardType: const TextInputType.numberWithOptions(signed: false),
      validator: phoneValidator,
      controller: phoneNumberController,
    );
  }

  paymentSelectionPart() {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey.withOpacity(0.3),
        ),
        child: Column(
          children: [
            Text(
              'Select a methode to withdraw',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ).copyWith(top: 5),
              child: ListView.builder(
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
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
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
                              border: Border.all(color: Colors.blue, width: 3),
                            ),
                            height: 20,
                            width: 20,
                          ),
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
          debugPrint('Data is not null');
          final data = jsonDecode(response.body);

          if (response.statusCode == 200) {
            if (data['error'] != null) {
              snack(
                title: 'Error',
                desc: data['error'],
                icon: const Icon(Icons.error, color: Colors.red),
              );
            } else {
              snack(
                title: 'Success',
                desc: 'Hurrah we have received your request',
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
          }
        } else {
          debugPrint('Data is null');
          snack(
              title: 'No responce',
              desc: 'Server error',
              icon: const Icon(Icons.error));
        }
      } catch (e) {
        debugPrint('Error: $e');
      } finally {}
    } else {
      debugPrint('No tocken');
      snack(
        title: 'Tocken is not available',
        desc: 'You dont have valid tocken',
        icon: const Icon(Icons.thumb_up),
      );
    }
  }

  withDrawButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await sendWithDrawRequest();
        }
      },
      child: const Text('WithDraw'),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 40),
      ),
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
                          '৳ ${authController.user?.earnings?.totalBalance ?? 0}',
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
                  paymentSelectionPart(),
                  const SizedBox(height: 20),
                  _phoneNumber(),
                  const SizedBox(
                    height: 20,
                  ),
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
