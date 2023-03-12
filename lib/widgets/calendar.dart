import 'package:flutter/material.dart';

import 'package:limelight/widgets/recipe.dart';
import 'package:limelight/gradients.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageController(
        initialPage: 2,
      ),
      scrollDirection: Axis.vertical,
      children: const [
        CalendarPage(),
        CalendarPage(),
        CalendarPage(),
        CalendarPage(),
      ],
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Day(day: 'M'),
        Day(day: 'T'),
        Day(day: 'W'),
        Day(day: 'T'),
        Day(day: 'F'),
        Day(day: 'S'),
        Day(day: 'S'),
      ],
    );
  }
}

class Day extends StatelessWidget {
  final String day;
  const Day({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(12),
                    right: Radius.zero,
                  ),
                  gradient: LinearGradient(
                    colors: leafyGreensGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(12),
                    left: Radius.zero,
                  ),
                  gradient: LinearGradient(
                    colors: meatGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
