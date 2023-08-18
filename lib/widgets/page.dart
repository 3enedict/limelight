import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class EmptyPage extends StatelessWidget {
  final List<Color> gradient;
  final Widget? fab;
  final Widget? child;

  const EmptyPage({
    super.key,
    this.gradient = limelightGradient,
    this.fab,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toBackgroundGradient(gradient),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 6, 10),
          child: fab,
        ),
        body: child,
      ),
    );
  }
}
