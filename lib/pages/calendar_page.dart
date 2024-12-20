import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/widgets/variation_picker_dialog.dart';
import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/utils/gradient_container.dart';
import 'package:limelight/utils/custom_popup_menu.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/utils/flat_button.dart';
import 'package:limelight/data/recipe_id.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/languages.dart';

final date = DateTime.now();
final aMonthAgo = date.subtract(const Duration(days: 31));

class CalendarPage extends StatefulWidget {
  final RecipeId? recipe;

  const CalendarPage({super.key, this.recipe});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late PageController _pageController;
  late ScrollController _scrollController;
  int _pageId = 31;

  late RecipeId? _recipe;
  int _recipeBeingMoved = -1;

  bool _letPageControllerMoveView = true;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe;
    _pageController = PageController(initialPage: _pageId);
    _scrollController = ScrollController(
      initialScrollOffset: calculateScrollOffset(_pageId),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<RecipeModel>(context);

    return EmptyPage(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _letPageControllerMoveView
                      ? (int index) => setState(() {
                            _pageId = index;
                            _scrollController.animateTo(
                              calculateScrollOffset(index),
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear,
                            );
                          })
                      : (_) {},
                  children: List.generate(
                    61,
                    (int index) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: index == 31
                              ? words['today']![0]
                              : words[
                                  '${aMonthAgo.add(Duration(days: index)).weekday - 1}']![0],
                          alignement: TextAlign.center,
                          size: 20,
                          weight: FontWeight.w600,
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            GradientIcon(
                              gradient: toTextGradient(limelightGradient),
                              padding: const EdgeInsets.all(5),
                              onPressed: () => setState(() {
                                _pageId = _pageId - 1;
                                _pageController.animateToPage(
                                  _pageId,
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut,
                                );
                                _scrollController.animateTo(
                                  calculateScrollOffset(_pageId),
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut,
                                );
                              }),
                              icon: Icons.chevron_left,
                              size: 24,
                            ),
                            Expanded(
                              child: Column(
                                children: List.generate(
                                  2,
                                  (int meal) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Consumer<CalendarModel>(
                                      builder: (context, calendar, child) {
                                        final day = aMonthAgo
                                            .add(Duration(days: index));

                                        final id = calendar.get(
                                            day.year, day.month, day.day, meal);

                                        return GradientButton(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          gradient: toSurfaceGradient(
                                              limelightGradient),
                                          borderRadius: 20,
                                          onPressed: () {
                                            if (id == null || id != _recipe) {
                                              if (_recipe == null) {
                                                calendar.remove(day.year,
                                                    day.month, day.day, meal);
                                              } else {
                                                calendar.set(
                                                  day.year,
                                                  day.month,
                                                  day.day,
                                                  meal,
                                                  _recipe!,
                                                );
                                              }

                                              if (widget.recipe != _recipe) {
                                                final idDay = aMonthAgo.add(
                                                  Duration(
                                                      days: (_recipeBeingMoved /
                                                              2)
                                                          .floor()),
                                                );

                                                final idMeal =
                                                    _recipeBeingMoved % 2;

                                                if (id == null) {
                                                  calendar.remove(
                                                      idDay.year,
                                                      idDay.month,
                                                      idDay.day,
                                                      idMeal);
                                                } else {
                                                  calendar.set(
                                                    idDay.year,
                                                    idDay.month,
                                                    idDay.day,
                                                    idMeal,
                                                    id,
                                                  );
                                                }

                                                setState(() {
                                                  _recipe = widget.recipe;
                                                  _recipeBeingMoved = -1;
                                                });
                                              }
                                            } else {
                                              calendar.remove(day.year,
                                                  day.month, day.day, meal);
                                            }
                                          },
                                          onLongPress: id != null
                                              ? () {
                                                  final RelativeRect position =
                                                      buttonMenuPosition(
                                                          context);

                                                  List<PopupMenuItem<int>>
                                                      list = [];

                                                  if (_recipe != id) {
                                                    list.add(PopupMenuItem<int>(
                                                      onTap: () {
                                                        setState(() {
                                                          _recipe = id;
                                                          _recipeBeingMoved =
                                                              2 * index + meal;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        leading:
                                                            const GradientIcon(
                                                          icon: UniconsLine
                                                              .arrow_circle_up,
                                                        ),
                                                        title: CustomText(
                                                          text:
                                                              words['move']![0],
                                                        ),
                                                      ),
                                                    ));
                                                  }

                                                  list.add(
                                                    PopupMenuItem<int>(
                                                      onTap: () =>
                                                          showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return VariationPickerDialog(
                                                            id: id,
                                                            onVariationChange:
                                                                (newId) {
                                                              calendar.set(
                                                                day.year,
                                                                day.month,
                                                                day.day,
                                                                meal,
                                                                newId,
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      child: ListTile(
                                                        leading:
                                                            const GradientIcon(
                                                          icon: Icons.layers,
                                                        ),
                                                        title: CustomText(
                                                          text: words[
                                                              'changeVariations']![0],
                                                        ),
                                                      ),
                                                    ),
                                                  );

                                                  list.add(
                                                    PopupMenuItem<int>(
                                                      onTap: () {},
                                                      child: ListTile(
                                                        leading:
                                                            const GradientIcon(
                                                          icon:
                                                              UniconsLine.fire,
                                                        ),
                                                        title: CustomText(
                                                          text: words[
                                                              'viewRecipe']![0],
                                                        ),
                                                      ),
                                                    ),
                                                  );

                                                  showMenu(
                                                    context: context,
                                                    position: position,
                                                    elevation: 0,
                                                    color: toSurfaceGradient(
                                                        limelightGradient)[1],
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20.0),
                                                      ),
                                                    ),
                                                    constraints: BoxConstraints(
                                                      minWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              2 * (2 * 15 + 24),
                                                    ),
                                                    items: list,
                                                  );
                                                }
                                              : () {},
                                          child: Row(
                                            children: [
                                              GradientIcon(
                                                gradient: 2 * index + meal ==
                                                        _recipeBeingMoved
                                                    ? redGradient
                                                    : limelightGradient,
                                                padding:
                                                    const EdgeInsets.all(15),
                                                icon: Icons.panorama_fish_eye,
                                              ),
                                              CustomText(
                                                text: id == null
                                                    ? ''
                                                    : recipes.name(id.recipeId),
                                              ),
                                              const Expanded(child: SizedBox()),
                                              CustomText(
                                                text: id == null
                                                    ? ''
                                                    : '${id.servings}',
                                              ),
                                              const SizedBox(width: 15),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GradientIcon(
                              gradient: toTextGradient(limelightGradient),
                              padding: const EdgeInsets.all(5),
                              onPressed: () => setState(() {
                                _pageId = _pageId + 1;
                                _pageController.animateToPage(
                                  _pageId,
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut,
                                );
                                _scrollController.animateTo(
                                  calculateScrollOffset(_pageId),
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut,
                                );
                              }),
                              icon: Icons.chevron_right,
                              size: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                child: SizedBox(
                  height: 84,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 61,
                    itemBuilder: (BuildContext context, int index) {
                      final day = aMonthAgo.add(Duration(days: index));
                      final weekday = words['${day.weekday - 1}']![0];

                      final widget = Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: FlatButton(
                          onPressed: index == _pageId
                              ? () => Navigator.of(context).pop()
                              : () {
                                  setState(
                                    () => _letPageControllerMoveView = false,
                                  );

                                  setState(() {
                                    _pageId = index;
                                    _pageController.animateToPage(
                                      index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.linear,
                                    );
                                  });

                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    setState(
                                      () => _letPageControllerMoveView = true,
                                    );
                                  });
                                },
                          child: GradientContainer(
                            gradient: index == _pageId
                                ? toLighterSurfaceGradient(limelightGradient)
                                : toSurfaceGradient(limelightGradient),
                            borderGradient: index == 31
                                ? limelightGradient
                                    .map((e) => e.withOpacity(0.8))
                                    .toList()
                                : null,
                            borderRadius: 15,
                            height: 84,
                            width: 74,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: index == _pageId
                                  ? Center(
                                      child: GradientIcon(
                                        gradient:
                                            toTextGradient(limelightGradient)
                                                .map((e) => e.withOpacity(0.8))
                                                .toList(),
                                        icon: UniconsLine.calendar_slash,
                                        size: 26,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          text: weekday.substring(0, 3),
                                          size: 17,
                                        ),
                                        const SizedBox(height: 5),
                                        CustomText(
                                          text: '${day.day}',
                                          weight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      );

                      if (weekday == words['6']![0]) {
                        return IntrinsicHeight(
                          child: Row(
                            children: [
                              widget,
                              VerticalDivider(
                                color: textColor().withOpacity(0.3),
                                indent: 10,
                                endIndent: 10,
                                width: 8 * 2,
                              ),
                            ],
                          ),
                        );
                      }

                      return widget;
                    },
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GradientIcon(
              onPressed: () => Navigator.of(context).pop(),
              gradient: toTextGradient(limelightGradient),
              padding: const EdgeInsets.all(10),
              icon: Icons.chevron_left,
            ),
          ),
        ],
      ),
    );
  }

  double calculateScrollOffset(int index) {
    final indexOfFirstSunday = 7 - aMonthAgo.weekday;
    final numberOfSundays = ((index - 1 - indexOfFirstSunday) / 7).floor() + 1;

    const itemWidth = 74 + 8 * 2;
    final cumulatedItemWidth = itemWidth * index;
    final dividers = 8 * 2 * numberOfSundays;
    const paddingBeforeLastDay = 8.0;

    final double screenWidth = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.width /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

    final centered = (screenWidth / 2) - (74 - 8 * 2);

    return cumulatedItemWidth + dividers + paddingBeforeLastDay - centered;
  }
}
