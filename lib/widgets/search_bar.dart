import 'package:flutter/material.dart';

import 'package:limelight/widgets/items/item.dart';

class SearchBar extends StatefulWidget {
  final String title;
  final String subTitle;
  final String info;
  final String subInfo;
  final List<Color> accentGradient;
  final List<Color> backgroundGradient;

  const SearchBar({
    super.key,
    required this.title,
    required this.subTitle,
    required this.info,
    required this.subInfo,
    required this.accentGradient,
    required this.backgroundGradient,
  });

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar>
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
          ? const [Color(0xBBFFFFFF), Color(0xBBFFFFFF)]
          : widget.accentGradient,
      backgroundGradient:
          _enabled ? widget.accentGradient : widget.backgroundGradient,
      onPressed: () => setState(() => _enabled = !_enabled),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
