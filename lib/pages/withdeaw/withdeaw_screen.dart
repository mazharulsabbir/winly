import 'package:flutter/material.dart';

class WithDrawScreen extends StatelessWidget {
  const WithDrawScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: const SafeArea(
          child: Center(
        child: Text('Wallet screen'),
      )),
    );
  }
}
