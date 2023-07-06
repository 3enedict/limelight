import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/fab.dart';
import 'package:limelight/widgets/data/recipe.dart';
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
                return Hero(
                  tag: index,
                  child: recipes[index].toItem(
                    () {
                      _gotoDetailsPage(
                        context,
                        index,
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

  void _gotoDetailsPage(BuildContext context, int index) {
    RecipeData currentRecipe = RecipeData.empty();

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
            body: Column(
              children: [
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (bound) {
                      return LinearGradient(
                          end: FractionalOffset.topCenter,
                          begin: FractionalOffset.bottomCenter,
                          colors: [
                            toBackgroundGradient(limelightGradient)[1],
                            toBackgroundGradient(limelightGradient)[1]
                                .withAlpha(0),
                          ],
                          stops: const [
                            0.0,
                            0.3,
                          ]).createShader(bound);
                    },
                    blendMode: BlendMode.srcOver,
                    child: Calendar(recipeId: index),
                  ),
                ),
                Hero(
                  tag: currentRecipe,
                  child: Card(
                    color: Colors.transparent,
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: limelightGradient,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width - 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Back",
                          style: GoogleFonts.workSans(
                            fontSize: 14 *
                                MediaQuery.of(context).textScaleFactor *
                                1.1,
                            textStyle: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
