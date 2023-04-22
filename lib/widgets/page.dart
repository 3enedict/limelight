import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:nested_scroll_views/material.dart';

class DefaultPage extends StatelessWidget {
  final String title;
  final AssetImage titleBackground;
  final Widget items;
  final List<Color> backgroundGradient;
  final double padding;
  final int keyValue;

  const DefaultPage({
    super.key,
    required this.title,
    required this.titleBackground,
    required this.items,
    required this.backgroundGradient,
    this.padding = 135,
    this.keyValue = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bound) {
        return LinearGradient(
            end: FractionalOffset.topCenter,
            begin: FractionalOffset.bottomCenter,
            colors: [
              backgroundGradient[1],
              backgroundGradient[1].withAlpha(0),
            ],
            stops: const [
              0.0,
              0.3,
            ]).createShader(bound);
      },
      blendMode: BlendMode.srcOver,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: NestedCustomScrollView(
          key: PageStorageKey(keyValue),
          slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              snap: false,
              floating: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.25,
              backgroundColor: backgroundGradient[0],
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
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(0),
                        bottom: Radius.circular(20),
                      ),
                      color: backgroundGradient[0].withAlpha(40),
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
