import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_card.dart';
import '../widgets/search_input.dart';

class MealsByCategoryScreen extends StatelessWidget {
  const MealsByCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealProvider>(context);
    final String category = ModalRoute.of(context)!.settings.arguments as String? ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E5),
      appBar: AppBar(title: Text(category)),
      body: Column(
        children: [
          SearchInput(
            hint: 'Search meals in $category...',
            onSubmitted: (q) async {
              if (q.trim().isEmpty) {
                await provider.loadMealsByCategory(category);
              } else {
                await provider.searchMeals(q);
              }
            },
          ),
          Expanded(
            child: provider.loadingMeals
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: provider.meals.length,
              itemBuilder: (context, i) {
                final meal = provider.meals[i];
                return MealCard(
                  meal: meal,
                  onTap: () async {
                    await provider.loadMealDetail(meal.id);
                    Navigator.pushNamed(context, '/detail');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}