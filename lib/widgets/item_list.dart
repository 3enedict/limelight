import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/page.dart';

class ItemList extends StatelessWidget {
  final String title;
  final AssetImage titleBackground;
  final Widget items;
  final List<Color> gradient;
  final double padding;
  final int keyValue;

  const ItemList({
    super.key,
    required this.title,
    required this.titleBackground,
    required this.items,
    required this.gradient,
    this.padding = 135,
    this.keyValue = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Fade(
      gradient: gradient,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          key: PageStorageKey(keyValue),
          slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              snap: false,
              floating: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              backgroundColor: toBackgroundGradient(gradient)[0],
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
                      bottom: Radius.circular(25),
                    ),
                    image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                      ),
                      image: titleBackground,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(0),
                        bottom: Radius.circular(20),
                      ),
                      color: toBackgroundGradient(gradient)[0].withAlpha(40),
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
      ),
    );
  }
}
