import 'package:flutter/material.dart';
import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/pages/shopping_list_page.dart';

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

class Limelight extends StatefulWidget {
  const Limelight({super.key});

  @override
  State<Limelight> createState() => _LimelightState();
}

class _LimelightState extends State<Limelight> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
        controller: _pageController,
        scrollDirection: Axis.vertical,
        children: [
          PageView(
            controller: PageController(initialPage: 1),
            children: const [
              SettingsPage(),
              IngredientsPage(),
            ],
          ),
          RecipesPage(controller: _pageController),
          Consumer<PreferencesModel>(
            builder: (context, preferences, child) =>
                preferences.getFinalScreen,
          ),
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
