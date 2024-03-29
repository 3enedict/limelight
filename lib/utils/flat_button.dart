import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class FlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double? borderRadius;
  final Widget child;

  const FlatButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: TextButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(0),
        foregroundColor: textColor().withOpacity(0.2),
        shape: borderRadius == null
            ? null
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              ),
      ),
      child: child,
    );
  }
}
