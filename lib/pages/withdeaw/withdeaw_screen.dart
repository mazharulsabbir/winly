import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/widgets/common_leading.dart';

class WithDrawScreen extends StatefulWidget {
  const WithDrawScreen({Key? key}) : super(key: key);

  @override
  State<WithDrawScreen> createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen> {
  late TextEditingController amountController;
  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(text: '\$65000');
  }

  InputDecoration inputdecoration = const InputDecoration(
      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonLeading(),
        title: Text(
          'Withdraw',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter Amount',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: TextField(
                    controller: amountController,
                    decoration: inputdecoration,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(PhosphorIcons.wallet),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Balance: '),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
