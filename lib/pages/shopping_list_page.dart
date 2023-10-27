import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:limelight/data/json/ingredient_data.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class ShoppingListPage extends StatefulWidget {
  PageController pageController;

  ShoppingListPage({super.key, required this.pageController});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  bool _start = false;

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      appBarText: "Ingredients to buy",
      child: Consumer2<CalendarModel, RecipeModel>(
        builder: (context, calendar, recipes, child) {
          final meals = calendar.meals;
          List<IngredientData> ingredients = [];

          for (var meal in meals) {
            final list = recipes.ingredientList(
              meal.recipeId,
              meal.servings,
              meal.variationIds.mapIndexed((i, e) => (i, e)).toList(),
            );

            for (var item in list) {
              final index = ingredients.indexWhere((e) => e.name == item.name);
              if (index == -1) {
                ingredients.add(item);
              } else if (item.quantity.isNotEmpty) {
                final i = ingredients[index].quantity;

                final unit = i.replaceAll(RegExp(r"\d"), "");
                final n1 = i.replaceAll(RegExp(r"\D"), "");
                final n2 = item.quantity.replaceAll(RegExp(r"\D"), "");

                if (n1.isNotEmpty && n2.isNotEmpty) {
                  final num = int.parse(n1) + int.parse(n2);
                  ingredients[index].quantity = '$num$unit';
                }
              }
            }
          }

          return NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) _start = true;
              if (notification is ScrollUpdateNotification) _start = false;

              if (notification is OverscrollNotification && _start == true) {
                if (notification.overscroll < 0) {
                  widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              }

              return false;
            },
            child: ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: GradientContainer(
                    borderRadius: 20,
                    gradient: toSurfaceGradient(limelightGradient),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: GradientIcon(
                              icon: Icons.panorama_fish_eye, size: 20),
                        ),
                        CustomText(text: ingredients[index].name),
                        const Expanded(child: SizedBox()),
                        CustomText(
                          text: ingredients[index].quantity,
                          opacity: 0.6,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(width: 16)
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
