import 'package:flutter/material.dart';

import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/widgets/fade.dart';
import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/flat_button.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/recipe_description_items.dart';

class RecipeDescriptionBox extends StatelessWidget {
  final String label;
  final List<(double, Widget)> items;

  const RecipeDescriptionBox({
    super.key,
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(text: ' $label', opacity: 0.5, weight: FontWeight.w300),
        const SizedBox(height: 7),
        Flexible(
          child: GradientContainer(
            gradient: toSurfaceGradient(limelightGradient),
            borderRadius: 20,
            child: FlatButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          child: CustomText(
                            text: label,
                            alignement: TextAlign.center,
                            size: 20,
                            weight: FontWeight.w600,
                          ),
                        ),
                        Flexible(
                          child: ListView(
                            shrinkWrap: true,
                            children:
                                addDividers(items.map((e) => e.$2).toList()),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            borderRadius: 10,
                            child: const CustomText(text: 'Done'),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
              borderRadius: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    List<Widget> widgets = [];

                    double finalHeight = 0.0;
                    for (var (height, item) in items) {
                      finalHeight = finalHeight + height;
                      widgets.add(item);

                      if (finalHeight > constraints.maxHeight - 1) break;
                    }

                    return widgets.length == items.length
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: addDividers(widgets),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Fade(
                                  child: SingleChildScrollView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: addDividers(widgets),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 7),
                                child: CustomText(
                                  text: 'View more',
                                  decoration: TextDecoration.underline,
                                  opacity: 0.5,
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
