import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/widgets/items/ingredient_search_item.dart';
import 'package:search_page/search_page.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/gradients.dart';

void showIngredientSearch(BuildContext context) {
  showSearch(
    context: context,
    delegate: SearchPage<IngredientDescription>(
      items: Provider.of<IngredientModel>(context).ingredients,
      searchLabel: 'Search ingredients...',
      barTheme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: toBackgroundGradient(limelightGradient)[0],
          foregroundColor: textColor(),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          border: InputBorder.none,
          hintStyle: GoogleFonts.workSans(
            textStyle: TextStyle(
              color: textColor(),
              fontSize: 18,
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.workSans(
            textStyle: TextStyle(
              color: textColor(),
              fontSize: 18,
            ),
          ),
        ),
        scaffoldBackgroundColor: toBackgroundGradient(limelightGradient)[0],
      ),
      suggestion: Center(
        child: Text(
          'Filter ingredients by name',
          style: GoogleFonts.workSans(
            textStyle: TextStyle(color: textColor()),
          ),
        ),
      ),
      failure: Center(
        child: Text(
          'No ingredients found...',
          style: GoogleFonts.workSans(
            textStyle: TextStyle(color: textColor()),
          ),
        ),
      ),
      filter: (ingredient) => [ingredient.name],
      builder: (ingredient) => IngredientSearchItem(ingredient: ingredient),
    ),
  );
}
