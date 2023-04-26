import 'package:flutter/material.dart';

import 'package:fluttericon/font_awesome5_icons.dart';

import 'package:limelight/pages/ingredients_search_page.dart';
import 'package:limelight/pages/ingredients_subpages/leafy_greens_page.dart';
import 'package:limelight/pages/ingredients_subpages/vegetables_page.dart';
import 'package:limelight/pages/ingredients_subpages/meat_page.dart';
import 'package:limelight/pages/ingredients_subpages/fish_page.dart';
import 'package:limelight/widgets/fab.dart';
import 'package:limelight/gradients.dart';

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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toBackgroundGradient(_gradients[_currentIndex]),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: Hero(
          tag: 'IngredientsPage hero',
          child: CustomFloatingActionButton(
            gradient: _gradients[_currentIndex],
            icon: const Icon(Icons.search),
            onPressed: () => _gotoDetailsPage(context),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
    );
  }

  void _gotoDetailsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => const IngredientsSearchPage(),
    ));
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
