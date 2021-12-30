import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/models/notice/notice.dart';

class NotificationItem extends StatelessWidget {
  final Notice? notice;
  const NotificationItem({Key? key, this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.grey.withOpacity(0.3),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        title: Text("${notice?.title}"),
        isThreeLine: true,
        leading: CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.3),
          child: const Icon(PhosphorIcons.bell),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "${notice?.details}\n\n${notice?.createdAt}",
            maxLines: 3,
            overflow: TextOverflow.fade,
          ),
        ),
      ),
    );
  }
}
