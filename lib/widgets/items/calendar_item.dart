import 'package:flutter/material.dart';

import 'package:limelight/widgets/data/recipe.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/data/recipes.dart';
import 'package:limelight/gradients.dart';

class CalendarItem extends StatefulWidget {
  final String currentRecipeName;
  final String recipeKey;

  const CalendarItem({
    super.key,
    required this.currentRecipeName,
    required this.recipeKey,
  });

  @override
  CalendarItemState createState() => CalendarItemState();
}

class CalendarItemState extends State<CalendarItem>
    with AutomaticKeepAliveClientMixin {
  RecipeData _storedRecipe = RecipeData.empty();
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    loadRecipe();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Item(
      title: _enabled ? widget.currentRecipeName : "",
      subTitle: _enabled ? _storedRecipe.difficulty : "",
      info: _enabled ? _storedRecipe.price : "",
      subInfo: _enabled ? "per person" : "",
      accentGradient: _enabled
          ? _storedRecipe.gradient
          : toBackgroundGradientWithReducedColorChange(limelightGradient),
      backgroundGradient: toSurfaceGradient(limelightGradient),
      onPressed: () => setState(() {
        if (_storedRecipe == RecipeData.empty()) {
          _storedRecipe =
              recipes[widget.currentRecipeName] ?? RecipeData.empty();
        }

        print(_storedRecipe.difficulty);
        if (_enabled) removeRecipe(widget.recipeKey);
        if (!_enabled) setRecipe(widget.recipeKey, widget.currentRecipeName);
        _enabled = !_enabled;
      }),
    );
  }

  void loadRecipe() {
    getRecipeData(widget.recipeKey).then(
      (recipe) => setState(() => _storedRecipe = recipe),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
