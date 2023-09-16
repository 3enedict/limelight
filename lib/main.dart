import 'package:flutter/material.dart';
import 'package:limelight/data/provider/variation_model.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/pages/ingredients_page.dart';
import 'package:limelight/pages/settings_page.dart';
import 'package:limelight/pages/recipes_page.dart';
import 'package:limelight/gradients.dart';

void main() async {
  Paint.enableDithering = true;
  runApp(
    MultiProvider(
      providers: [
        // Don't forget to call load() if need be in loadModelDataFromLocalFiles() at the bottom of this file
        ChangeNotifierProvider(create: (context) => IngredientModel()),
        ChangeNotifierProvider(create: (context) => RecipeModel()),
        ChangeNotifierProvider(create: (context) => CalendarModel()),
        ChangeNotifierProvider(create: (context) => PreferencesModel()),
        ChangeNotifierProvider(create: (context) => VariationModel()),
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
        scrollDirection: Axis.vertical,
        children: [
          PageView(
            controller: PageController(initialPage: 1),
            children: const [
              SettingsPage(),
              IngredientsPage(),
            ],
          ),
          const RecipesPage(),
        ],
      ),
    );
  }
}

void loadModelDataFromLocalFiles(BuildContext context) {
  Provider.of<IngredientModel>(context, listen: false).load();
  Provider.of<RecipeModel>(context, listen: false).load();
  Provider.of<CalendarModel>(context, listen: false).load();
  Provider.of<PreferencesModel>(context, listen: false).load();
  Provider.of<VariationModel>(context, listen: false).load();
}

void goto(BuildContext context, Widget widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
}
