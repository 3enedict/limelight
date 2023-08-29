import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
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
    const units = ["per kg", "per unit"];
    final actions = [
      ("Cancel", () => Navigator.of(context).pop()),
      ("Add", () => addIngredient(context)),
    ];

    loadIngredientFromModel(context);
    if (ingredient.unit == '') ingredient.unit = units[0];

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
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 25),
              children: [
                Text(
                  "Ingredient",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    color: textColor(),
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 2),
                Divider(color: textColor().withOpacity(0.2)),
                const SizedBox(height: 15),
                CustomTextField(
                  label: "Name",
                  icon: UniconsLine.tag_alt,
                  hint: "Lime zest",
                  text: ingredient.name,
                  onSubmitted: (_) => seasonFocusNode.requestFocus(),
                  onChanged: (name) => ingredient.name = name,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: "Season",
                  icon: UniconsLine.snowflake,
                  hint: "Winter",
                  text: ingredient.season,
                  focusNode: seasonFocusNode,
                  onSubmitted: (_) => priceFocusNode.requestFocus(),
                  onChanged: (season) => ingredient.season = season,
                ),
                const SizedBox(height: 15),
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
                        values: units,
                        icon: UniconsLine.ruler,
                        onChanged: (unit) => ingredient.unit = unit,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    actions.length,
                    (int index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GradientButton(
                        borderRadius: 100,
                        height: 50,
                        width: 150,
                        onPressed: actions[index].$2,
                        child: Center(
                          child: Text(
                            actions[index].$1,
                            style: GoogleFonts.workSans(
                              color: toSurfaceGradient(limelightGradient)[1],
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
