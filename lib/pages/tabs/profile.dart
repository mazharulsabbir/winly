import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:winly/globals/controllers/theme_controller.dart';
import 'package:winly/widgets/common_avatar.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  _heading(BuildContext context) {
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
                    _nameTitle(null, context: context),
                    _username(null, context),
                  ],
                ),
                _pointShowingSection(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _bodyPart() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.wallet_giftcard),
          title: const Text('Wallet'),
          trailing: const Text('\$65.00'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(PhosphorIcons.qr_code),
          title: const Text('Refer'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(PhosphorIcons.ticket_bold),
          title: const Text('Total tickets'),
          onTap: () {},
        ),
        GetBuilder<ThemeController>(builder: (controller) {
          return SwitchListTile(
            value: controller.isDarkMode.value,
            secondary: const Icon(PhosphorIcons.moon),
            title: const Text('Dark mode'),
            onChanged: controller.setMode,
          );
        }),
      ],
    );
  }

  _nameTitle(String? nameTitle, {required BuildContext context}) {
    return Text(
      nameTitle == null ? 'Unknown' : '$nameTitle!',
      style: Theme.of(context).textTheme.headline5,
    );
  }

  _username(String? username, BuildContext context) {
    return Text(
      username ?? 'unknown',
      style: Theme.of(context).textTheme.subtitle2,
    );
  }

  _pointShowingSection(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          '2034',
          style: Theme.of(context).textTheme.subtitle1,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              _heading(context),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              _bodyPart()
            ],
          ),
        ),
      ),
    );
  }
}
