import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient_button.dart';

const double itemExtent = 70 + 15;

class Item extends StatelessWidget {
  final String? title;
  final bool boldTitle;
  final String? subTitle;
  final String? info;
  final String? subInfo;
  final Widget? leading;
  final double? height;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final List<Color>? accentGradient;
  final List<Color>? backgroundGradient;
  final Color textColor;
  final Color subTextColor;

  const Item({
    super.key,
    this.title,
    this.boldTitle = true,
    this.subTitle,
    this.info,
    this.subInfo,
    this.leading,
    this.height,
    this.onPressed,
    this.onLongPress,
    this.accentGradient = limelightGradient,
    this.backgroundGradient,
    this.textColor = const Color(0xFFEEEEEE),
    this.subTextColor = const Color(0xFFDDDDDD),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
      child: GradientButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        gradient: backgroundGradient ?? toSurfaceGradient(limelightGradient),
        height: height,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height == null ? 18 : 0),
          child: Row(
            children: [
              _generateLeading(),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _generateTitleWidget(context),
                ),
              ),
              _generateInfoWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _generateTitleWidget(BuildContext context) {
    if (title != null) {
      Text titleText = Text(
        title!,
        textAlign: TextAlign.justify,
        style: GoogleFonts.workSans(
          textStyle: TextStyle(
            color: textColor,
            fontWeight: boldTitle ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );

      if (subTitle == null) {
        return titleText;
      } else {
        Text subTitleText = Text(
          subTitle!,
          style: GoogleFonts.workSans(
            textStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14 * MediaQuery.of(context).textScaleFactor * 0.8,
              color: subTextColor,
            ),
          ),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleText,
            const SizedBox(height: 2),
            subTitleText,
          ],
        );
      }
    }

    return const SizedBox(height: 20);
  }

  Widget _generateInfoWidget(BuildContext context) {
    if (info != null) {
      Text infoText = Text(
        info!,
        style: GoogleFonts.workSans(
          textStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 14 * MediaQuery.of(context).textScaleFactor * 0.85,
            color: textColor,
          ),
        ),
      );

      if (subInfo == null) {
        return infoText;
      } else {
        Text subinfoText = Text(
          subInfo!,
          style: GoogleFonts.workSans(
            textStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14 * MediaQuery.of(context).textScaleFactor * 0.6,
              color: subTextColor,
            ),
          ),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            infoText,
            const SizedBox(height: 1),
            subinfoText,
          ],
        );
      }
    }

    return const SizedBox();
  }

  Widget _generateLeading() {
    return leading ??
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: accentGradient ?? limelightGradient,
            ),
          ),
          margin: const EdgeInsets.only(right: 20),
          height: 24,
          width: 24,
        );
  }
}
