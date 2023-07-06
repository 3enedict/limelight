import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/fab.dart';
import 'package:limelight/widgets/calendar.dart';
import 'package:limelight/data/recipes.dart';
import 'package:limelight/gradients.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

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
                return recipes[index].toItem(
                  () => Navigator.push(
                    context,
                    PageRouteBuilder<void>(
                      pageBuilder: (BuildContext context, _, __) {
                        return Calendar(recipeId: index);
                      },
                      transitionsBuilder: (
                        ___,
                        Animation<double> animation,
                        ____,
                        Widget child,
                      ) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
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
}
