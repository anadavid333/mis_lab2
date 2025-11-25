import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/meal_provider.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealProvider>(context);
    final meal = provider.selectedMeal;

    if (provider.loadingDetail) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (meal == null) {
      return Scaffold(body: Center(child: Text('No meal selected')));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E5),
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal.thumbnail, height: 220, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(meal.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Category: ${meal.category} • Area: ${meal.area}'),
            const SizedBox(height: 12),
            Text('Ingredients:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...meal.ingredients.entries.map((e) => Text('${e.key} — ${e.value}')),
            const SizedBox(height: 12),
            Text('Instructions:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(meal.instructions),
            const SizedBox(height: 12),
            if (meal.youtube != null && meal.youtube!.isNotEmpty)
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Watch on YouTube'),
                onPressed: () async {
                  final uri = Uri.parse(meal.youtube!);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}