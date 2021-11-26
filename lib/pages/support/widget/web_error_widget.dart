import 'package:flutter/material.dart';

class WebErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final Function()? onButtonPressed;

  const WebErrorWidget({Key? key, this.errorMessage, this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$errorMessage",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onButtonPressed,
                child: const Text('Reload'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
