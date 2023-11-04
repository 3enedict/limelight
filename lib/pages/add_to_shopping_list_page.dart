import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/data/json/ingredient_data.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/custom_textfield.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class AddToShoppingListPage extends StatefulWidget {
  final String? name;

  const AddToShoppingListPage({super.key, this.name});

  @override
  State<AddToShoppingListPage> createState() => _AddToShoppingListPageState();
}

class _AddToShoppingListPageState extends State<AddToShoppingListPage> {
  late FocusNode quantityFocusNode;

  IngredientData ingredient = IngredientData.empty();

  @override
  Widget build(BuildContext context) {
    final ingredients = Provider.of<IngredientModel>(context, listen: false);

    return EmptyPage(
      resizeToAvoidBottomInset: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: GradientContainer(
            gradient: toSurfaceGradient(limelightGradient),
            borderRadius: 20,
            child: ListView(
              shrinkWrap: true,
              reverse: true, // Automatically scroll to the bottom
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              children: [
                Text(
                  "Add to shopping list",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    color: textColor(),
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 2),
                Divider(color: textColor().withOpacity(0.2)),
                const SizedBox(height: 8),
                CustomTextField(
                  label: "Name",
                  icon: UniconsLine.tag_alt,
                  hint: "Tomato sauce",
                  text: ingredient.name,
                  autofocus: true,
                  onSubmitted: (_) => quantityFocusNode.requestFocus(),
                  onChanged: (name) => ingredient.name = name,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  label: "Quantity",
                  icon: UniconsLine.weight,
                  hint: "2 cans",
                  text: ingredient.quantity,
                  focusNode: quantityFocusNode,
                  onChanged: (quantity) => ingredient.quantity = quantity,
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GradientButton(
                            outlineBorder: true,
                            height: 50,
                            borderRadius: 100,
                            onPressed: () => Navigator.of(context).pop(),
                            child: Center(
                              child: Text(
                                "Done",
                                style: GoogleFonts.workSans(
                                  color: textColor(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GradientButton(
                          diameter: 50,
                          gradient: limelightGradient,
                          onPressed: () {
                            ingredients.addToShoppingList(
                              ingredient.name,
                              ingredient.quantity,
                            );

                            setState(() => ingredient = IngredientData.empty());
                          },
                          child: Center(
                            child: GradientIcon(
                              gradient: toSurfaceGradient(limelightGradient),
                              icon: Icons.add,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ].reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    quantityFocusNode = FocusNode();
  }

  @override
  void dispose() {
    quantityFocusNode.dispose();
    super.dispose();
  }
}
