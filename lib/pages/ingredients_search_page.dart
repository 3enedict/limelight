import 'package:flutter/material.dart';

import 'package:limelight/widgets/fab.dart';
import 'package:limelight/gradients.dart';

class IngredientsSearchPage extends StatelessWidget {
  const IngredientsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double searchBoxDiameter = 50;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toBackgroundGradient(limelightGradient),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: Container(
          margin: const EdgeInsets.fromLTRB(30 + 10, 0, 10, 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: toSurfaceGradient(limelightGradient),
            ),
            borderRadius: BorderRadius.circular(searchBoxDiameter),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 30),
              const Expanded(
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.grey,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Ingredient',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.all(6),
                child: CustomFloatingActionButton(
                  diameter: searchBoxDiameter - 5,
                  gradient: limelightGradient,
                  icon: const Icon(Icons.assignment),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
        body: ShaderMask(
          shaderCallback: (bound) {
            return LinearGradient(
                end: FractionalOffset.topCenter,
                begin: FractionalOffset.bottomCenter,
                colors: [
                  toBackgroundGradient(limelightGradient)[1],
                  toBackgroundGradient(limelightGradient)[1].withAlpha(0),
                ],
                stops: const [
                  0.0,
                  0.3,
                ]).createShader(bound);
          },
          blendMode: BlendMode.srcOver,
          child: Column(
            children: const [
              Text("halo"),
            ],
          ),
        ),
      ),
    );
  }
}
