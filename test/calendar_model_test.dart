import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/data/provider/calendar_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // https://stackoverflow.com/questions/50687801/flutter-unhandled-exception-missingpluginexceptionno-implementation-found-for
  SharedPreferences.setMockInitialValues({});

  test('Loading meals from a list of strings works correctly', () {
    final CalendarModel model = CalendarModel();

    // year/month/day/meal id (lunch, dinner...)/recipe id
    final meals = [
      "2023/7/9/0/1",
      "2023/7/9/1/5",
      "2023/7/10/0/0",
      "2023/7/10/1/84", // Meal tested
      "2023/7/11/0/3",
      "2023/7/11/1/27",
    ];

    model.loadFromStringList(meals);

    expect(model.get(2023, 7, 10, 1), 84);
  });

  test('A meal can be added and retrieved', () {
    final CalendarModel model = CalendarModel();

    int year = 2023;
    int month = 7;
    int day = 10;
    int meal = 1;
    int recipeId = 3;
    model.set(year, month, day, meal, recipeId);

    expect(model.get(year, month, day, meal), recipeId);
  });
}
