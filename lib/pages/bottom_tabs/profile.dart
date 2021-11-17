import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/globals/controllers/theme_controller.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/pages/settings/settings.dart';
import 'package:winly/pages/wallet/wallet_screen.dart';
import 'package:winly/widgets/common_appbar.dart';
import 'package:winly/widgets/common_avatar.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  _heading(BuildContext context, User? user) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CommonAvatar(
            radius: 35,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _nameTitle(user?.name, context: context),
                    _username(user?.username, context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _bodyPart(User? user) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.settings)),
          title: const Text('Settings'),
          onTap: () {
            Get.to(() => const SettingsPage());
          },
        ),
        const Divider(),
        ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.wallet_giftcard),
          ),
          title: const Text('Wallet'),
          trailing: const Text('\$65.00'),
          onTap: () {
            Get.to(() => const WalletScreen());
          },
        ),
        const Divider(),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.group_add_outlined)),
          title: const Text('Refer'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const CircleAvatar(child: Icon(PhosphorIcons.ticket_bold)),
          title: const Text('Total tickets'),
          trailing: const Text('2034'),
          onTap: () {},
        ),
        const Divider(),
        GetBuilder<ThemeController>(builder: (controller) {
          return SwitchListTile(
            value: controller.isDarkMode.value,
            secondary: const CircleAvatar(child: Icon(PhosphorIcons.moon)),
            title: const Text('Dark mode'),
            onChanged: controller.setMode,
          );
        }),
      ],
    );
  }

  _nameTitle(String? nameTitle, {required BuildContext context}) {
    return Text(
      nameTitle == null ? 'No Name' : '$nameTitle!',
      style: Theme.of(context).textTheme.headline5,
    );
  }

  _username(String? username, BuildContext context) {
    return Text(
      username ?? 'username',
      style: Theme.of(context).textTheme.subtitle2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppbar(),
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                _heading(context, controller.user),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                _bodyPart(controller.user)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
