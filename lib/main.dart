import 'package:flutter/material.dart';

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

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

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
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Color(0xFF00b09b),
                      Color(0xFF96c93d),
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: const Icon(
                  FontAwesome5.circle,
                ),
              ),
              label: 'Leafy greens',
            ),
            BottomNavigationBarItem(
              icon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Color(0xFFF37335),
                      Color(0xFFFDC830),
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: const Icon(
                  FontAwesome5.circle,
                ),
              ),
              label: 'Vegetables',
            ),
            BottomNavigationBarItem(
              icon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Color(0xFFFF416C),
                      Color(0xFFFF4B2B),
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: const Icon(
                  FontAwesome5.circle,
                ),
              ),
              label: 'Meat & Eggs',
            ),
            BottomNavigationBarItem(
              icon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Color(0xFF48b1bf),
                      Color(0xFF06beb6),
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: const Icon(
                  FontAwesome5.circle,
                ),
              ),
              label: 'Fish',
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
          child: const LeafyGreensPage(),
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

  const Ingredient({
    super.key,
    required this.name,
    required this.season,
    required this.price,
    required this.cheapness,
  });

  @override
  _IngredientState createState() => _IngredientState();
}

class _IngredientState extends State<Ingredient> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: _enabled
              ? [
                  const Color(0xFF00b09b),
                  const Color(0xFF96c93d),
                ]
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
                      : [
                          const Color(0xFF00b09b),
                          const Color(0xFF96c93d),
                        ],
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
  final List<Ingredient> ingredients;

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
                    color: Color(0x99384364),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Ingredient(
                  name: 'Lettuce',
                  season: 'Spring and fall',
                  price: '\$1.00 per head',
                  cheapness: 'Really cheap',
                ),
                const Ingredient(
                  name: 'Kale',
                  season: 'Fall and winter',
                  price: '\$2.00 per lb',
                  cheapness: 'Cheap',
                ),
                const Ingredient(
                  name: 'Arugula',
                  season: 'Late spring and early fall',
                  price: '\$10.00 per lb',
                  cheapness: 'Expensive',
                ),
                const Ingredient(
                  name: 'Arugula',
                  season: 'Late spring and early fall',
                  price: '\$10.00 per lb',
                  cheapness: 'Expensive',
                ),
                const Ingredient(
                  name: 'Arugula',
                  season: 'Late spring and early fall',
                  price: '\$10.00 per lb',
                  cheapness: 'Expensive',
                ),
                const Ingredient(
                  name: 'Arugula',
                  season: 'Late spring and early fall',
                  price: '\$10.00 per lb',
                  cheapness: 'Expensive',
                ),
                const Ingredient(
                  name: 'Arugula',
                  season: 'Late spring and early fall',
                  price: '\$10.00 per lb',
                  cheapness: 'Expensive',
                ),
                Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height - 100 - 80,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LeafyGreensPage extends StatelessWidget {
  const LeafyGreensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const IngredientsPageLayout(
      title: 'Leafy greens',
      titleBackground: AssetImage('assets/Leafy Greeens.jpg'),
      ingredients: [
        Ingredient(
          name: 'Lettuce',
          season: 'Spring and fall',
          price: '\$1.00 per head',
          cheapness: 'Really cheap',
        ),
        Ingredient(
          name: 'Kale',
          season: 'Fall and winter',
          price: '\$2.00 per lb',
          cheapness: 'Cheap',
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
        ),
      ],
    );
  }
}
