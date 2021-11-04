import 'package:flutter/material.dart';

class CommonButtonSizer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;

  const CommonButtonSizer(
      {Key? key, this.width, this.height, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? 42),
      child: child,
    );
  }
}
