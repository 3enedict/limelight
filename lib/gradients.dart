import 'package:flutter/material.dart';

const limelightGradient = [
  Color(0xFF41cdc9),
  Color(0xFF3aaada),
];

const leafyGreensGradient = [
  Color(0xFF38ba78),
  Color(0xFF76c350),
];

const vegetablesGradient = [
  Color(0xFFF2C94C),
  Color(0xFFF2994A),
];

const meatGradient = [
  Color(0xFFFF4B2B),
  Color(0xFFFF416C),
];

const fishGradient = [
  Color(0xFF96DEDA),
  Color(0xFF50C9C3),
];

List<Color> toBackgroundGradient(List<Color> gradient) {
  return [
    toBackgroundColor(gradient[0], 0.15, 0.2),
    toBackgroundColor(gradient[1], 0.10, 0.2),
  ];
}

List<Color> toBackgroundGradientWithReducedColorChange(List<Color> gradient) {
  return [
    toBackgroundColor(gradient[0], 0.135, 0.2),
    toBackgroundColor(gradient[1], 0.11, 0.2),
  ];
}

List<Color> toSurfaceGradient(List<Color> gradient) {
  return [
    toBackgroundColor(gradient[0], 0.22, 0.2),
    toBackgroundColor(gradient[1], 0.18, 0.2),
  ];
}

List<Color> toSurfaceGradientWithReducedColorChange(List<Color> gradient) {
  return [
    toBackgroundColor(gradient[0], 0.215, 0.2),
    toBackgroundColor(gradient[1], 0.20, 0.2),
  ];
}

Color toBackgroundColor(Color color, double value, double saturation) {
  var hsvColor = HSVColor.fromColor(color);
  hsvColor = hsvColor.withValue(value);
  hsvColor = hsvColor.withSaturation(saturation);

  return hsvColor.toColor();
}
