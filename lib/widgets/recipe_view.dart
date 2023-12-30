import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/widgets/recipe_description_items.dart';
import 'package:limelight/widgets/variation_picker_dialog.dart';
import 'package:limelight/widgets/recipe_description_box.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/pages/shopping_list_page.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/pages/calendar_page.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/data/recipe_id.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

class RecipeView extends StatefulWidget {
  final RecipeId id;
  const RecipeView({super.key, required this.id});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView>
    with AutomaticKeepAliveClientMixin {
  late PageController _controller;
  late RecipeId _localId;
  double _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _localId = widget.id;
    _controller = PageController(initialPage: 1);
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? _currentPage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final recipes = Provider.of<RecipeModel>(context, listen: false);

    return PageView(
      controller: _controller,
      physics: _currentPage == 1
          ? const NeverScrollableScrollPhysics()
          : const PageScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: [
        CalendarPage(recipe: _localId),
        EmptyPage(
          appBarText: recipes.name(_localId.recipeId),
          child: Column(
            children: [
              Expanded(child: Content(id: _localId)),
              ActionButtons(
                id: _localId,
                controller: _controller,
                onVariationChange: (newId) => setState(() => _localId = newId),
              ),
            ],
          ),
        ),
        ShoppingListPage(pageController: _controller),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class Content extends StatelessWidget {
  final RecipeId id;
  const Content({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<RecipeModel>(context, listen: false);
    final width = MediaQuery.of(context).size.width - 20 * 2 * 2;

    final ingredients = recipes.ingredientList(id);
    final instructions = recipes.instructionSet(id);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 14),
            RecipeDescriptionBox(
              label: "Ingredients",
              items: generateIngredients(ingredients),
            ),
            const SizedBox(height: 14),
            RecipeDescriptionBox(
              label: "Instructions",
              items: generateInstructions(instructions, width),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final RecipeId id;
  final PageController controller;
  final void Function(RecipeId) onVariationChange;

  const ActionButtons({
    super.key,
    required this.id,
    required this.controller,
    required this.onVariationChange,
  });

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => controller.animateToPage(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              ),
              child: Center(
                child: GradientIcon(
                  gradient: toSurfaceGradient(limelightGradient),
                  icon: UniconsLine.calender,
                  size: 26,
                ),
              ),
            ),
            const SizedBox(width: 53 / 3),
            GradientButton(
              diameter: 54,
              gradient: toLighterSurfaceGradient(limelightGradient),
              onPressed: () => controller.animateToPage(
                2,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              ),
              child: const Center(
                child: GradientIcon(
                  gradient: limelightGradient,
                  icon: UniconsLine.shopping_basket,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
