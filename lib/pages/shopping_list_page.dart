import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/ingredient.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => ShoppingListPageState();
}

class ShoppingListPageState extends State<ShoppingListPage>
    with AutomaticKeepAliveClientMixin<ShoppingListPage> {
  final _key = GlobalKey<SliverAnimatedListState>();
  final _items = [
    IngredientData(
      name: 'Lettuce',
      season: 'Spring and fall',
      price: '\$1.00 per head',
      cheapness: 'Really cheap',
      gradient: const [
        Color(0xFFFF4B2B),
        Color(0xFFFF416C),
      ],
    ),
    IngredientData(
      name: 'Kale',
      season: 'Fall and winter',
      price: '\$2.00 per lb',
      cheapness: 'Cheap',
      gradient: const [
        Color(0xFFFF4B2B),
        Color(0xFFFF416C),
      ],
    ),
    IngredientData(
      name: 'Arugula',
      season: 'Late spring and early fall',
      price: '\$10.00 per lb',
      cheapness: 'Expensive',
      gradient: const [
        Color(0xFFFF4B2B),
        Color(0xFFFF416C),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF384364),
            Color(0xFF292f4d),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white24,
          onPressed: () {
            _key.currentState!.insertItem(_items.length);
            _items.add(
              IngredientData(
                name: 'Arugula',
                season: 'Late spring and early fall',
                price: '\$10.00 per lb',
                cheapness: 'Expensive',
                gradient: const [
                  Color(0xFFFF4B2B),
                  Color(0xFFFF416C),
                ],
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: DefaultPage(
          title: 'Shopping List',
          titleBackground: const AssetImage('assets/Shopping List.jpg'),
          padding: 125,
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
