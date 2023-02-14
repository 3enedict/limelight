import 'package:flutter/material.dart';
import 'dart:math';

import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Paint.enableDithering = true;
  runApp(const Limelight());
}

class Limelight extends StatelessWidget {
  const Limelight({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Limelight',
      home: IngredientsPage(),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF384364),
            Color(0xFF292f4d),
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
            BottomNavigationBarItem(
              icon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Color(0xFF96c93d),
                      Color(0xFF00b09b),
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: const Icon(
                  FontAwesome5.circle,
                ),
              ),
              label: '',
              backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Color(0xFFF2C94C),
                      Color(0xFFF2994A),
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: const Icon(
                  FontAwesome5.circle,
                ),
              ),
              label: '',
              backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Color(0xFFFF4B2B),
                      Color(0xFFFF416C),
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: const Icon(
                  FontAwesome5.circle,
                ),
              ),
              label: '',
              backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Color(0xFF00d2ff),
                      Color(0xFF3a7bd5),
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: const Icon(
                  FontAwesome5.circle,
                ),
              ),
              label: '',
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white24,
          onPressed: () {},
          child: const Icon(Icons.search),
        ),
        body: ShaderMask(
          shaderCallback: (bound) {
            return const LinearGradient(
                end: FractionalOffset.topCenter,
                begin: FractionalOffset.bottomCenter,
                colors: [
                  Color(0xFF292f4d),
                  Color(0x00292f4d),
                ],
                stops: [
                  0.0,
                  0.3,
                ]).createShader(bound);
          },
          blendMode: BlendMode.srcOver,
          child: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
        ),
      ),
    );
  }
}

class Ingredient extends StatefulWidget {
  final String name;
  final String season;
  final String price;
  final String cheapness;
  final List<Color> gradient;

  const Ingredient({
    super.key,
    required this.name,
    required this.season,
    required this.price,
    required this.cheapness,
    required this.gradient,
  });

  @override
  IngredientState createState() => IngredientState();
}

class IngredientState extends State<Ingredient> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: _enabled
              ? widget.gradient
              : [
                  const Color(0xFF525d7d),
                  const Color(0xFF343e61),
                ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () => setState(() => _enabled = !_enabled),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: _enabled
                      ? [
                          const Color(0xBBFFFFFF),
                          const Color(0xBBFFFFFF),
                        ]
                      : widget.gradient,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              margin: const EdgeInsets.fromLTRB(5, 20, 20, 20),
              height: 25,
              width: 25,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: GoogleFonts.workSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEEEEEE),
                        ),
                      ),
                    ),
                    Text(
                      widget.season,
                      style: GoogleFonts.workSans(
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFDDDDDD),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.price,
                  style: GoogleFonts.workSans(
                    textStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color(0xFFEEEEEE),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  widget.cheapness,
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize:
                          14 * MediaQuery.of(context).textScaleFactor * 0.8,
                      color: const Color(0xFFDDDDDD),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IngredientsPageLayout extends StatelessWidget {
  final String title;
  final AssetImage titleBackground;
  final List<Widget> ingredients;

  const IngredientsPageLayout({
    super.key,
    required this.title,
    required this.titleBackground,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            backgroundColor: const Color(0xFF384364),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                title,
                style: GoogleFonts.workSans(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(0),
                    bottom: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.saturation,
                    ),
                    image: titleBackground,
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(0),
                      bottom: Radius.circular(20),
                    ),
                    color: Color(0x44384364),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.from(ingredients)
                ..add(
                  Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height - 100 - 80,
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}

class LeafyGreensPage extends StatelessWidget {
  const LeafyGreensPage({super.key});

  final List<Color> _gradient = const [
    Color(0xFF96c93d),
    Color(0xFF00b09b),
  ];

  @override
  Widget build(BuildContext context) {
    return IngredientsPageLayout(
      title: 'Leafy greens',
      titleBackground: const AssetImage('assets/Leafy Greeens.jpg'),
      ingredients: [
        Ingredient(
          name: 'Lettuce',
          season: 'Spring and fall',
          price: '\$1.00 per head',
          cheapness: 'Really cheap',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Kale',
          season: 'Fall and winter',
          price: '\$2.00 per lb',
          cheapness: 'Cheap',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
      ],
    );
  }
}

class VegetablesPage extends StatelessWidget {
  const VegetablesPage({super.key});

  final _gradient = const [
    Color(0xFFF2C94C),
    Color(0xFFF2994A),
  ];

  @override
  Widget build(BuildContext context) {
    return IngredientsPageLayout(
      title: 'Vegetables',
      titleBackground: const AssetImage('assets/Vegetables.webp'),
      ingredients: [
        Ingredient(
          name: 'Lettuce',
          season: 'Spring and fall',
          price: '\$1.00 per head',
          cheapness: 'Really cheap',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Kale',
          season: 'Fall and winter',
          price: '\$2.00 per lb',
          cheapness: 'Cheap',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
      ],
    );
  }
}

class MeatsPage extends StatelessWidget {
  const MeatsPage({super.key});

  final _gradient = const [
    Color(0xFFFF4B2B),
    Color(0xFFFF416C),
  ];

  @override
  Widget build(BuildContext context) {
    return IngredientsPageLayout(
      title: 'Meat & Eggs',
      titleBackground: const AssetImage('assets/Meat.jpg'),
      ingredients: [
        Ingredient(
          name: 'Lettuce',
          season: 'Spring and fall',
          price: '\$1.00 per head',
          cheapness: 'Really cheap',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Kale',
          season: 'Fall and winter',
          price: '\$2.00 per lb',
          cheapness: 'Cheap',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
      ],
    );
  }
}

class FishPage extends StatelessWidget {
  const FishPage({super.key});

  final _gradient = const [
    Color(0xFF00d2ff),
    Color(0xFF3a7bd5),
  ];

  @override
  Widget build(BuildContext context) {
    return IngredientsPageLayout(
      title: 'Fish & Dairy',
      titleBackground: const AssetImage('assets/Fish.jpg'),
      ingredients: [
        Ingredient(
          name: 'Lettuce',
          season: 'Spring and fall',
          price: '\$1.00 per head',
          cheapness: 'Really cheap',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Kale',
          season: 'Fall and winter',
          price: '\$2.00 per lb',
          cheapness: 'Cheap',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
      ],
    );
  }
}
