import 'package:flutter/material.dart';

import 'package:limelight/widgets/data/recipe.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/data/recipes.dart';
import 'package:limelight/gradients.dart';

class CalendarItem extends StatefulWidget {
  final int recipeId;
  final String recipeKey;

  const CalendarItem({
    super.key,
    required this.recipeId,
    required this.recipeKey,
  });

  @override
  CalendarItemState createState() => CalendarItemState();
}

class CalendarItemState extends State<CalendarItem>
    with AutomaticKeepAliveClientMixin {
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
      title: _enabled ? "" : recipes[widget.recipeId].name,
      subTitle: _enabled ? "" : recipes[widget.recipeId].difficulty,
      info: _enabled ? "" : recipes[widget.recipeId].price,
      subInfo: _enabled ? "" : "per person",
      accentGradient: _enabled
          ? toBackgroundGradientWithReducedColorChange(limelightGradient)
          : recipes[widget.recipeId].gradient,
      backgroundGradient: toSurfaceGradient(limelightGradient),
      onPressed: () => setState(() {
        if (_enabled) removeRecipe(widget.recipeKey);
        if (!_enabled) setRecipe(widget.recipeKey, widget.recipeId);

        _enabled = !_enabled;
      }),
    );
  }

  void loadRecipe() {
    getRecipeData(widget.recipeKey).then(
      (recipe) => setState(() => _enabled = true),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
