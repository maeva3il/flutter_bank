import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/categorie.dart';

class CategoryProgress extends StatelessWidget {
  final List<Categorie> categories;
  final double progress;

  const CategoryProgress({super.key, required this.categories, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('Dépenses Mensuelles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: progress.clamp(0.0, 1.0), minHeight: 10),
          const SizedBox(height: 10),
          Column(
            children: categories.map((category) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  category.name,
                  style: TextStyle(color: category.color, fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
