import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/data/provider/ingredient_model.dart';

import 'package:limelight/widgets/gradient_box.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/page.dart';
import 'package:provider/provider.dart';

class AddIngredientPage extends StatefulWidget {
  const AddIngredientPage({super.key});

  @override
  State<AddIngredientPage> createState() => AddIngredientPageState();
}

class AddIngredientPageState extends State<AddIngredientPage> {
  List<String> ingredient = ["", "", "", ""];

  @override
  Widget build(BuildContext context) {
    var hints = [
      "Name (lettuce)",
      "Season (all year)",
      "Price (1\$)",
      "Unit (per head)",
    ];

    var fields = List.generate(
      4,
      (int index) => TextField(
        autofocus: true,
        cursorColor: const Color(0xFFEEEEEE),
        decoration: InputDecoration(
          hintText: hints[index],
          hintStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Color(0xFFEEEEEE),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 4),
        ),
        expands: false,
        style: GoogleFonts.workSans(
          textStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Color(0xFFEEEEEE),
          ),
        ),
        onChanged: (input) => setState(
          () => ingredient[index] = input,
        ),
      ),
      growable: true,
    );

    return EmptyPage(
      child: Center(
        child: GradientBox(
          width: MediaQuery.of(context).size.width - 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  "Add ingredient",
                  style: GoogleFonts.workSans(
                    fontSize: 14 * MediaQuery.of(context).textScaleFactor * 1.2,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ...fields,
              Padding(
                padding: const EdgeInsets.all(20),
                child: GradientButton(
                  height: 44,
                  onPressed: () {
                    Provider.of<IngredientModel>(context, listen: false).add(
                      IngredientDescription(
                        name: ingredient[0],
                        season: ingredient[1],
                        price: ingredient[2],
                        unit: ingredient[3],
                        group: 0,
                      ),
                    );

                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Submit",
                    style: GoogleFonts.workSans(
                      textStyle: const TextStyle(color: Colors.white),
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
