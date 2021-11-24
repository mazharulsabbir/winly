import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/notification_controller.dart';
import 'package:winly/pages/notification/widget/notification_item.dart';
import 'package:winly/widgets/common_leading.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  final NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        leading: const CommonLeading(),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: notificationController.notifications.length,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemBuilder: (context, index) => NotificationItem(
            notice: notificationController.notifications[index],
          ),
        ),
      ),
    );
  }
}
