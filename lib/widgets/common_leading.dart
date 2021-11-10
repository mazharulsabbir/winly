import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

class CommonLeading extends StatelessWidget {
  const CommonLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        PhosphorIcons.caret_left,
        color: Theme.of(context).appBarTheme.iconTheme?.color ?? Colors.white,
      ),
      onPressed: () => Get.back(),
    );
  }
}
