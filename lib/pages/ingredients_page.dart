import 'package:flutter/material.dart';

import 'package:fluttericon/font_awesome5_icons.dart';

import 'package:limelight/pages/ingredients_search_page.dart';
import 'package:limelight/pages/ingredients_subpages/leafy_greens_page.dart';
import 'package:limelight/pages/ingredients_subpages/vegetables_page.dart';
import 'package:limelight/pages/ingredients_subpages/meat_page.dart';
import 'package:limelight/pages/ingredients_subpages/fish_page.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/transitions.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  IngredientsPageState createState() => IngredientsPageState();
}

class IngredientsPageState extends State<IngredientsPage> {
  int _currentIndex = 0;
  final _screens = [
    const LeafyGreensPage(),
    const VegetablesPage(),
    const MeatsPage(),
    const FishPage(),
  ];

  final _gradients = [
    leafyGreensGradient,
    vegetablesGradient,
    meatGradient,
    fishGradient,
  ];

  @override
  Widget build(BuildContext context) {
    final List<Color> gradient = _gradients[_currentIndex];

    return EmptyPage(
      gradient: gradient,
      fab: GradientButton(
        diameter: 56,
        gradient: toSurfaceGradient(gradient),
        onPressed: () => fadeTransition(context, const SearchPage()),
        padding: const EdgeInsets.all(0),
        child: const Center(
          child: Icon(
            Icons.search,
            color: Colors.white70,
          ),
        ),
      ),
      bottomNavBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          bottomNavBarItem(leafyGreensGradient),
          bottomNavBarItem(vegetablesGradient),
          bottomNavBarItem(meatGradient),
          bottomNavBarItem(fishGradient),
        ],
      ),
      child: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
    );
  }
}

BottomNavigationBarItem bottomNavBarItem(List<Color> gradient) {
  return BottomNavigationBarItem(
    icon: ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(colors: gradient).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: const Icon(
        FontAwesome5.circle,
      ),
    ),
    label: '',
    backgroundColor: Colors.transparent,
  );
}
