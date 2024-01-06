import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';

import 'package:limelight/pages/add_to_shopping_list_page.dart';
import 'package:limelight/pages/ingredient_search_page.dart';
import 'package:limelight/utils/gradient_button.dart';
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
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: SearchBar(pageController: pageController),
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
          child: const Padding(
            padding: EdgeInsets.fromLTRB(30, 12, 18, 12),
            child: Row(
              children: [
                CustomText(
                  text: "Search...",
                  style: FontStyle.italic,
                  size: 24,
                ),
                Expanded(child: SizedBox()),
                SearchBarIcons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBarIcons extends StatelessWidget {
  const SearchBarIcons({super.key});

  @override
  Widget build(BuildContext context) {
    const size = 30.0;

    return Row(
      children: [
        GradientIcon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddToShoppingListPage(),
            ),
          ),
          size: size,
          icon: UniconsLine.notes,
        ),
        GradientIcon(
          //onPressed: () => goto(context, const CookbookPage()),
          onPressed: () {},
          size: size,
          gradient: redGradient,
          icon: UniconsLine.fire,
        ),
      ],
    );
  }
}
