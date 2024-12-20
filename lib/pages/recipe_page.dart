import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/widgets/recipe_description_items.dart';
import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/widgets/variation_picker_dialog.dart';
import 'package:limelight/widgets/recipe_description_box.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/pages/shopping_list_page.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/pages/meal_list_page.dart';
import 'package:limelight/pages/calendar_page.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/data/recipe_id.dart';
import 'package:limelight/utils/utils.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/languages.dart';

class RecipePage extends StatefulWidget {
  final RecipeId id;

  const RecipePage({
    super.key,
    required this.id,
  });

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage>
    with AutomaticKeepAliveClientMixin {
  late RecipeId _localId;

  @override
  void initState() {
    super.initState();
    _localId = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final recipes = Provider.of<RecipeModel>(context, listen: false);

    return EmptyPage(
      appBarText: recipes.name(_localId.recipeId),
      child: Column(
        children: [
          Expanded(child: Content(id: _localId)),
          ActionButtons(
            id: _localId,
            onVariationChange: (newId) => setState(() => _localId = newId),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SliverBoxDelegate extends SliverPersistentHeaderDelegate {
  _SliverBoxDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverBoxDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class Content extends StatelessWidget {
  final RecipeId id;
  const Content({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        final width = MediaQuery.of(context).size.width;

        final ingredients = recipes.ingredientList(id);
        final instructions = recipes.instructionSet(id);

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomScrollView(
            slivers: [
              SliverList.list(
                children: [
                  const SizedBox(height: 14),
                  CustomText(
                    text: " ${words['ingredients']![0]}",
                    opacity: 0.5,
                    weight: FontWeight.w300,
                  ),
                ],
              ),
              SliverPersistentHeader(
                delegate: _SliverBoxDelegate(
                  minHeight: 0.0,
                  maxHeight: ingredients.length * (12 * 2 + 20.0) + 10 + 14,
                  child: RecipeDescriptionBox(
                    reverse: true,
                    items: generateIngredients(ingredients),
                  ),
                ),
              ),
              SliverList.list(
                children: [
                  const SizedBox(height: 7),
                  CustomText(
                    text: " ${words['instructions']![0]}",
                    opacity: 0.5,
                    weight: FontWeight.w300,
                  ),
                ],
              ),
              SliverPersistentHeader(
                delegate: _SliverBoxDelegate(
                  minHeight: 0.0,
                  maxHeight: 20 +
                      instructions
                          .map((e) {
                            return 10 * 2 +
                                calculateTextHeight(
                                  e,
                                  width - 6 * 20, // 20 | 20 40(o) text 20 | 20
                                );
                          })
                          .toList()
                          .reduce((a, b) => a + b),
                  child: RecipeDescriptionBox(
                    items: generateInstructions(instructions, width - 6 * 20),
                    reverse: true,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ActionButtons extends StatelessWidget {
  final RecipeId id;
  final void Function(RecipeId) onVariationChange;

  const ActionButtons({
    super.key,
    required this.id,
    required this.onVariationChange,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesModel>(
      builder: (context, prefs, child) {
        return Container(
          color: toBackgroundGradient(limelightGradient)[1],
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientButton(
                  diameter: 54,
                  gradient: toLighterSurfaceGradient(limelightGradient),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return VariationPickerDialog(
                        id: id,
                        onVariationChange: onVariationChange,
                      );
                    },
                  ),
                  child: Center(
                    child: GradientIcon(
                      gradient: toTextGradient(limelightGradient),
                      icon: Icons.layers,
                    ),
                  ),
                ),
                const SizedBox(width: 53 / 3),
                GradientButton(
                  diameter: 53,
                  gradient:
                      limelightGradient.map((e) => e.withOpacity(0.8)).toList(),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  onPressed: prefs.planner == 0
                      ? () => goto(context, CalendarPage(recipe: id))
                      : () => goto(context, MealListPage(recipe: id)),
                  child: Center(
                    child: GradientIcon(
                      gradient: toSurfaceGradient(limelightGradient),
                      icon: prefs.planner == 0
                          ? UniconsLine.calender
                          : UniconsLine.clipboard_notes,
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(width: 53 / 3),
                GradientButton(
                  diameter: 54,
                  gradient: toLighterSurfaceGradient(limelightGradient),
                  onPressed: () => goto(context, const ShoppingListPage()),
                  child: Center(
                    child: GradientIcon(
                      gradient: toTextGradient(limelightGradient),
                      icon: UniconsLine.shopping_basket,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
