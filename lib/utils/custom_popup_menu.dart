import 'package:flutter/material.dart';

RelativeRect buttonMenuPosition(BuildContext context) {
  // Get the render box from the context
  final RenderBox renderBox = context.findRenderObject() as RenderBox;

  // Get the global position, from the widget local position
  final offset = renderBox.localToGlobal(Offset.zero);

  // Calculate the start point, in this case, below the button
  final left = offset.dx;
  final top = offset.dy + renderBox.size.height + 10;
  final right = left + renderBox.size.width;

  // Return the RelativeRect
  return RelativeRect.fromLTRB(left, top, right, 0.0);
}

void showPopup(BuildContext context) {}
