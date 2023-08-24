import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/gradient/container.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/textfield.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class AddIngredientPage extends StatefulWidget {
  const AddIngredientPage({super.key});

  @override
  State<AddIngredientPage> createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  final nameController = TextEditingController();
  final seasonController = TextEditingController();
  final priceController = TextEditingController();
  final unitController = TextEditingController();

  IngredientDescription ingredient = IngredientDescription.empty();
  int? selectedUnit;

  @override
  void dispose() {
    nameController.dispose();
    seasonController.dispose();
    priceController.dispose();
    unitController.dispose();
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

          Provider.of<IngredientModel>(context, listen: false).add(ingredient);
          Navigator.of(context).pop();
        }
      ),
    ];

    return EmptyPage(
      resizeToAvoidBottomInset: true,
      child: Center(
        child: GradientContainer(
          gradient: toSurfaceGradient(limelightGradient),
          width: MediaQuery.of(context).size.width - 20 * 2,
          child: ListView(
            shrinkWrap: true,
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
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: "Season",
                icon: UniconsLine.snowflake,
                hint: "Winter",
                controller: seasonController,
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
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomTextField(
                      label: "Unit",
                      icon: UniconsLine.ruler,
                      hint: units[0],
                      controller: unitController,
                      suffixIcon: PopupMenuButton<int>(
                        color: toSurfaceGradient(limelightGradient)[1],
                        initialValue: selectedUnit,
                        onSelected: (int item) => setState(
                          () {
                            unitController.text = units[item];
                            selectedUnit = item;
                          },
                        ),
                        itemBuilder: (BuildContext context) {
                          return List<PopupMenuEntry<int>>.generate(
                            units.length,
                            (int index) => PopupMenuItem<int>(
                              value: index,
                              child: Text(
                                units[index],
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(color: textColor()),
                                ),
                              ),
                            ),
                          );
                        },
                        child: GradientIcon(
                          gradient: toTextGradient(limelightGradient),
                          icon: Icons.expand_more,
                        ),
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
