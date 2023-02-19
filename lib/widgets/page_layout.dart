import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class DefaultPageLayout extends StatelessWidget {
  final String title;
  final AssetImage titleBackground;
  final Widget items;
  final double padding;

  const DefaultPageLayout({
    super.key,
    required this.title,
    required this.titleBackground,
    required this.items,
    this.padding = 180,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            backgroundColor: const Color(0xFF384364),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                title,
                style: GoogleFonts.workSans(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(0),
                    bottom: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.saturation,
                    ),
                    image: titleBackground,
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(0),
                      bottom: Radius.circular(20),
                    ),
                    color: Color(0x44384364),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              0,
              0,
              0,
              MediaQuery.of(context).size.height - padding,
            ),
            sliver: items,
          ),
        ],
      ),
    );
  }
}
