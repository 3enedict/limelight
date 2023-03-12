import 'package:flutter/material.dart';

import 'package:limelight/widgets/recipe.dart';
import 'package:limelight/gradients.dart';

class Calendar extends StatelessWidget {
  final RecipeData recipe;
  const Calendar({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final DateTime time = DateTime.now();
    return ListView.builder(
      itemCount: 30 * 4,
      itemBuilder: (BuildContext context, int index) {
        final int date = time.add(Duration(hours: 24 * index)).day;
        return Day(day: "$date", recipe: recipe);
      },
    );
  }
}

class Day extends StatelessWidget {
  final String day;
  final RecipeData recipe;
  const Day({super.key, required this.day, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: toSurfaceGradient(limelightGradient),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Text(
            day,
            style: TextStyle(
              fontSize: 14 * MediaQuery.of(context).textScaleFactor * 1.5,
              color: Colors.white70,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Empty'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Empty'),
            ),
          ),
        ],
      ),
    );
  }
}
