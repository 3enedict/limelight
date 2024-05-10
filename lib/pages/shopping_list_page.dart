import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/shopping_list_model.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/utils/gradient_container.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

// Hmphh...
// https://github.com/flutter/flutter/issues/31476

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: List.generate(
        2,
        (i) => ShoppingListSubPage(
          shoppingListPageController: _pageController,
          cart: i == 1,
        ),
      ),
    );
  }
}

class ShoppingListSubPage extends StatelessWidget {
  final PageController shoppingListPageController;
  final bool cart;

  const ShoppingListSubPage({
    super.key,
    required this.shoppingListPageController,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer4<IngredientModel, RecipeModel, CalendarModel,
        ShoppingListModel>(
      builder: (context, ingredients, recipes, calendar, shoppingList, child) {
        final gradient = cart ? redGradient : limelightGradient;

        List<IngredientData> listFromRecipes = [];

        final meals = calendar.meals;
        for (var id in meals) {
          final ingredientList = recipes.ingredientList(id);
          for (var ingredient in ingredientList) {
            final index = find(listFromRecipes, ingredient);
            if (index == null) {
              listFromRecipes.add(IngredientData.from(ingredient));
            } else {
              listFromRecipes[index].add(ingredient.quantity);
            }
          }
        }

        if (!cart) {
          for (var item in shoppingList.recipesCart) {
            int? index = find(listFromRecipes, item);
            if (index != null) {
              listFromRecipes[index].remove(item.quantity);

              if (listFromRecipes[index].quantity <= 0) {
                listFromRecipes.removeAt(index);
              }
            }
          }
        }

        final list = cart
            ? [...shoppingList.shoppingCart, ...shoppingList.recipesCart]
            : [...shoppingList.shoppingList, ...listFromRecipes];

        if (!cart && list.isEmpty && shoppingList.recipesCart.isNotEmpty) {
          return EmptyPage(
            appBarText: 'Ingredients to buy',
            gradient: gradient,
            child: Center(
              child: GradientButton(
                onPressed: () {
                  ingredients.clear();
                  shoppingList.clear();
                  Navigator.of(context).pop();
                },
                gradient: toSurfaceGradient(limelightGradient),
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: const CustomText(text: 'Done'),
              ),
            ),
          );
        }

        return EmptyPage(
          appBarText: cart ? 'Shopping cart' : 'Ingredients to buy',
          backButton: true,
          gradient: gradient,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: cart
                          ? DismissDirection.endToStart
                          : DismissDirection.startToEnd,
                      onDismissed: cart
                          ? (_) {
                              final len = shoppingList.shoppingCart.length;
                              final isFromRecipes = !(index < len);

                              if (isFromRecipes) {
                                shoppingList.remove(list[index]);
                              } else {
                                shoppingList.unbuy(list[index]);
                              }
                            }
                          : (_) {
                              final len = shoppingList.shoppingList.length;
                              final isFromRecipes = !(index < len);

                              if (isFromRecipes) {
                                shoppingList.add(list[index]);
                              } else {
                                shoppingList.buy(list[index]);
                              }
                            },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: GradientContainer(
                          borderRadius: 20,
                          gradient: toSurfaceGradient(gradient),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                child: GradientIcon(
                                  gradient: gradient,
                                  icon: Icons.panorama_fish_eye,
                                  size: 20,
                                ),
                              ),
                              CustomText(
                                color: toTextGradient(gradient)[0],
                                text: list[index].getName(
                                  list[index].quantity.round(),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              CustomText(
                                color: toTextGradient(gradient)[1],
                                text: list[index].getQuantity(),
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
              Container(
                color: toBackgroundGradient(gradient)[1],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientButton(
                        diameter: 54,
                        gradient: toLighterSurfaceGradient(limelightGradient),
                        onPressed: cart
                            ? () => shoppingListPageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                )
                            : () => Navigator.of(context).pop(),
                        child: Center(
                          child: GradientIcon(
                            gradient: limelightGradient,
                            icon: cart ? Icons.arrow_back : Icons.close,
                          ),
                        ),
                      ),
                      const SizedBox(width: 53 / 3),
                      GradientButton(
                        diameter: 54,
                        gradient: toLighterSurfaceGradient(redGradient),
                        onPressed: cart
                            ? () => Navigator.of(context).pop()
                            : () => shoppingListPageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                ),
                        child: Center(
                          child: GradientIcon(
                            gradient: redGradient,
                            icon: cart ? Icons.close : Icons.arrow_forward,
                          ),
                        ),
                      ),
                    ],
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
