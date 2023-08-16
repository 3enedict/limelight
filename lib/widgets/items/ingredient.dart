import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:limelight/pages/add_ingredient_page.dart';
import 'package:limelight/transitions.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/ingredient_groups.dart';
import 'package:limelight/gradients.dart';

class IngredientItem extends StatefulWidget {
  final int id;

  const IngredientItem({
    super.key,
    required this.id,
  });

  @override
  State<IngredientItem> createState() => IngredientItemState();
}

class IngredientItemState extends State<IngredientItem> {
  Offset _tapPosition = Offset.zero;

  void _showCustomMenu(BuildContext context) {
    final overlay = Overlay.of(context).context.findRenderObject();
    if (overlay == null) return;

    final text = ["Edit", "Add", "Remove"];

    final icons = [
      FeatherIcons.edit2,
      FeatherIcons.plus,
      FeatherIcons.trash,
    ];

    final actions = [
      () {
        Future(() {
          fadeTransition(context, const AddIngredientPage());
          Provider.of<IngredientModel>(context, listen: false)
              .remove(widget.id);
        });
      },
      () => Future(() => fadeTransition(context, const AddIngredientPage())),
      () => Provider.of<IngredientModel>(context, listen: false)
          .remove(widget.id),
    ];

    final groupId = Provider.of<IngredientModel>(context, listen: false)
        .get(widget.id)
        .group;

    showMenu(
      context: context,
      color: toSurfaceGradient(gradients[groupId])[1],
      items: List.generate(
        3,
        (int index) => PopupMenuItem(
          onTap: actions[index],
          child: Row(
            children: [
              Icon(
                icons[index],
                color: Colors.white70,
                size: 18,
              ),
              const SizedBox(width: 12),
              Text(
                text[index],
                style: GoogleFonts.workSans(
                  textStyle: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
        growable: false,
      ),
      position: RelativeRect.fromRect(
        _tapPosition & const Size(40, 40),
        Offset.zero & overlay.semanticBounds.size,
      ),
    );
  }

  void _storePosition(TapDownDetails details) {
    setState(() => _tapPosition = details.globalPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientModel>(
      builder: (context, ingredients, child) {
        final enabled = ingredients.isEnabled(widget.id);

        final desc = ingredients.get(widget.id);
        final gradient = gradients[desc.group];

        return GestureDetector(
          onTapDown: _storePosition,
          child: Item(
            title: desc.name,
            subTitle: desc.season,
            info: desc.price,
            subInfo: desc.unit,
            accentGradient: enabled
                ? const [Color(0xFF222222), Color(0xFF222222)]
                : gradient,
            backgroundGradient:
                enabled ? gradient : toBackgroundGradient(gradient),
            textColor:
                enabled ? const Color(0xFF111111) : const Color(0xFFEEEEEE),
            subTextColor:
                enabled ? const Color(0xFF222222) : const Color(0xFFDDDDDD),
            onPressed: () => ingredients.toggle(widget.id),
            onLongPress: () => _showCustomMenu(context),
          ),
        );
      },
    );
  }
}
