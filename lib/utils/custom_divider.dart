import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class CustomDivider extends StatelessWidget {
  final Color? color;
  final double opacity;
  final double height;
  final double? indent;
  final double? beginIndent;
  final double? endIndent;

  const CustomDivider({
    super.key,
    this.color,
    this.opacity = 0.2,
    this.height = 0.0,
    this.indent,
    this.beginIndent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    final localColor = color ?? textColor();

    return Divider(
      color: localColor.withOpacity(opacity),
      height: height,
      indent: indent ?? beginIndent,
      endIndent: indent ?? endIndent,
    );
  }
}
