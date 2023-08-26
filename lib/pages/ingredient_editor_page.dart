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
  final nameController = TextEditingController();
  final seasonController = TextEditingController();
  final priceController = TextEditingController();
  final unitController = TextEditingController();

  late FocusNode seasonFocusNode;
  late FocusNode priceFocusNode;
  late FocusNode unitFocusNode;

  IngredientDescription ingredient = IngredientDescription.empty();
  int? selectedUnit;

  @override
  void initState() {
    super.initState();

    seasonFocusNode = FocusNode();
    priceFocusNode = FocusNode();
    unitFocusNode = FocusNode();
  }

  @override
  void dispose() {
    nameController.dispose();
    seasonController.dispose();
    priceController.dispose();
    unitController.dispose();

    seasonFocusNode.dispose();
    priceFocusNode.dispose();
    unitFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const units = [
      "per kg",
      "per lb",
      "per head",
      "per unit",
    ];

    final actions = [
      ("Cancel", () => Navigator.of(context).pop()),
      (
        "Add",
        () {
          final ingredient = IngredientDescription(
            name: nameController.text,
            season: seasonController.text,
            price: priceController.text,
            unit: unitController.text,
          );

          final model = Provider.of<IngredientModel>(context, listen: false);
          if (widget.name != null) model.remove(widget.name!);
          model.add(ingredient);

          Navigator.of(context).pop();
        }
      ),
    ];

    if (widget.name != null && ingredient == IngredientDescription.empty()) {
      setState(() {
        final model = Provider.of<IngredientModel>(context, listen: false);
        ingredient = model.ingredients[model.ingredients.indexWhere(
          (element) => element.name == widget.name,
        )];

        nameController.text = ingredient.name;
        seasonController.text = ingredient.season;
        priceController.text = ingredient.price;
        unitController.text = ingredient.unit;
      });
    }

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
                  controller: nameController,
                  autofocus: true,
                  onSubmitted: (_) => seasonFocusNode.requestFocus(),
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: "Season",
                  icon: UniconsLine.snowflake,
                  hint: "Winter",
                  controller: seasonController,
                  focusNode: seasonFocusNode,
                  onSubmitted: (_) => priceFocusNode.requestFocus(),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: "Price",
                        icon: UniconsLine.dollar_sign,
                        hint: "1.00",
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        focusNode: priceFocusNode,
                        onSubmitted: (_) {},
                      ),
                    ),
                    const SizedBox(width: 20),
                    const CustomDropdownButton(list: units),
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
}
