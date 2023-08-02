import 'package:flutter/material.dart';

import 'package:limelight/widgets/item.dart';

class ButtonItem extends StatefulWidget {
  final String title;
  final String? subTitle;
  final String? info;
  final String? subInfo;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final List<Color>? accentGradient;
  final List<Color>? backgroundGradient;

  const ButtonItem({
    super.key,
    required this.title,
    this.subTitle,
    this.info,
    this.subInfo,
    this.onPressed,
    this.onLongPress,
    this.accentGradient,
    this.backgroundGradient,
  });

  @override
  ButtonItemState createState() => ButtonItemState();
}

class ButtonItemState extends State<ButtonItem>
    with AutomaticKeepAliveClientMixin {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Item(
      title: widget.title,
      subTitle: widget.subTitle,
      info: widget.info,
      subInfo: widget.subInfo,
      accentGradient: _enabled
          ? const [Color(0xFF222222), Color(0xFF222222)]
          : widget.accentGradient,
      backgroundGradient:
          _enabled ? widget.accentGradient : widget.backgroundGradient,
      textColor: _enabled ? const Color(0xFF111111) : const Color(0xFFEEEEEE),
      subTextColor:
          _enabled ? const Color(0xFF222222) : const Color(0xFFDDDDDD),
      onPressed: () {
        setState(() => _enabled = !_enabled);
        if (widget.onPressed != null) widget.onPressed!();
      },
      onLongPress: widget.onLongPress,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
