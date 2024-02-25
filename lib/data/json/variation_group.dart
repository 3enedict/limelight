import 'package:limelight/data/json/variation.dart';

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

  Variation variation(int id) {
    return variations.elementAtOrNull(id) ?? Variation.empty();
  }

  List<String> get names {
    List<String> names = [];
    for (var variation in variations) {
      names.add(variation.name);
    }

    return names;
  }

  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
      'variations': variations.map((data) => data.toJson()).toList(),
    };
  }
}
