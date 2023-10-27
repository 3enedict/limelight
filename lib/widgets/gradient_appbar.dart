import 'package:flutter/material.dart';

import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/gradients.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CustomText? text;
  final List<Color> gradient;
  final Widget child;

  const GradientAppBar({
    super.key,
    this.text,
    this.gradient = limelightGradient,
    this.child = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    Widget localChild = child;

    if (text != null) {
      localChild = Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: text,
      );
    }

    return GradientContainer(
      gradient: toSurfaceGradient(gradient),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: localChild,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
