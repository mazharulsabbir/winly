import 'package:flutter/material.dart';
import 'package:winly/pages/notification/widget/notification_item.dart';
import 'package:winly/widgets/common_leading.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        leading: const CommonLeading(),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => const NotificationItem(),
      ),
    );
  }
}
