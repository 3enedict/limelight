import 'package:flutter/material.dart';

import 'package:limelight/widgets/data/recipe.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/gradients.dart';

class CalendarItem extends StatefulWidget {
  final RecipeData currentRecipe;
  final String recipeKey;

  const CalendarItem({
    super.key,
    required this.currentRecipe,
    required this.recipeKey,
  });

  @override
  CalendarItemState createState() => CalendarItemState();
}

class CalendarItemState extends State<CalendarItem>
    with AutomaticKeepAliveClientMixin {
  RecipeData _storedRecipe = RecipeData.empty();
  bool _enabled = true;

  @override
  void initState() {
    super.initState();
    loadRecipe();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Item(
      title: _enabled ? _storedRecipe.name : "",
      subTitle: _enabled ? _storedRecipe.time : "",
      info: _enabled ? _storedRecipe.price : "",
      subInfo: _enabled ? _storedRecipe.unit : "",
      accentGradient: _enabled
          ? _storedRecipe.gradient
          : toBackgroundGradient(limelightGradient),
      backgroundGradient: toSurfaceGradient(limelightGradient),
      onPressed: () => setState(() {
        if (_storedRecipe.name == widget.currentRecipe.name) {
          if (_enabled) removeRecipe(widget.recipeKey);
          if (!_enabled) setRecipe(widget.recipeKey, _storedRecipe);
          _enabled = !_enabled;
        } else {
          _storedRecipe = widget.currentRecipe;
          setRecipe(widget.recipeKey, _storedRecipe);
        }
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
