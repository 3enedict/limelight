import 'package:flutter/material.dart';

import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:limelight/gradients.dart';

import 'package:limelight/pages/ingredients_page.dart';
import 'package:limelight/pages/recipes_page.dart';

void main() async {
  Paint.enableDithering = true;
  runApp(const Limelight());
}

class Limelight extends StatelessWidget {
  const Limelight({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Limelight',
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: toTextGradient(limelightGradient)[1],
          selectionColor: modifyColor(limelightGradient[1], 0.4, 0.5),
          selectionHandleColor: modifyColor(limelightGradient[1], 0.7, 0.7),
        ),
      ),
      builder: (context, child) => PersistentKeyboardHeightProvider(
        child: child!,
      ),
      home: PageView(
        scrollDirection: Axis.vertical,
        children: const [
          IngredientsPage(),
          RecipesPage(),
        ],
      ),
    );
  }
}
