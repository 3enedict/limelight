import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class IngredientsSearchPage extends StatelessWidget {
  const IngredientsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        floatingActionButton: FloatingActionButton(
          heroTag: 'IngredientsSearchFAB',
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.add),
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
              Center(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ingredient',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
