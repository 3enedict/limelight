import 'package:flutter/material.dart';

const limelightGradient = [
  Color(0xFF41cdc9),
  Color(0xFF3aaada),
];

List<Color> toBackgroundGradient(List<Color> gradient) {
  return [
    modifyColor(gradient[0], 0.10, 0.1),
    modifyColor(gradient[1], 0.10, 0.1),
  ];
}

List<Color> toSurfaceGradient(List<Color> gradient) {
  return [
    modifyColor(gradient[0], 0.16, 0.1),
    modifyColor(gradient[1], 0.16, 0.1),
  ];
}

List<Color> toTextGradient(List<Color> gradient) {
  return [
    modifyColor(gradient[0], 0.8, 0.1),
    modifyColor(gradient[1], 0.8, 0.1),
  ];
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
