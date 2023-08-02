import 'package:flutter/material.dart';

import 'package:limelight/data/json/variation.dart';
import 'package:limelight/widgets/item.dart';

class VariationGroup {
  final String groupName;
  final List<Variation> variations;

  const VariationGroup({
    required this.groupName,
    required this.variations,
  });

  VariationGroup.empty({
    this.groupName = '',
  }) : variations = [];

  factory VariationGroup.fromJson(Map<String, dynamic> data) {
    final groupName = data['groupName'] as String;

    final variationsData = data['variations'] as List<dynamic>?;
    final variations = variationsData != null
        ? variationsData
            .map((reviewData) => Variation.fromJson(reviewData))
            .toList()
        : <Variation>[];

    return VariationGroup(
      groupName: groupName,
      variations: variations,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
      'variations': variations,
    };
  }

  Item toItem(VoidCallback onPressed) {
    return Item(
      title: groupName,
      onPressed: onPressed,
    );
  }
}
