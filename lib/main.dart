import 'package:flutter/material.dart';

import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
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
            Color(0xFF333333),
            Color(0xFF111111),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const LeafyGreensPage(),
    );
  }
}

class LeafyGreensPage extends StatelessWidget {
  const LeafyGreensPage({super.key});

  @override
  Widget build(BuildContext context) {
    var leafyGreens = [
      'Salad',
      'Kale',
      'Microgreens',
      'Cabbage',
      'Colard greens',
      'Spinach',
      'Bok choy',
      'Endive',
      'Salad',
      'Kale',
      'Microgreens',
      'Cabbage',
      'Colard greens',
      'Spinach',
      'Bok choy',
      'Endive',
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.white70,
        unselectedItemColor: Colors.white30,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesome5.leaf),
            label: 'Leafy greens',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesome5.carrot),
            label: 'Vegetables',
          ),
          BottomNavigationBarItem(
            icon: Icon(RpgAwesome.meat),
            label: 'Meats & Eggs',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesome5.fish),
            label: 'Fish',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white24,
        onPressed: () {},
        child: const Icon(Icons.search),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 200.0,
                backgroundColor: const Color(0xFF222222),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'Leafy greens',
                    style: GoogleFonts.workSans(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(0),
                        bottom: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ),
                        image: AssetImage('assets/Leafy Greeens.jpg'),
                      ),
                    ),
                    child: Container(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  leafyGreens
                      .map(
                        (name) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF444444),
                                Color(0xFF333333),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          padding: const EdgeInsets.all(25),
                          child: Text(
                            name,
                            style: GoogleFonts.workSans(
                              textStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF111111),
                    Color(0x00111111),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
