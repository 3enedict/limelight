import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/shopping_list_model.dart';
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
  PageController pageController;

  ShoppingListPage({super.key, required this.pageController});

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
          pageController: widget.pageController,
          shoppingListPageController: _pageController,
          cart: i == 1,
        ),
      ),
    );
  }
}

class ShoppingListSubPage extends StatefulWidget {
  PageController pageController;
  PageController shoppingListPageController;
  bool cart;

  ShoppingListSubPage({
    super.key,
    required this.pageController,
    required this.shoppingListPageController,
    required this.cart,
  });

  @override
  State<ShoppingListSubPage> createState() => _ShoppingListSubPageState();
}

class _ShoppingListSubPageState extends State<ShoppingListSubPage> {
  bool _start = false;

  @override
  Widget build(BuildContext context) {
    return Consumer3<RecipeModel, CalendarModel, ShoppingListModel>(
      builder: (context, recipes, calendar, shoppingList, child) {
        final gradient = widget.cart ? redGradient : limelightGradient;

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

        if (!widget.cart) {
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

        final list = widget.cart
            ? [...shoppingList.shoppingCart, ...shoppingList.recipesCart]
            : [...shoppingList.shoppingList, ...listFromRecipes];

        return EmptyPage(
          appBarText: widget.cart ? 'Shopping cart' : 'Ingredients to buy',
          gradient: gradient,
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
                        widget.pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    }

                    return false;
                  },
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: UniqueKey(),
                        direction: widget.cart
                            ? DismissDirection.endToStart
                            : DismissDirection.startToEnd,
                        onDismissed: widget.cart
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
                        onPressed: widget.cart
                            ? () =>
                                widget.shoppingListPageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                )
                            : () {},
                        child: Center(
                          child: GradientIcon(
                            gradient: limelightGradient,
                            icon: widget.cart
                                ? Icons.arrow_back
                                : Icons.panorama_fish_eye,
                          ),
                        ),
                      ),
                      const SizedBox(width: 53 / 3),
                      GradientButton(
                        diameter: 54,
                        gradient: toLighterSurfaceGradient(redGradient),
                        onPressed: widget.cart
                            ? () {}
                            : () =>
                                widget.shoppingListPageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                ),
                        child: Center(
                          child: GradientIcon(
                            gradient: redGradient,
                            icon: widget.cart
                                ? Icons.panorama_fish_eye
                                : Icons.arrow_forward,
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
