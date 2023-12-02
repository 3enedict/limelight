import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';

import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/widgets/circles.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyPage(
      child: Circles(
        child: SearchBar(),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: GradientButton(
          gradient: toSurfaceGradient(limelightGradient),
          borderRadius: 100,
          /*
          onPressed: () => goto(
            context,
            SearchPage(
              searchHint: 'Select ingredients to cook with',
              getSelected: (newModel) => newModel.selected,
              selectIngredient: (name) => model.select(name),
            ),
          ),
          */
          onPressed: () {},
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
          /*
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddToShoppingListPage(),
            ),
          ),
          */
          onPressed: () {},
          size: size,
          icon: UniconsLine.notes,
        ),
        GradientIcon(
          //onPressed: () => goto(context, const CookbookPage()),
          onPressed: () {},
          size: size,
          icon: UniconsLine.fire,
        ),
      ],
    );
  }
}
