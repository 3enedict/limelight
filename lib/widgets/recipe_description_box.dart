import 'package:flutter/material.dart';

import 'package:limelight/widgets/custom_text.dart';

import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/flat_button.dart';
import 'package:limelight/widgets/fade.dart';
import 'package:limelight/gradients.dart';

class RecipeDescriptionBox extends StatelessWidget {
  final String label;
  final List<Widget> items;

  const RecipeDescriptionBox({
    super.key,
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: toSurfaceGradient(limelightGradient)[0],
          elevation: 0,
          title: CustomText(text: label),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: items,
            ),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(text: " $label", opacity: 0.5, weight: FontWeight.w300),
          const SizedBox(height: 7),
          Flexible(
            child: GradientContainer(
              gradient: toSurfaceGradient(limelightGradient),
              borderRadius: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Fade(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Wrap(children: items),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
