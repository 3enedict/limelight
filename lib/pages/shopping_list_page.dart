import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/gradient_button.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

// Hmphh...
// https://github.com/flutter/flutter/issues/31476

class ShoppingListPage extends StatefulWidget {
  PageController pageController;

  ShoppingListPage({super.key, required this.pageController});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  bool _start = false;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<CalendarModel, RecipeModel, IngredientModel>(
      builder: (context, calendar, recipes, ingModel, child) {
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

        final names = ingModel.shopped.map((e) => e.split(':')[0]).toList();
        for (var i = 0; i < ingredients.length; i++) {
          if (names.contains(ingredients[i].name)) {
            final ing = ingModel.shopped[names.indexOf(ingredients[i].name)];

            final unit = ingredients[i].quantity.replaceAll(RegExp(r"\d"), "");
            final n1 = ingredients[i].quantity.replaceAll(RegExp(r"\D"), "");
            final n2 = ing.split(':')[1].replaceAll(RegExp(r"\D"), "");

            if (int.tryParse(n2) == null) {
              ingredients.removeAt(i);
              i--;
            } else {
              final quantity = int.parse(n1) - int.parse(n2);

              if (quantity == 0) {
                ingredients.removeAt(i);
                i--;
              } else {
                ingredients[i].quantity = '$quantity$unit';
              }
            }
          }
        }

        return PageView(
          controller: _pageController,
          children: [
            EmptyPage(
              appBarText: "Ingredients to buy",
              child: Column(
                children: [
                  Expanded(
                    child: NotificationListener(
                      onNotification: (notification) {
                        if (notification is ScrollStartNotification) {
                          _start = true;
                        }

                        if (notification is ScrollUpdateNotification) {
                          _start = false;
                        }

                        if (notification is OverscrollNotification &&
                            _start == true) {
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
                          final name = ingredients[index].name;
                          final quantity = ingredients[index].quantity;

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                            child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (_) => ingModel.shop(name, quantity),
                              child: GradientContainer(
                                borderRadius: 20,
                                gradient: toSurfaceGradient(limelightGradient),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(16, 16, 16, 16),
                                      child: GradientIcon(
                                          icon: Icons.panorama_fish_eye,
                                          size: 20),
                                    ),
                                    CustomText(text: name),
                                    const Expanded(child: SizedBox()),
                                    CustomText(
                                      text: quantity,
                                      opacity: 0.6,
                                      weight: FontWeight.w400,
                                    ),
                                    const SizedBox(width: 16)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    color: toBackgroundGradient(limelightGradient)[1],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientButton(
                            diameter: 54,
                            gradient:
                                toLighterSurfaceGradient(limelightGradient),
                            onPressed: () {},
                            child: const Center(
                              child: GradientIcon(
                                gradient: limelightGradient,
                                icon: Icons.panorama_fish_eye,
                              ),
                            ),
                          ),
                          const SizedBox(width: 53 / 3),
                          GradientButton(
                            diameter: 54,
                            gradient:
                                toLighterSurfaceGradient(limelightGradient),
                            onPressed: () => _pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            ),
                            child: const Center(
                              child: GradientIcon(
                                gradient: redGradient,
                                icon: Icons.arrow_forward,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            EmptyPage(
              appBarText: "Shopping cart",
              gradient: redGradient,
              child: Column(
                children: [
                  Expanded(
                    child: NotificationListener(
                      onNotification: (notification) {
                        if (notification is ScrollStartNotification) {
                          _start = true;
                        }

                        if (notification is ScrollUpdateNotification) {
                          _start = false;
                        }

                        if (notification is OverscrollNotification &&
                            _start == true) {
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
                        itemCount: ingModel.shopped.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                            child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) => ingModel.unshop(index),
                              child: GradientContainer(
                                borderRadius: 20,
                                gradient: toSurfaceGradient(redGradient),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(16, 16, 16, 16),
                                      child: GradientIcon(
                                        gradient: redGradient,
                                        icon: Icons.panorama_fish_eye,
                                        size: 20,
                                      ),
                                    ),
                                    CustomText(
                                      color: toTextGradient(redGradient)[0],
                                      text:
                                          ingModel.shopped[index].split(':')[0],
                                    ),
                                    const Expanded(child: SizedBox()),
                                    CustomText(
                                      color: toTextGradient(redGradient)[1],
                                      text:
                                          ingModel.shopped[index].split(':')[1],
                                      opacity: 0.6,
                                      weight: FontWeight.w400,
                                    ),
                                    const SizedBox(width: 16)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    color: toBackgroundGradient(redGradient)[1],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientButton(
                            diameter: 54,
                            gradient: toLighterSurfaceGradient(redGradient),
                            onPressed: () => _pageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            ),
                            child: const Center(
                              child: GradientIcon(
                                gradient: limelightGradient,
                                icon: Icons.arrow_back,
                              ),
                            ),
                          ),
                          const SizedBox(width: 53 / 3),
                          GradientButton(
                            diameter: 54,
                            gradient: toLighterSurfaceGradient(redGradient),
                            onPressed: () {},
                            child: const Center(
                              child: GradientIcon(
                                gradient: redGradient,
                                icon: Icons.panorama_fish_eye,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
