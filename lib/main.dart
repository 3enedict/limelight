import 'package:flutter/material.dart';
import 'dart:ui';

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
            Color(0xFF111111),
            Color(0xFF333333),
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
              label: 'Meat & Eggs',
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
        body: const LeafyGreensPage(),
      ),
    );
  }
}

class LeafyGreensPage extends StatelessWidget {
  const LeafyGreensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.grey,
                BlendMode.saturation,
              ),
              image: AssetImage('assets/Basil.jpg'),
            ),
          ),
          child: Text(
            '\nLeafy greens',
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        ListView(
          children: [
            Container(
              height: 250,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                  bottom: Radius.circular(0),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF111111),
                    Color(0xFF333333),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: const [
                  LeafyGreens(),
                  LeafyGreens(),
                  LeafyGreens(),
                  LeafyGreens(),
                  LeafyGreens(),
                  LeafyGreens(),
                  LeafyGreens(),
                  LeafyGreens(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LeafyGreens extends StatelessWidget {
  const LeafyGreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      height: 200,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(20),
              color: Colors.black87,
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(20),
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
