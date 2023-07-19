import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class EmptyPage extends StatelessWidget {
  final List<Color> gradient;
  final Widget? fab;
  final Widget? bottomNavBar;
  final Widget child;

  const EmptyPage({
    super.key,
    required this.gradient,
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
    required this.gradient,
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
              0.3,
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
    required this.gradient,
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
