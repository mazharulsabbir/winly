import 'package:flutter/material.dart';

class CommonIconTextWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  const CommonIconTextWidget({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 10),
        Icon(icon),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
