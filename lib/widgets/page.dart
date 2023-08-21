import 'dart:math';

import 'package:flutter/material.dart';

import 'package:limelight/widgets/gradient/circle.dart';
import 'package:limelight/gradients.dart';

class EmptyPage extends StatelessWidget {
  final List<Color> gradient;
  final PreferredSizeWidget? appBar;
  final Widget? fab;
  final Widget? child;

  const EmptyPage({
    super.key,
    this.gradient = limelightGradient,
    this.appBar,
    this.fab,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    var random = Random();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const numberOfCircles = 4;

    final sectionHeight = (height + 2 * width) / numberOfCircles;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toBackgroundGradient(gradient),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: appBar == null
            ? EdgeInsets.only(top: MediaQuery.of(context).padding.top)
            : const EdgeInsets.all(0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: appBar,
          floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 6, 10),
            child: fab,
          ),
          body: child,
        ),
      ),
    );
  }
}
