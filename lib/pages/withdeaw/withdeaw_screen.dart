import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/models/payments_method.dart';
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

  paymentSelectionPart() {
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
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
                    title: Text(
                      PaymentmentMathodModel.paymentList[index].tittle,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .merge(const TextStyle(fontSize: 17)),
                    ),
                    tileColor: Theme.of(context).cardColor,
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
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
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
                  height: 10,
                ),
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
                paymentSelectionPart()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
