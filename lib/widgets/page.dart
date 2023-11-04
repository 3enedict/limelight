import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:limelight/widgets/gradient_appbar.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient_icon.dart';

class EmptyPage extends StatelessWidget {
  final List<Color> gradient;
  final PreferredSizeWidget? appBar;
  final String? appBarText;
  final Widget? fab;
  final bool resizeToAvoidBottomInset;
  final bool backButton;
  final Widget? child;

  const EmptyPage({
    super.key,
    this.gradient = limelightGradient,
    this.appBar,
    this.appBarText,
    this.fab,
    this.resizeToAvoidBottomInset = false,
    this.backButton = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toBackgroundGradient(gradient),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: appBar == null && appBarText == null
            ? EdgeInsets.only(top: MediaQuery.of(context).padding.top)
            : const EdgeInsets.all(0),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: appBarText == null
                ? appBar
                : backButton
                    ? GradientAppBar(
                        gradient: gradient,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // The Row is an ugly solution to Align not working how i want...
                            Row(
                              children: [
                                GradientIcon(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 6,
                                  ),
                                  gradient: toTextGradient(limelightGradient),
                                  onPressed: () => Navigator.of(context).pop(),
                                  size: 26,
                                  icon: Icons.chevron_left,
                                ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                            CustomText(
                              text: appBarText ?? '',
                              size: 20,
                              weight: FontWeight.w700,
                            ),
                          ],
                        ),
                      )
                    : GradientAppBar(
                        gradient: gradient,
                        text: CustomText(
                          text: appBarText ?? '',
                          alignement: TextAlign.center,
                          size: 20,
                          weight: FontWeight.w700,
                        ),
                      ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 6, 10),
              child: fab,
            ),
            body: child,
          ),
        ),
      ),
    );
  }
}
