import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/gradients.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/gradient_box.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/ingredient_groups.dart';

class AddIngredientPage extends StatefulWidget {
  const AddIngredientPage({super.key});

  @override
  State<AddIngredientPage> createState() => AddIngredientPageState();
}

class AddIngredientPageState extends State<AddIngredientPage> {
  List<String> ingredient = ["", "", "", ""];
  int id = 0;

  @override
  Widget build(BuildContext context) {
    var hints = [
      "Name",
      "Season",
      "Price",
      "Unit",
    ];

    var fields = List.generate(
      4,
      (int index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
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
      ),
      growable: true,
    );

    var groups = List.generate(
      numberOfGroups,
      (int index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GradientButton(
          gradient: toSurfaceGradient(gradients[index]),
          onPressed: () => setState(() => id = index),
          padding: const EdgeInsets.all(0),
          width: 70,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(colors: gradients[index]),
            ),
            height: 24,
            width: 24,
          ),
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: groups,
              ),
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
                        group: id,
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
