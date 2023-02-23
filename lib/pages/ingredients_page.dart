import 'package:flutter/material.dart';

import 'package:fluttericon/font_awesome5_icons.dart';

import 'package:limelight/pages/ingredients_subpages/leafy_greens_page.dart';
import 'package:limelight/pages/ingredients_subpages/vegetables_page.dart';
import 'package:limelight/pages/ingredients_subpages/meat_page.dart';
import 'package:limelight/pages/ingredients_subpages/fish_page.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  IngredientsPageState createState() => IngredientsPageState();
}

class IngredientsPageState extends State<IngredientsPage> {
  int _currentIndex = 1;
  final _screens = [
    const LeafyGreensPage(),
    const VegetablesPage(),
    const MeatsPage(),
    const FishPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF3e486c),
            Color(0xFF25304e),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: [
            bottomNavBarItem(
              [const Color(0xFF96c93d), const Color(0xFF00b09b)],
            ),
            bottomNavBarItem(
              [const Color(0xFFF2C94C), const Color(0xFFF2994A)],
            ),
            bottomNavBarItem(
              [const Color(0xFFFF4B2B), const Color(0xFFFF416C)],
            ),
            bottomNavBarItem(
              [const Color(0xFF00d2ff), const Color(0xFF3a7bd5)],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white24,
          onPressed: () {},
          child: const Icon(Icons.search),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
    );
  }
}

BottomNavigationBarItem bottomNavBarItem(List<Color> gradient) {
  return BottomNavigationBarItem(
    icon: ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradient,
        ).createShader(bounds);
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
