import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

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

    if (!avatarUrl!.startsWith('http')) {
      return CircleAvatar(
        radius: radius,
        child: Center(
          child: Text(
            '$avatarUrl',
            style: TextStyle(color: Colors.blue, fontSize: radius * 0.9),
          ),
        ),
      );
    }

    return Container(
      height: radius,
      width: radius,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Image.network(
        avatarUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Icon(
                PhosphorIcons.user,
                color: Colors.blue,
                size: radius * 0.9,
              ),
            ),
          );
        },
      ),
    );
  }
}
