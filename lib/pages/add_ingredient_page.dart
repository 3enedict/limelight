import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/textfield.dart';
import 'package:limelight/gradients.dart';
import 'package:unicons/unicons.dart';

const units = [
  "per kg",
  "per lb",
  "per head",
  "per unit",
];

class AddIngredientPage extends StatefulWidget {
  const AddIngredientPage({super.key});

  @override
  State<AddIngredientPage> createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  final unitController = TextEditingController();
  int? selectedUnit;

  @override
  void dispose() {
    unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      resizeToAvoidBottomInset: true,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: modifyColor(limelightGradient[1], 0.08, 0.1),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(1, 1),
              ),
            ],
            gradient: LinearGradient(
              colors: toSurfaceGradient(limelightGradient),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
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
              const CustomTextField(
                label: "Name",
                icon: UniconsLine.tag_alt,
                hint: "Lime zest",
              ),
              const SizedBox(height: 15),
              const CustomTextField(
                label: "Season",
                icon: UniconsLine.snowflake,
                hint: "Winter",
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Expanded(
                    child: CustomTextField(
                      label: "Price",
                      icon: UniconsLine.dollar_sign,
                      hint: "1.00",
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
                children: [
                  GradientButton(
                    gradient: limelightGradient.reversed.toList(),
                    borderRadius: 100,
                    height: 50,
                    width: 150,
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.workSans(
                        color: toSurfaceGradient(limelightGradient)[1],
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GradientButton(
                    borderRadius: 100,
                    height: 50,
                    width: 150,
                    child: Text(
                      "Add",
                      style: GoogleFonts.workSans(
                        color: toSurfaceGradient(limelightGradient)[1],
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
