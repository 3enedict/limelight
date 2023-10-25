import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/data/provider/calendar_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // https://stackoverflow.com/questions/50687801/flutter-unhandled-exception-missingpluginexceptionno-implementation-found-for
  SharedPreferences.setMockInitialValues({});

  test('Parsing a recipe from string works', () {
    final recipe = RecipeId.fromString('9:3:1:0:1:3:2');

    expect(
      recipe,
      RecipeId(
        recipeId: 9,
        servings: 3,
        times: 1,
        variationIds: [0, 1, 3, 2],
      ),
    );
  });

  test('Transforming a recipe id to a string works', () {
    final recipe = RecipeId(
      recipeId: 9,
      servings: 3,
      times: 1,
      variationIds: [0, 1, 3, 2],
    );

    expect(recipe.toString(), '9:3:1:0:1:3:2');
  });

  test('Loading meals from a list of dated strings works correctly', () {
    final CalendarModel model = CalendarModel();

    // year/month/day/meal id (lunch, dinner...)/RecipeId
    final meals = [
      "2023:7:9:0/1:1:1",
      "2023:7:9:1/5:5:5",
      "2023:7:10:0/0:0:0",
      "2023:7:10:1/9:3:1:0:1:3:2", // Meal tested
      "2023:7:11:0/3:3:3",
      "2023:7:11:1/27:27:27",
    ];

    model.loadCalendar(meals);

    expect(model.get(2023, 7, 10, 1), RecipeId.fromString('9:3:1:0:1:3:2'));
  });

  test('A meal can be added and retrieved per date', () {
    final CalendarModel model = CalendarModel();

    int year = 2023;
    int month = 7;
    int day = 10;
    int meal = 1;

    final recipe = RecipeId.fromString('9:3:2:0:1:3:2');

    model.set(year, month, day, meal, recipe);

    expect(model.get(year, month, day, meal), recipe);
  });

  test('Removing a meal from calendar works', () {
    final CalendarModel model = CalendarModel();

    int year = 2023;
    int month = 7;
    int day = 10;
    int meal = 1;

    final recipe = RecipeId(
      recipeId: 9,
      servings: 3,
      variationIds: [0, 1, 3, 2],
    );

    model.set(year, month, day, meal, recipe);
    model.remove(year, month, day, meal);

    expect(model.get(year, month, day, meal), null);
  });

  test('Loading meals to meal list works', () {
    final CalendarModel model = CalendarModel();

    // year/month/day/meal id (lunch, dinner...)/RecipeId
    final meals = [
      '1:1:1',
      '5:5:5',
      '0:0:0',
      '9:3:1:0:1:3:2', // Meal tested
      '3:3:3',
      '27:27:27',
    ];

    model.loadMealList(meals);

    assert(model.mealList.contains(RecipeId.fromString('9:3:1:0:1:3:2')));
  });

  test('Adding a meal to meal list works', () {
    final CalendarModel model = CalendarModel();
    final recipe = RecipeId(
      recipeId: 9,
      servings: 3,
      variationIds: [0, 1, 3, 2],
    );

    model.addToList(recipe);

    assert(model.mealList.contains(RecipeId.fromString('9:3:1:0:1:3:2')));
  });

  test('Adding two meals to meal list also works', () {
    final CalendarModel model = CalendarModel();
    final recipe = RecipeId(
      recipeId: 9,
      servings: 3,
      variationIds: [0, 1, 3, 2],
    );

    model.addToList(recipe);
    model.addToList(RecipeId.fromString('0:3:2:0:1:3:2'));

    assert(model.mealList.contains(RecipeId.fromString('0:3:1:0:1:3:2')));
  });

  test('Removing a meal from meal list works', () {
    final CalendarModel model = CalendarModel();
    final recipe = RecipeId(
      recipeId: 9,
      servings: 3,
      variationIds: [0, 1, 3, 2],
    );

    model.addToList(recipe);
    model.removeFromList(recipe);

    assert(model.mealList.isEmpty);
  });

  test('Decreasing number of times that a meal is served in meal list works',
      () {
    final CalendarModel model = CalendarModel();
    final recipe = RecipeId(
      recipeId: 9,
      servings: 3,
      variationIds: [0, 1, 3, 2],
    );

    model.addToList(recipe);
    model.addToList(recipe);
    model.removeFromList(recipe);

    assert(model.mealList.contains(RecipeId.fromString('9:3:1:0:1:3:2')));
  });
}
