import 'package:limelight/data/variation.dart';

class VariationGroup {
  final String groupName;
  final List<Variation> variations;

  const VariationGroup({
    required this.groupName,
    required this.variations,
  });

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
}
