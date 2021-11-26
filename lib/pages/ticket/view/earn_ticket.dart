import 'package:flutter/material.dart';
import 'package:winly/pages/ticket/widget/quiz_screen.dart';
import 'package:winly/widgets/common_appbar.dart';
import 'package:winly/widgets/common_loading_overly.dart';

class EarnTicketTab extends StatelessWidget {
  const EarnTicketTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLoadingOverlay(
      loading: false,
      child: Scaffold(
        appBar: buildCommonAppbar(),
        body: const QuizeScreen(),
      ),
    );
  }
}
