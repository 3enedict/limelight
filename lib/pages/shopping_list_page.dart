import 'package:flutter/material.dart';

import 'package:limelight/widgets/page_layout.dart';
import 'package:limelight/widgets/ingredient.dart';

class IngredientData {
  final String name;
  final String season;
  final String price;
  final String cheapness;
  final List<Color> accentGradient;

  IngredientData({
    required this.name,
    required this.season,
    required this.price,
    required this.cheapness,
    required this.accentGradient,
  });
}

IngredientLayout ingredientLayout(IngredientData data, VoidCallback onPressed) {
  return IngredientLayout(
    name: data.name,
    season: data.season,
    price: data.price,
    cheapness: data.cheapness,
    accentGradient: data.accentGradient,
    onPressed: onPressed,
  );
}

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
      accentGradient: const [
        Color(0xFFFF4B2B),
        Color(0xFFFF416C),
      ],
    ),
    IngredientData(
      name: 'Kale',
      season: 'Fall and winter',
      price: '\$2.00 per lb',
      cheapness: 'Cheap',
      accentGradient: const [
        Color(0xFFFF4B2B),
        Color(0xFFFF416C),
      ],
    ),
    IngredientData(
      name: 'Arugula',
      season: 'Late spring and early fall',
      price: '\$10.00 per lb',
      cheapness: 'Expensive',
      accentGradient: const [
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
                accentGradient: const [
                  Color(0xFFFF4B2B),
                  Color(0xFFFF416C),
                ],
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: ShaderMask(
          shaderCallback: (bound) {
            return const LinearGradient(
                end: FractionalOffset.topCenter,
                begin: FractionalOffset.bottomCenter,
                colors: [
                  Color(0xFF292f4d),
                  Color(0x00292f4d),
                ],
                stops: [
                  0.0,
                  0.3,
                ]).createShader(bound);
          },
          blendMode: BlendMode.srcOver,
          child: DefaultPageLayout(
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
                    child: ingredientLayout(
                      _items[index],
                      () {
                        var item = _items.removeAt(index);

                        SliverAnimatedList.of(context).removeItem(
                          index,
                          (context, animation) => FadeTransition(
                            opacity: animation,
                            child: SizeTransition(
                              sizeFactor: animation,
                              child: ingredientLayout(item, () {}),
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
