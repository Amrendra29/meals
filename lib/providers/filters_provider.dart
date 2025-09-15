import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegetarian }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });

  void setfilters(Map<Filter, bool> choosenfilters) {
    state = choosenfilters;
  }

  void setfilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider = StateNotifierProvider((ref) => FiltersNotifier());

final filtersMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activefilter = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activefilter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activefilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activefilter[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activefilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
