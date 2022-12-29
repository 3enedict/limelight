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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black87,
            Colors.grey[900]!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Ingredients",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[50],
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
          onPressed: () {},
          child: const Icon(Icons.search),
        ),
      ),
    );
  }
}
