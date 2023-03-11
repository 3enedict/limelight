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
      children: [
        Expanded(
          child: Row(
            children: [
              const Text(
                'Mon',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.tealAccent,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              const Text(
                'Mon',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.tealAccent,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              const Text(
                'Mon',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.tealAccent,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              const Text(
                'Mon',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.tealAccent,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
