import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:winly/globals/configs/colors.dart';
import 'package:winly/globals/configs/constans.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/globals/controllers/theme_controller.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/pages/about/about.dart';
import 'package:winly/pages/privacy/privacy_policy.dart';
import 'package:winly/pages/profile/view/edit_profile.dart';
import 'package:winly/pages/support/support_chat.dart';
import 'package:winly/pages/terms_condition/terms.dart';
import 'package:winly/pages/wallet/wallet_screen.dart';
import 'package:winly/widgets/common_appbar.dart';
import 'package:winly/widgets/common_avatar.dart';
import 'package:flutter/foundation.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
  }

  _heading(BuildContext context, User? user) {
    return InkWell(
      onTap: () => Get.to(() => const EditProfileScreen()),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonAvatar(
              radius: 35,
              avatarUrl: authController.user?.profileImage,
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
      ),
    );
  }

  _bodyPart(User? user) {
    return Column(
      children: [
        ListTile(
          leading: defaultLeadingStyle(Icons.wallet_giftcard, Colors.green),
          title: const Text('Wallet'),
          trailing: Text('৳ ${user?.earnings?.totalBalance ?? 0}'),
          onTap: () {
            Get.to(() => const WalletScreen());
          },
        ),
        const Divider(),
        ListTile(
          leading: defaultLeadingStyle(PhosphorIcons.ticket, Colors.teal),
          title: const Text('Total Tickets'),
          trailing: Text('${user?.earnings?.totalTickets ?? 0}'),
          onTap: () {
            authController.updateUser(user!.earnings);
          },
        ),
        const Divider(),
        ListTile(
          leading: defaultLeadingStyle(Icons.group_add_outlined, Colors.blue),
          title: const Text('Refer Friends'),
          onTap: () {
            Clipboard.setData(ClipboardData(
              text: authController.user?.referralCode,
            ));
            snack(
              title: "Code copied to clipboard.",
              desc: "Share code with friends and get rewards.",
              icon: const Icon(PhosphorIcons.link, color: kPrimaryColor),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: defaultLeadingStyle(
            Icons.security,
            Colors.amber,
          ),
          title: const Text('Terms and Conditions'),
          onTap: () => Get.to(() => const TermsAndCondition()),
        ),
        const Divider(),
        ListTile(
          leading: defaultLeadingStyle(
            Icons.privacy_tip,
            Colors.greenAccent,
          ),
          title: const Text('Privacy Policy'),
          onTap: () => Get.to(() => const PrivacyPolicy()),
        ),
        const Divider(),
        ListTile(
          leading: defaultLeadingStyle(
            PhosphorIcons.database,
            Colors.grey,
          ),
          title: const Text('About $appName'),
          onTap: () => Get.to(() => const AboutApp()),
        ),
        const Divider(),
        ListTile(
          leading: defaultLeadingStyle(
            PhosphorIcons.chat,
            kPrimaryColor,
          ),
          title: const Text('Need Support? Chat'),
          onTap: () => Get.to(() => const SupportChatWebView()),
        ),
        const Divider(),
        GetBuilder<ThemeController>(builder: (controller) {
          return SwitchListTile(
            value: controller.isDarkMode.value,
            secondary: defaultLeadingStyle(
                controller.isDarkMode.value
                    ? PhosphorIcons.moon
                    : PhosphorIcons.sun,
                Colors.blueAccent),
            title: const Text('Dark Mode'),
            onChanged: controller.setMode,
          );
        }),
        const Divider(),
        ListTile(
          leading: defaultLeadingStyle(PhosphorIcons.sign_out, Colors.red),
          title: const Text('Sign Out'),
          onTap: () {
            final AuthController authController = Get.find<AuthController>();
            authController.logOut();
          },
        ),
      ],
    );
  }

  defaultLeadingStyle(IconData icon, Color backColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  _nameTitle(String? nameTitle, {required BuildContext context}) {
    return Text(
      nameTitle ?? 'No Name',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Obx(() {
                return _heading(context, authController.mUserObx.value);
              }),
              const SizedBox(
                height: 20,
              ),
              Obx(() => _bodyPart(authController.mUserObx.value)),
            ],
          ),
        ),
      ),
    );
  }
}
