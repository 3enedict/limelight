import 'package:flutter/material.dart';

import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = PersistentKeyboardHeight.of(context).keyboardHeight;
    const searchBarHeight = 70.0;

    return EmptyPage(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, height + 20),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: toSurfaceGradient(limelightGradient),
                  ),
                  borderRadius: BorderRadius.circular(searchBarHeight / 2),
                ),
                height: searchBarHeight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: TextField(
                    cursorColor: const Color(0xFFEEEEEE),
                    decoration: const InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Color(0xFFEEEEEE),
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                      // I havn't figured out how to forgo the manual (and annoying) way of centering the text
                      contentPadding: EdgeInsets.only(top: 19.5),
                    ),
                    expands: false,
                    style: GoogleFonts.workSans(
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Color(0xFFEEEEEE),
                      ),
                    ),
                  ),
                ),
              ),
            ),
           ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GradientIcon(
                gradient: toTextGradient(limelightGradient),
                icon: Icons.expand_less,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
