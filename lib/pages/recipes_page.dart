import 'package:flutter/material.dart';

import 'package:limelight/main.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/calendar.dart';
import 'package:limelight/widgets/custom_fab.dart';
import 'package:limelight/widgets/custom_sliver_list.dart';
import 'package:limelight/pages/recipe_description_page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/transitions.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      gradient: limelightGradient,
      fab: CustomFloatingActionButton(
        gradient: toSurfaceGradient(limelightGradient),
        icon: const Icon(Icons.calendar_month_rounded),
        onPressed: () {},
      ),
      child: CustomSliverList(
        title: 'Recipes',
        titleBackground: const AssetImage('assets/Recipes.jpg'),
        padding: 80,
        gradient: limelightGradient,
        keyValue: 1,
        items: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return recipes[index].toItem(
                fadeTransition(
                  context,
                  Calendar(
                    recipeId: index,
                  ),
                ),
                fadeTransition(
                  context,
                  RecipeDescriptionPage(
                    recipeId: index,
                  ),
                ),
              );
            },
            childCount: recipes.length,
          ),
        ),
      ),
    );
  }
}
