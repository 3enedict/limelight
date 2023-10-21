import 'package:flutter/material.dart';
import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/gradient_icon.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/widgets/gradient_appbar.dart';
import 'package:limelight/widgets/custom_divider.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/widgets/preference.dart';
import 'package:limelight/widgets/section.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      appBar: const GradientAppBar(
        text: CustomText(
          text: "Ingredients to buy",
          alignement: TextAlign.center,
          size: 22,
          weight: FontWeight.w700,
        ),
      ),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: GradientContainer(
              borderRadius: 20,
              gradient: toSurfaceGradient(limelightGradient),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child:
                        GradientIcon(icon: Icons.panorama_fish_eye, size: 20),
                  ),
                  CustomText(text: "Name"),
                  const Expanded(child: SizedBox()),
                  CustomText(
                    text: 'Quantity',
                    opacity: 0.6,
                    weight: FontWeight.w400,
                  ),
                  const SizedBox(width: 16)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
