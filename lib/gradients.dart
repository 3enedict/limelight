import 'package:flutter/material.dart';

const oldlimelightGradient = [
  Color(0xFF41cdc9),
  Color(0xFF3aaada),
];

const newlimelightGradient = [
  Color(0xFF00d2ff),
  Color(0xFF3a7bd5),
];

const limelightGradient = [
  Color(0xFF24C6DC),
  Color(0xFF514A9D),
];

const oldredGradient = [
  Color(0xFFFF4B2B),
  Color(0xFFFF416C),
];

const redGradient = [
  Color(0xFFFF512F),
  Color(0xFFDD2476),
];

const greenGradient = [
  Color(0xFF38ef7d),
  Color(0xFF11998e),
];

List<Color> toBackgroundGradient(List<Color> gradient) {
  return List.generate(
    2,
    (int index) => modifyColor(gradient[index], 0.10, 0.1),
  );
}

List<Color> toSurfaceGradient(List<Color> gradient) {
  return List.generate(
    2,
    (int index) => modifyColor(gradient[index], 0.13, 0.1),
  );
}

List<Color> toLighterSurfaceGradient(List<Color> gradient) {
  return List.generate(
    2,
    (int index) => modifyColor(gradient[index], 0.2, 0.08),
  );
}

List<Color> toTextGradient(List<Color> gradient) {
  return List.generate(
    2,
    (int index) => modifyColor(gradient[index], 0.85, 0.1),
  );
}

Color textColor() {
  return toTextGradient(limelightGradient)[1];
}

Color modifyColor(Color color, double value, double saturation) {
  var hsvColor = HSVColor.fromColor(color);
  hsvColor = hsvColor.withValue(value);
  hsvColor = hsvColor.withSaturation(saturation);

  return hsvColor.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
