import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/pages/ingredients_page.dart';
import 'package:limelight/pages/settings_page.dart';
import 'package:limelight/pages/recipes_page.dart';
import 'package:limelight/gradients.dart';

void main() async {
  Paint.enableDithering = true;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IngredientModel()),
        ChangeNotifierProvider(create: (context) => PreferencesModel()),
      ],
      child: const Limelight(),
    ),
  );
}

class Limelight extends StatelessWidget {
  const Limelight({super.key});

  @override
  Widget build(BuildContext context) {
    loadModelDataFromLocalFiles(context);
    print("This shouldn't appear more than once");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Limelight',
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: textColor(),
          selectionColor: modifyColor(limelightGradient[1], 0.4, 0.5),
          selectionHandleColor: modifyColor(limelightGradient[1], 0.7, 0.7),
        ),
      ),
      home: PageView(
        controller: PageController(initialPage: 1),
        children: [
          const SettingsPage(),
          PageView(
            scrollDirection: Axis.vertical,
            children: const [
              IngredientsPage(),
              RecipesPage(),
            ],
          ),
        ],
      ),
    );
  }
}

void loadModelDataFromLocalFiles(BuildContext context) {
  Provider.of<IngredientModel>(context, listen: false).load();
  Provider.of<PreferencesModel>(context, listen: false).load();
}
