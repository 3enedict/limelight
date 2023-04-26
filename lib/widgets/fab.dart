import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final double diameter;
  final List<Color> gradient;
  final VoidCallback onPressed;
  final Icon icon;

  const CustomFloatingActionButton({
    super.key,
    this.diameter = 58,
    required this.gradient,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(diameter / 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: IconButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(diameter / 2),
          ),
        ),
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
