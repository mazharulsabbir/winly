import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:winly/globals/configs/constans.dart';
import 'package:winly/pages/notification/view/notification_screen.dart';
import 'package:winly/pages/wallet/wallet_screen.dart';

PreferredSizeWidget buildCommonAppbar(
        {double? elevation, PreferredSizeWidget? bottom}) =>
    AppBar(
        elevation: elevation ?? 0,
        title: const Text(APP_NAME),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => Get.to(() => const WalletScreen()),
            icon: const Icon(PhosphorIcons.wallet),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const NotificationScreen()),
            icon: const Icon(PhosphorIcons.bell),
          )
        ],
        bottom: bottom);
