import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/gradients.dart';

class IngredientSearchItem extends StatefulWidget {
  final String query;
  final bool selected;
  final IngredientDescription ingredient;
  final void Function(String) selectIngredient;
  final void Function(String) editIngredient;
  final void Function() removeIngredient;
  final FocusNode node;

  const IngredientSearchItem({
    super.key,
    this.query = '',
    required this.selected,
    required this.ingredient,
    required this.selectIngredient,
    required this.editIngredient,
    required this.removeIngredient,
    required this.node,
  });

  @override
  State<IngredientSearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<IngredientSearchItem> {
  bool _more = false;
  bool _editing = false;

  final _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
      child: GradientButton(
        gradient: toSurfaceGradient(limelightGradient),
        borderRadius: 15,
        onPressed: () {
          if (_more == false) widget.selectIngredient(widget.ingredient.name);
          setState(() => _more = false);
        },
        onLongPress: () => setState(() => _more = true),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LeadingCircle(
              selected: widget.selected,
              name: widget.ingredient.name,
            ),
            Expanded(
              child: !_editing
                  ? ItemTitle(
                      query: widget.query,
                      name: widget.ingredient.name,
                    )
                  : TextFormField(
                      focusNode: _node,
                      onFieldSubmitted: (text) {
                        widget.editIngredient(text);
                        widget.node.requestFocus();

                        setState(() {
                          _editing = false;
                          _more = false;
                        });
                      },
                      initialValue: widget.ingredient.name,
                      style: GoogleFonts.openSans(
                        color: textColor(),
                        fontSize: 14,
                      ),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      textCapitalization: TextCapitalization.sentences,
                    ),
            ),
            _more
                ? GradientIcon(
                    gradient: redGradient,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    onPressed: () => widget.removeIngredient(),
                    icon: Icons.remove,
                  )
                : const SizedBox(),
            _more
                ? GradientIcon(
                    gradient: limelightGradient,
                    onPressed: () {
                      setState(() => _editing = true);
                      widget.node.unfocus();
                      _node.requestFocus();
                    },
                    icon: Icons.edit,
                  )
                : const SizedBox(),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}

class LeadingCircle extends StatelessWidget {
  final bool selected;
  final String name;

  const LeadingCircle({
    super.key,
    required this.selected,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientModel>(
      builder: (context, ingredients, child) {
        return GradientIcon(
          gradient: limelightGradient,
          padding: const EdgeInsets.all(16),
          size: 22,
          icon: selected ? Icons.adjust : Icons.panorama_fish_eye,
        );
      },
    );
  }
}

class ItemTitle extends StatelessWidget {
  final String query;
  final String name;

  const ItemTitle({
    super.key,
    required this.query,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final runes = name.runes;
    List<TextSpan> styledName = List.generate(
      runes.length,
      (int index) {
        String character = String.fromCharCode(runes.elementAtOrNull(index)!);
        bool match = query.toLowerCase().contains(character.toLowerCase());

        return TextSpan(
          text: character,
          style: TextStyle(
            color: match ? modifyColor(textColor(), 0.95, 0.1) : textColor(),
            fontWeight: match ? FontWeight.w900 : FontWeight.w100,
          ),
        );
      },
    );

    return Text.rich(
      TextSpan(
        children: styledName,
        style: GoogleFonts.workSans(
          color: textColor(),
          fontSize: 14,
        ),
      ),
    );
  }
}
