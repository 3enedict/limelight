import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/gradients.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => ShoppingListPageState();
}

class ShoppingListPageState extends State<ShoppingListPage>
    with AutomaticKeepAliveClientMixin<ShoppingListPage> {
  final _key = GlobalKey<SliverAnimatedListState>();
  final _items = [
    IngredientDescription(
      name: 'Lettuce',
      season: 'Spring and fall',
      price: '\$1.00',
      unit: 'per head',
      group: 0,
    ),
    IngredientDescription(
      name: 'Kale',
      season: 'Fall and winter',
      price: '\$2.00',
      unit: 'per lb',
      group: 0,
    ),
    IngredientDescription(
      name: 'Arugula',
      season: 'Late spring and early fall',
      price: '\$10.00',
      unit: 'per lb',
      group: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EmptyPage(
      gradient: limelightGradient,
      fab: GradientButton(
        diameter: 56,
        gradient: toSurfaceGradient(limelightGradient),
        onPressed: () {
          _key.currentState!.insertItem(_items.length);
          _items.add(
            IngredientDescription(
              name: 'Arugula',
              season: 'Late spring and early fall',
              price: '\$10.00',
              unit: 'per lb',
              group: 0,
            ),
          );
        },
        padding: const EdgeInsets.all(0),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white70,
          ),
        ),
      ),
      child: ItemList(
        title: 'Shopping List',
        titleBackground: const AssetImage('assets/Shopping List.jpg'),
        padding: 80,
        gradient: limelightGradient,
        items: SliverAnimatedList(
          key: _key,
          initialItemCount: _items.length,
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: _items[index].toItem(
                  () {
                    var item = _items.removeAt(index);

                    SliverAnimatedList.of(context).removeItem(
                      index,
                      (context, animation) => FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          child: item.toItem(() {}),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
