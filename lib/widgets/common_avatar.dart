import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import 'package:winly/globals/configs/colors.dart';

class CommonAvatar extends StatelessWidget {
  final double radius;
  final String? avatarUrl;
  const CommonAvatar({
    Key? key,
    this.avatarUrl,
    this.radius = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (avatarUrl == null) {
      return CircleAvatar(
        radius: radius,
        child: Center(
          child: Icon(
            PhosphorIcons.user,
            color: Colors.white,
            size: radius * 0.9,
          ),
        ),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage(
        avatarUrl!,
      ),
    );
  }
}
