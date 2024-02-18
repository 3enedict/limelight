import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/utils/custom_divider.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/widgets/preference.dart';
import 'package:limelight/utils/flat_button.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/data/recipe_id.dart';
import 'package:limelight/gradients.dart';

class VariationPickerDialog extends StatefulWidget {
  final RecipeId id;
  final void Function(RecipeId) onVariationChange;

  const VariationPickerDialog({
    super.key,
    required this.id,
    required this.onVariationChange,
  });

  @override
  State<VariationPickerDialog> createState() => _VariationPickerDialogState();
}

class _VariationPickerDialogState extends State<VariationPickerDialog> {
  RecipeId _id = RecipeId(recipeId: 0, servings: 0);

  @override
  Widget build(BuildContext context) {
    if (_id.servings == 0) _id = widget.id;

    final recipes = Provider.of<RecipeModel>(context, listen: false);

    List<Widget> variationList = [];
    final num = recipes.nbVarGroups(_id.recipeId);

    for (var i = 0; i < num; i++) {
      int selected = _id.variationIds[i];
      List<String> names = recipes.variationGroup(_id.recipeId, i).names;

      variationList.add(
        Preference(
          icon: Icons.panorama_fish_eye,
          text: recipes.variationGroupName(_id.recipeId, i),
          selected: names[selected],
          values: names,
          onChanged: (str) {
            setState(() => _id.variationIds[i] = names.indexOf(str));
            widget.onVariationChange(_id);
          },
        ),
      );
    }

    if (_id.servings < 0) {
      variationList.add(Padding(
        padding: const EdgeInsets.fromLTRB(6, 6, 0, 6),
        child: Slider(
          value: _id.servings * -1,
          min: 1,
          max: 10,
          divisions: 9,
          activeColor: limelightGradient[1],
          inactiveColor: toLighterSurfaceGradient(limelightGradient)[0],
          label: (_id.servings * -1).round().toString(),
          onChanged: (double value) {
            setState(() => _id.servings = value.round().toInt() * (-1));
          },
        ),
      ));
    } else {
      variationList.add(
        FlatButton(
          onPressed: () => setState(() => _id.servings = _id.servings * -1),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(
                  18,
                ),
                child: GradientIcon(
                  icon: Icons.panorama_fish_eye,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: "Number of servings",
                  ),
                  CustomText(
                    text: "${_id.servings}",
                    opacity: 0.6,
                    size: 12,
                    weight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    for (var i = variationList.length - 1; i > 0; i--) {
      variationList.insert(
        i,
        const CustomDivider(indent: 10),
      );
    }

    return Dialog(
      backgroundColor: toSurfaceGradient(limelightGradient)[1],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: CustomText(
                text: "Variations",
                alignement: TextAlign.center,
                size: 20,
                weight: FontWeight.w600,
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: variationList,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _id.servings < 0
                  ? FlatButton(
                      onPressed: () {
                        setState(() => _id.servings = -_id.servings);
                        widget.onVariationChange(_id);
                      },
                      borderRadius: 10,
                      child: const CustomText(text: 'Confirm'),
                    )
                  : FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      borderRadius: 10,
                      child: const CustomText(text: 'Done'),
                    ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
