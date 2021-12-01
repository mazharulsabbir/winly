import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/services/api/auth.dart';
import 'package:winly/services/db/auth.dart';

class AddReferCodeWidget extends StatefulWidget {
  final String? token;
  const AddReferCodeWidget({Key? key, this.token}) : super(key: key);

  @override
  State<AddReferCodeWidget> createState() => _AddReferCodeWidgetState();
}

class _AddReferCodeWidgetState extends State<AddReferCodeWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  final refCodeValidator = MultiValidator([
    RequiredValidator(errorText: 'Code is required'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Referral Code',
                hintText: 'Enter your referral code',
              ),
              validator: refCodeValidator,
            ),
            const SizedBox(height: 24),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        AuthDBService.removeParentReferCode();
                        await AuthAPI.setReferCode(
                          referCode: nameController.text,
                          token: "${widget.token}",
                        ).onError((error, stackTrace) {
                          snack(
                            title: 'Error',
                            desc: '$error',
                            icon: const Icon(Icons.error),
                          );
                        }).then((value) {
                          snack(
                            title: 'Error',
                            desc: '$value',
                            icon: const Icon(Icons.done),
                          );
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
