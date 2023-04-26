import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/fab.dart';
import 'package:limelight/widgets/data/recipe.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/widgets/calendar.dart';
import 'package:limelight/gradients.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  final recipes = const [
    RecipeData(
      name: 'Pasta and tomato sauce',
      time: '30 min',
      price: '\$0.50',
      gradient: limelightGradient,
    ),
    RecipeData(
      name: 'Fried rice',
      time: '40 min',
      price: '\$1.00',
      gradient: limelightGradient,
    ),
    RecipeData(
      name: 'Tomatoes and mozzarella',
      time: '15 min',
      price: '\$1.50',
      gradient: limelightGradient,
    ),
    RecipeData(
      name: 'Leek and potato soup',
      time: '30 min',
      price: '\$0.30',
      gradient: limelightGradient,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toBackgroundGradient(limelightGradient),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: CustomFloatingActionButton(
          gradient: toSurfaceGradient(limelightGradient),
          icon: const Icon(Icons.calendar_month_rounded),
          onPressed: () {},
        ),
        body: DefaultPage(
          title: 'Recipes',
          titleBackground: const AssetImage('assets/Recipes.jpg'),
          padding: 80,
          backgroundGradient: toBackgroundGradient(limelightGradient),
          keyValue: 1,
          items: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Hero(
                  tag: index.toString(),
                  child: recipes[index].toItem(
                    () {
                      _gotoDetailsPage(
                        context,
                        index,
                        Calendar(
                          currentRecipe: recipes[index],
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: recipes.length,
            ),
          ),
        ),
      ),
    );
  }

  void _gotoDetailsPage(BuildContext context, int index, Calendar calendar) {
    RecipeData currentRecipe = RecipeData(
      name: recipes[index].name,
      time: recipes[index].time,
      price: recipes[index].price,
      gradient: meatGradient,
    );

    Navigator.of(context).push(
      CalendarRoute(
        builder: (_) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: toBackgroundGradient(limelightGradient),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (bound) {
                    return LinearGradient(
                        end: FractionalOffset.topCenter,
                        begin: FractionalOffset.bottomCenter,
                        colors: [
                          toBackgroundGradient(limelightGradient)[1],
                          toBackgroundGradient(limelightGradient)[1],
                          toBackgroundGradient(limelightGradient)[1]
                              .withAlpha(0),
                        ],
                        stops: const [
                          0.0,
                          0.1,
                          0.3,
                        ]).createShader(bound);
                  },
                  blendMode: BlendMode.srcOver,
                  child: Column(
                    children: [
                      Expanded(
                        child: calendar,
                      ),
                      const SizedBox(height: itemExtent + 5 + 15),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    const SizedBox(height: 5),
                    Hero(
                      tag: index.toString(),
                      child: currentRecipe.toItem(
                        () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CalendarRoute extends MaterialPageRoute {
  CalendarRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);
}
