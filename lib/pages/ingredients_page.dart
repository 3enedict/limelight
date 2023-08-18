import 'package:flutter/material.dart';

import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';

import 'package:limelight/widgets/gradient/textfield.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = PersistentKeyboardHeight.of(context).keyboardHeight;

    return EmptyPage(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, height + 20),
              child: const GradientTextField(hintText: "Search..."),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GradientIcon(
                gradient: toTextGradient(limelightGradient),
                icon: Icons.expand_less,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
