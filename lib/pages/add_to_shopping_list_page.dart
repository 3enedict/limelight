import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/data/json/ingredient_data.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/shopping_list_model.dart';
import 'package:limelight/utils/gradient_container.dart';
import 'package:limelight/utils/custom_textfield.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/languages.dart';

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
    final ingredients = Provider.of<ShoppingListModel>(context, listen: false);

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
                  words['addToShoppingList']![0],
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
                  label: words['name']![0],
                  icon: UniconsLine.tag_alt,
                  hint: words['nameExample']![0],
                  text: ingredient.name,
                  autofocus: true,
                  onSubmitted: (_) => quantityFocusNode.requestFocus(),
                  onChanged: (name) => ingredient.name = name,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  label: words['quantity']![0],
                  icon: UniconsLine.weight,
                  hint: words['quantityExample']![0],
                  text: int.tryParse(ingredient.getQuantity()) == 0
                      ? null
                      : ingredient.getQuantity(),
                  focusNode: quantityFocusNode,
                  onChanged: (quantity) {
                    final num = RegExp(r'(^\d*\.?\d*)').firstMatch(quantity);
                    final string = num![0] ?? '';

                    ingredient.quantity = double.tryParse(string) ?? -1;
                    ingredient.unit = quantity.replaceFirst(string, '');
                  },
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
                                words['back']![0],
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
                            ingredients.addToShoppingList(ingredient);
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
