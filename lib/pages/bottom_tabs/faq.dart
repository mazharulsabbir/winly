import 'package:flutter/material.dart';
import 'package:winly/pages/fqa/widget/fqa_item.dart';
import 'package:winly/widgets/common_appbar.dart';

class FQATab extends StatelessWidget {
  const FQATab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppbar(),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) => const FqaItemWidget(),
      ),
    );
  }
}
