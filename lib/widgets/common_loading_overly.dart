import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:winly/globals/configs/colors.dart';

class CommonLoadingOverlay extends StatelessWidget {
  final bool loading;
  final Widget child;
  const CommonLoadingOverlay(
      {Key? key, required this.child, required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      color: Colors.black.withOpacity(0.6),
      child: child,
      progressIndicator: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Paints.primayColor),
      ),
    );
  }
}
