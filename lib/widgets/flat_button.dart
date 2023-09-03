import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class FlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const FlatButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(0),
        foregroundColor: textColor().withOpacity(0.25),
      ),
      child: child,
    );
  }
}
