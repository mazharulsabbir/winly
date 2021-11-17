import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:winly/widgets/common_appbar.dart';
import 'package:winly/widgets/common_loading_overly.dart';
import 'package:winly/widgets/empty_list.dart';

class EarnTicketTab extends StatelessWidget {
  const EarnTicketTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLoadingOverlay(
      loading: false,
      child: Scaffold(
        appBar: buildCommonAppbar(),
        body: const Center(
          child: Text('Earn tickets'),
          // child: TextButton(
          //     onPressed: () async {
          //       var userSub = await OneSignal.shared.getDeviceState();
          //       var pleyerId = userSub?.userId;
          //       if (pleyerId != null) {
          //         await OneSignal.shared.postNotification(OSCreateNotification(
          //             playerIds: [pleyerId],
          //             content: 'This is to test the notification',
          //             heading: 'Let me test',
          //             buttons: [OSActionButton(id: 'clear', text: 'Clear')]));
          //       }
          //     },
          //     child: const Text('Send a notification')),
        ),
      ),
    );
  }
}
