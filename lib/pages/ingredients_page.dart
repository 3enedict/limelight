import 'package:flutter/material.dart';

import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/ingredient_groups.dart';

import 'package:limelight/pages/ingredients_search_page.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/items/ingredient.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/transitions.dart';
import 'package:provider/provider.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  IngredientsPageState createState() => IngredientsPageState();
}

class IngredientsPageState extends State<IngredientsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final gradient = gradients[_currentIndex];

    return EmptyPage(
      gradient: gradient,
      fab: GradientButton(
        diameter: 56,
        gradient: toSurfaceGradient(gradient),
        onPressed: () => fadeTransition(
          context,
          SearchPage(
            onSubmitted: (e) {},
          ),
        ),
        padding: const EdgeInsets.all(0),
        child: const Center(
          child: Icon(
            Icons.search,
            color: Colors.white70,
          ),
        ),
      ),
      bottomNavBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          bottomNavBarItem(leafyGreensGradient),
          bottomNavBarItem(vegetablesGradient),
          bottomNavBarItem(meatGradient),
          bottomNavBarItem(fishGradient),
        ],
      ),
      child: IndexedStack(
        index: _currentIndex,
        children: List.generate(
          names.length,
          (int index) => ItemList(
            title: names[index],
            titleBackground: AssetImage(images[index]),
            gradient: fishGradient,
            items: Consumer<IngredientModel>(
              builder: (context, ingredients, child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int listIndex) {
                      return IngredientItem(
                        groupId: index,
                        ingredientId: listIndex,
                      );
                    },
                    childCount: ingredients.number(index),
                  ),
                );
              },
            ),
          ),
          growable: false,
        ),
      ),
    );
  }
}

BottomNavigationBarItem bottomNavBarItem(List<Color> gradient) {
  return BottomNavigationBarItem(
    icon: ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(colors: gradient).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: const Icon(
        FontAwesome5.circle,
      ),
    ),
    label: '',
    backgroundColor: Colors.transparent,
  );
}
