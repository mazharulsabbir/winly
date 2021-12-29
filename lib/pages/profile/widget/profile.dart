import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winly/globals/configs/colors.dart';
import 'package:winly/globals/configs/constans.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/globals/controllers/theme_controller.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/models/auth/user_model.dart';
import 'package:winly/pages/about/about.dart';
import 'package:winly/pages/privacy/privacy_policy.dart';
import 'package:winly/pages/profile/view/edit_profile.dart';
import 'package:winly/pages/profile/widget/add_refer_code_dialog.dart';
import 'package:winly/pages/support/support_chat.dart';
import 'package:winly/pages/terms_condition/terms.dart';
import 'package:winly/pages/wallet/wallet_screen.dart';
import 'package:winly/services/api/auth.dart';
import 'package:winly/services/api/url.dart';
import 'package:winly/services/db/auth.dart';
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
    return ListTile(
      onTap: () => Get.to(() => const EditProfileScreen()),
      leading: CommonAvatar(
        radius: 35,
        avatarUrl: authController.user?.profileImage,
      ),
      title: Text(
        authController.user?.name ?? '',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(user?.username ?? ''),
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
            authController.updateUserEarnings(user!.earnings);
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
          leading: defaultLeadingStyle(Icons.code, Colors.cyanAccent),
          title: const Text('Add Refer Code'),
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              builder: (_) => AddReferCodeWidget(
                token: authController.token,
              ),
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
          onTap: () async {
            if (!await launch(supportChatBaseUrl)) {
              Get.to(() => const SupportChatWebView());
            }
          },
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
        const SizedBox(height: 100)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppbar(),
      body: RefreshIndicator(
        onRefresh: () async {
          final AuthController authController = Get.find<AuthController>();
          return authController.getUserProfile("${authController.token}");
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30),
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
    );
  }
}
