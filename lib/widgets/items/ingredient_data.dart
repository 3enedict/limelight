import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/pages/add_ingredient_page.dart';
import 'package:limelight/pages/ingredients_search_page.dart';
import 'package:limelight/transitions.dart';
import 'package:limelight/widgets/gradient_box.dart';
import 'package:limelight/widgets/page.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/gradients.dart';

class IngredientDataItem extends StatefulWidget {
  final int recipeId;
  final IngredientData ingredient;

  const IngredientDataItem({
    super.key,
    required this.recipeId,
    required this.ingredient,
  });

  @override
  State<IngredientDataItem> createState() => IngredientDataItemState();
}

class IngredientDataItemState extends State<IngredientDataItem> {
  Offset _tapPosition = Offset.zero;

  void _showCustomMenu(BuildContext context) {
    final overlay = Overlay.of(context).context.findRenderObject();
    if (overlay == null) return;

    final text = ["Edit", "Add", "Remove"];

    final icons = [
      FeatherIcons.edit2,
      Icons.exposure_plus_1,
      FeatherIcons.trash,
    ];

    final actions = [
      () {
        Future(() {
          fadeTransition(
            context,
            SearchPage(
              onSubmitted: (desc) =>
                  Provider.of<RecipeModel>(context, listen: false)
                      .addIngredient(
                widget.recipeId,
                IngredientData(
                  name: desc.name,
                  quantity: "1",
                ),
              ),
            ),
          );

          Provider.of<RecipeModel>(context, listen: false).removeIngredient(
            widget.recipeId,
            widget.ingredient,
          );
        });
      },
      () => Future(
            () => fadeTransition(
              context,
              EmptyPage(
                child: Center(
                  child: GradientBox(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Text(
                            "Quantity of ${widget.ingredient.name}",
                            style: GoogleFonts.workSans(
                              fontSize: 14 *
                                  MediaQuery.of(context).textScaleFactor *
                                  1.2,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: TextField(
                            autofocus: true,
                            cursorColor: const Color(0xFFEEEEEE),
                            decoration: const InputDecoration(
                              hintText: "10/500g",
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color(0xFFEEEEEE),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 4),
                            ),
                            expands: false,
                            style: GoogleFonts.workSans(
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color(0xFFEEEEEE),
                              ),
                            ),
                            onSubmitted: (quantity) {
                              Provider.of<RecipeModel>(context, listen: false)
                                  .removeIngredient(
                                widget.recipeId,
                                widget.ingredient,
                              );

                              Provider.of<RecipeModel>(context, listen: false)
                                  .addIngredient(
                                widget.recipeId,
                                IngredientData(
                                  name: widget.ingredient.name,
                                  quantity: quantity,
                                ),
                              );

                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      () => Provider.of<RecipeModel>(context, listen: false).removeIngredient(
            widget.recipeId,
            widget.ingredient,
          ),
    ];

    showMenu(
      context: context,
      color: toSurfaceGradient(limelightGradient)[1],
      items: List.generate(
        3,
        (int index) => PopupMenuItem(
          onTap: actions[index],
          child: Row(
            children: [
              Icon(
                icons[index],
                color: Colors.white70,
                size: 18,
              ),
              const SizedBox(width: 12),
              Text(
                text[index],
                style: GoogleFonts.workSans(
                  textStyle: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
        growable: false,
      ),
      position: RelativeRect.fromRect(
        _tapPosition & const Size(40, 40),
        Offset.zero & overlay.semanticBounds.size,
      ),
    );
  }

  void _storePosition(TapDownDetails details) {
    setState(() => _tapPosition = details.globalPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientModel>(
      builder: (context, ingredients, child) {
        return GestureDetector(
          onTapDown: _storePosition,
          child: Item(
            title: widget.ingredient.name,
            info: widget.ingredient.quantity,
            onPressed: () {},
            onLongPress: () => _showCustomMenu(context),
          ),
        );
      },
    );
  }
}
