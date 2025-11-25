import 'package:flutter/foundation.dart' hide Category;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';
import '../services/api_service.dart';

class MealProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<Category> categories = [];
  bool loadingCategories = false;

  List<Meal> meals = [];
  bool loadingMeals = false;

  MealDetail? selectedMeal;
  bool loadingDetail = false;

  Future<void> loadCategories() async {
    loadingCategories = true;
    notifyListeners();
    try {
      categories = await _api.fetchCategories();
    } finally {
      loadingCategories = false;
      notifyListeners();
    }
  }

  Future<void> loadMealsByCategory(String category) async {
    loadingMeals = true;
    notifyListeners();
    try {
      meals = await _api.fetchMealsByCategory(category);
    } finally {
      loadingMeals = false;
      notifyListeners();
    }
  }

  Future<void> searchMeals(String query) async {
    loadingMeals = true;
    notifyListeners();
    try {
      meals = await _api.searchMeals(query);
    } finally {
      loadingMeals = false;
      notifyListeners();
    }
  }

  Future<void> loadMealDetail(String id) async {
    loadingDetail = true;
    notifyListeners();
    try {
      selectedMeal = await _api.fetchMealDetail(id);
    } finally {
      loadingDetail = false;
      notifyListeners();
    }
  }

  Future<void> loadRandomMeal() async {
    loadingDetail = true;
    notifyListeners();
    try {
      selectedMeal = await _api.fetchRandomMeal();
    } finally {
      loadingDetail = false;
      notifyListeners();
    }
  }
}