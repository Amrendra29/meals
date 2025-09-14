import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals/models/meal.dart';

class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifier() : super([]);
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealisfavourite = state.contains(meal);
    if (mealisfavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>((ref) {
      return FavoritesMealsNotifier();
    });
