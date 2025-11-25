import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/search_input.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MealProvider>(context, listen: false);
    provider.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE9CC),
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () async {
              await provider.loadRandomMeal();
              Navigator.pushNamed(context, '/detail');
            },
            tooltip: 'Random recipe',
          )
        ],
      ),
      body: Column(
        children: [
          SearchInput(
            hint: 'Search categories...',
            onSubmitted: (q) {
              // simple client-side filter
              // if empty -> reload
              if (q.trim().isEmpty) {
                provider.loadCategories();
                return;
              }
              provider.categories = provider.categories
                  .where((c) => c.name.toLowerCase().contains(q.toLowerCase()))
                  .toList();
              provider.notifyListeners();
            },
          ),
          Expanded(
            child: provider.loadingCategories
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: provider.categories.length,
              itemBuilder: (context, i) {
                final cat = provider.categories[i];
                return CategoryCard(
                  category: cat,
                  onTap: () async {
                    await provider.loadMealsByCategory(cat.name);
                    Navigator.pushNamed(context, '/meals', arguments: cat.name);
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