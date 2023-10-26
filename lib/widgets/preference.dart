import 'package:flutter/material.dart';

import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/widgets/flat_button.dart';
import 'package:limelight/gradients.dart';

class Preference extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? selected;
  final List<String> values;
  final void Function(String) onChanged;

  const Preference({
    super.key,
    required this.icon,
    required this.text,
    this.selected,
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    String value = values[0];
    if (selected != null) value = selected!;

    return FlatButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: toSurfaceGradient(limelightGradient)[0],
          elevation: 0,
          title: CustomText(text: text),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: values.length,
              itemBuilder: (BuildContext context, int index) {
                return FlatButton(
                  onPressed: () {
                    onChanged(values[index]);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      GradientIcon(
                        gradient: values[index] == value
                            ? limelightGradient
                            : [Colors.transparent, Colors.transparent],
                        padding: const EdgeInsets.fromLTRB(0, 10, 14, 10),
                        icon: Icons.panorama_fish_eye,
                        size: 20,
                      ),
                      CustomText(text: values[index]),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: GradientIcon(icon: icon),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: text),
              CustomText(
                text: value,
                opacity: 0.6,
                size: 12,
                weight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
