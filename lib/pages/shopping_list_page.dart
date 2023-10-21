import 'package:flutter/material.dart';

import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      appBarText: "Ingredients to buy",
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: GradientContainer(
              borderRadius: 20,
              gradient: toSurfaceGradient(limelightGradient),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child:
                        GradientIcon(icon: Icons.panorama_fish_eye, size: 20),
                  ),
                  CustomText(text: "Name"),
                  Expanded(child: SizedBox()),
                  CustomText(
                    text: 'Quantity',
                    opacity: 0.6,
                    weight: FontWeight.w400,
                  ),
                  SizedBox(width: 16)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
