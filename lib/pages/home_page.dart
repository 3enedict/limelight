import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/pages/add_to_shopping_list_page.dart';
import 'package:limelight/pages/ingredient_search_page.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/pages/cookbook_page.dart';
import 'package:limelight/pages/calendar_page.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/widgets/circles.dart';
import 'package:limelight/utils/utils.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

class HomePage extends StatelessWidget {
  final PageController pageController;
  const HomePage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      child: Circles(
        child: Stack(
          children: [
            SearchBar(pageController: pageController),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GradientIcon(
                    onPressed: () => pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    ),
                    gradient: toTextGradient(limelightGradient)
                        .map((e) => e.withOpacity(0.5))
                        .toList(),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    icon: UniconsLine.setting,
                  ),
                  Consumer<PreferencesModel>(
                    builder: (context, prefs, child) {
                      return prefs.planner == 0
                          ? GradientIcon(
                              onPressed: () =>
                                  goto(context, const CalendarPage()),
                              gradient: toTextGradient(limelightGradient)
                                  .map((e) => e.withOpacity(0.5))
                                  .toList(),
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              icon: UniconsLine.calender,
                            )
                          : const SizedBox(height: 10);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final PageController pageController;
  const SearchBar({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    const size = 30.0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: GradientButton(
          gradient: toSurfaceGradient(limelightGradient),
          borderRadius: 100,
          onPressed: () => goto(
            context,
            IngredientSearchPage(pageController: pageController),
          ),
          ink: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              children: [
                const CustomText(
                  text: "Search...",
                  style: FontStyle.italic,
                  size: 22,
                ),
                const Expanded(child: SizedBox()),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: GradientIcon(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddToShoppingListPage(),
                          ),
                        ),
                        size: size,
                        icon: UniconsLine.notes,
                        buttonPadding: 22,
                      ),
                    ),
                    GradientIcon(
                      onPressed: () => goto(context, const CookbookPage()),
                      size: size,
                      gradient: redGradient,
                      icon: UniconsLine.fire,
                      buttonPadding: 22,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
