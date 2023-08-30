import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/gradient/container.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/textfield.dart';
import 'package:limelight/widgets/dropdown.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class IngredientEditorPage extends StatefulWidget {
  final String? name;

  const IngredientEditorPage({super.key, this.name});

  @override
  State<IngredientEditorPage> createState() => _IngredientEditorPageState();
}

class _IngredientEditorPageState extends State<IngredientEditorPage> {
  late FocusNode seasonFocusNode;
  late FocusNode priceFocusNode;

  IngredientDescription ingredient = IngredientDescription.empty();

  @override
  void initState() {
    super.initState();

    seasonFocusNode = FocusNode();
    priceFocusNode = FocusNode();
  }

  @override
  void dispose() {
    seasonFocusNode.dispose();
    priceFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<PreferencesModel>(context, listen: false);
    final unitList = units[preferences.unitSystem] ?? ["per unit"];

    loadIngredientFromModel(context);
    if (ingredient.unit == '') ingredient.unit = unitList[0];

    return EmptyPage(
      resizeToAvoidBottomInset: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GradientContainer(
            gradient: toSurfaceGradient(limelightGradient),
            child: ListView(
              shrinkWrap: true,
              reverse: true, // Automatically scroll to the bottom
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              children: [
                Text(
                  "Ingredient",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    color: textColor(),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 2),
                Divider(color: textColor().withOpacity(0.2)),
                const SizedBox(height: 12),
                CustomTextField(
                  label: "Name",
                  icon: UniconsLine.tag_alt,
                  hint: "Lime zest",
                  text: ingredient.name,
                  onSubmitted: (_) => seasonFocusNode.requestFocus(),
                  onChanged: (name) => ingredient.name = name,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  label: "Season",
                  icon: UniconsLine.snowflake,
                  hint: "Winter",
                  text: ingredient.season,
                  focusNode: seasonFocusNode,
                  onSubmitted: (_) => priceFocusNode.requestFocus(),
                  onChanged: (season) => ingredient.season = season,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "Price",
                        icon: UniconsLine.dollar_sign,
                        hint: "1.00",
                        text: ingredient.price,
                        focusNode: priceFocusNode,
                        keyboardType: TextInputType.number,
                        onChanged: (price) => ingredient.price = price,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomDropdown(
                        label: "Unit",
                        values: unitList,
                        icon: UniconsLine.ruler,
                        onChanged: (unit) => ingredient.unit = unit,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
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
                              "Cancel",
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
                        onPressed: () => addIngredient(context),
                        child: Center(
                          child: GradientIcon(
                            gradient: toSurfaceGradient(limelightGradient),
                            icon: Icons.add,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ].reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }

  void loadIngredientFromModel(BuildContext context) {
    if (widget.name != null && ingredient == IngredientDescription.empty()) {
      setState(() {
        final model = Provider.of<IngredientModel>(context, listen: false);
        ingredient = model.ingredients[model.ingredients.indexWhere(
          (element) => element.name == widget.name,
        )];
      });
    }
  }

  void addIngredient(BuildContext context) {
    final model = Provider.of<IngredientModel>(context, listen: false);
    if (widget.name != null) model.remove(widget.name!);
    model.add(ingredient);

    Navigator.of(context).pop();
  }
}
