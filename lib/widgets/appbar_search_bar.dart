import 'package:flutter/material.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/gradients.dart';

class AppbarSearchBar extends StatefulWidget {
  TextEditingController controller;
  final String searchHint;
  final void Function(String) onChanged;
  final VoidCallback onSubmitted;

  AppbarSearchBar({
    super.key,
    required this.controller,
    required this.searchHint,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  State<AppbarSearchBar> createState() => _AppbarSearchBarState();
}

class _AppbarSearchBarState extends State<AppbarSearchBar> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GradientContainer(
        gradient: toLighterSurfaceGradient(limelightGradient),
        borderRadius: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              GradientIcon(
                gradient: toTextGradient(limelightGradient)
                    .map((e) => e.withOpacity(0.6))
                    .toList(),
                padding: const EdgeInsets.fromLTRB(15, 0, 13, 0),
                size: 19,
                icon: FeatherIcons.search,
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: widget.controller,
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration.collapsed(
                    hintText: widget.searchHint,
                    hintStyle: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        color: textColor().withOpacity(0.8),
                      ),
                    ),
                  ),
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(color: textColor()),
                  ),
                  onChanged: (query) => setState(() {
                    _query = query;
                    widget.onChanged(query);
                  }),
                  onEditingComplete: _query == ''
                      ? null
                      : () {
                          widget.onSubmitted();
                          clear();
                        },
                  onSubmitted:
                      _query == '' ? (_) => Navigator.of(context).pop() : null,
                ),
              ),
              _query != ''
                  ? GradientIcon(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      gradient: toTextGradient(limelightGradient)
                          .map((e) => e.withOpacity(0.6))
                          .toList(),
                      onPressed: () => clear(),
                      buttonPadding: 0,
                      size: 19,
                      icon: FeatherIcons.x,
                    )
                  : const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }

  void clear() {
    setState(() => _query = '');
    widget.onChanged('');
    widget.controller.clear();
  }
}
