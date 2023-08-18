import 'package:flutter/material.dart';

import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/gradient/textfield.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => IngredientsPageState();
}

class IngredientsPageState extends State<IngredientsPage> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    final height = PersistentKeyboardHeight.of(context).keyboardHeight;

    return EmptyPage(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 40, height + 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<IngredientModel>(
                  builder: (context, ingredients, child) {
                    Widget items = const SizedBox();
                    if (_query != "") {
                      final matches = ingredients.search(_query);
                      items = ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: matches.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 20,
                            ),
                            child: GradientButton(
                              gradient: toSurfaceGradient(limelightGradient),
                              child: Row(
                                children: [
                                  Text(
                                    matches[index].name,
                                    style: TextStyle(color: textColor()),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    "${matches[index].price} ${matches[index].unit}",
                                    style: TextStyle(color: textColor()),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return items;
                  },
                ),
                const SizedBox(height: 15),
                GradientTextField(
                  hintText: "Search...",
                  onChanged: (query) => setState(() => _query = query),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GradientIcon(
                gradient: toTextGradient(limelightGradient),
                icon: Icons.expand_less,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
