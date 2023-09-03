import 'package:flutter/material.dart';
import 'package:limelight/gradients.dart';

import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/page.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: 'Saturday',
                  alignement: TextAlign.center,
                  size: 20,
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    GradientIcon(
                      gradient: toTextGradient(limelightGradient),
                      padding: const EdgeInsets.all(15),
                      icon: Icons.chevron_left,
                    ),
                    Expanded(
                      child: Column(
                        children: List.generate(
                          2,
                          (_) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: GradientContainer(
                              gradient: toSurfaceGradient(limelightGradient),
                              borderRadius: 20,
                              child: const Row(
                                children: [
                                  GradientIcon(
                                    padding: EdgeInsets.all(15),
                                    icon: Icons.panorama_fish_eye,
                                  ),
                                  CustomText(text: 'Recipe unavailable'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GradientIcon(
                      gradient: toTextGradient(limelightGradient),
                      padding: const EdgeInsets.all(15),
                      icon: Icons.chevron_right,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  60,
                  (int index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GradientContainer(
                      gradient: toSurfaceGradient(limelightGradient),
                      borderRadius: 15,
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(text: 'Mon'),
                            SizedBox(height: 5),
                            CustomText(text: '27')
                          ],
                        ),
                      ),
                    ),
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
