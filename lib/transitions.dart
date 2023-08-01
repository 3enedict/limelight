import 'package:flutter/material.dart';

Future<void> fadeTransition(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    PageRouteBuilder<void>(
      pageBuilder: (BuildContext context, _, __) {
        return page;
      },
      transitionsBuilder: (
        ___,
        Animation<double> animation,
        ____,
        Widget child,
      ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );
}
