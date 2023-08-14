import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class EmptyPage extends StatelessWidget {
  final List<Color> gradient;
  final Widget? fab;
  final Widget? bottomNavBar;
  final Widget child;

  const EmptyPage({
    super.key,
    this.gradient = limelightGradient,
    this.fab,
    this.bottomNavBar,
    this.child = const SizedBox(),
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
        floatingActionButton: fab,
        bottomNavigationBar: bottomNavBar,
        body: child,
      ),
    );
  }
}

class Fade extends StatelessWidget {
  final List<Color> gradient;
  final Widget child;

  const Fade({
    super.key,
    this.gradient = limelightGradient,
    this.child = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    final Color color = toBackgroundGradient(gradient)[1];

    return ShaderMask(
      shaderCallback: (bound) {
        return LinearGradient(
            end: FractionalOffset.topCenter,
            begin: FractionalOffset.bottomCenter,
            colors: [
              color,
              color.withAlpha(0),
            ],
            stops: const [
              0.0,
              0.2,
            ]).createShader(bound);
      },
      blendMode: BlendMode.srcOver,
      child: child,
    );
  }
}

class EmptyPageWithBottomBar extends StatelessWidget {
  final List<Color> gradient;
  final Widget body;
  final Widget bottomBar;

  const EmptyPageWithBottomBar({
    super.key,
    this.gradient = limelightGradient,
    this.body = const SizedBox(),
    this.bottomBar = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: toBackgroundGradient(gradient),
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: body,
            ),
          ),
          Container(
            color: toBackgroundGradient(gradient)[1],
            child: bottomBar,
          )
        ],
      ),
    );
  }
}
