import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';
import 'screens/meals_by_category_screen.dart';
import 'screens/meal_detail_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const CategoriesScreen(),
  '/meals': (context) => const MealsByCategoryScreen(),
  '/detail': (context) => const MealDetailScreen(),
};