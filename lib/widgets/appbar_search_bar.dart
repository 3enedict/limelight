import 'package:flutter/material.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/utils/gradient_container.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/gradients.dart';

class AppbarSearchBar extends StatefulWidget {
  TextEditingController controller;
  final String searchHint;
  final void Function(String) onChanged;
  final VoidCallback onSubmitted;
  final FocusNode? node;
  final VoidCallback? popContext;

  AppbarSearchBar({
    super.key,
    required this.controller,
    required this.searchHint,
    required this.onChanged,
    required this.onSubmitted,
    this.node,
    this.popContext,
  });

  @override
  State<AppbarSearchBar> createState() => _AppbarSearchBarState();
}

class _AppbarSearchBarState extends State<AppbarSearchBar> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    if (widget.controller.value.toString() == '') _query = '';

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
                padding: const EdgeInsets.fromLTRB(14, 0, 12, 0),
                size: 18,
                icon: FeatherIcons.search,
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  focusNode: widget.node,
                  controller: widget.controller,
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration.collapsed(
                    hintText: widget.searchHint,
                    hintStyle: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        color: textColor().withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(color: textColor()),
                    fontSize: 14,
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
                  onSubmitted: _query == ''
                      ? (_) {
                          if (widget.popContext != null) widget.popContext!();
                          Navigator.of(context).pop();
                        }
                      : null,
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
                      size: 18,
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
