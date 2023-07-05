import 'package:limelight/data/recipes.dart';
import 'package:test/test.dart';

void main() {
  group('Recipes', () {
    test('Pasta with tomato sauce : dry pasta variation', () {
      pastaRecipes[0].setVariation("Dry pasta");
      expect(pastaRecipes[0].instructionSet, 0);
    });

    test('value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
