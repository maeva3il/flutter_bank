import 'package:flutter/material.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gérer Dépenses & Catégories')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Ajouter Dépense'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Ajouter Catégorie'),
            ),
          ],
        ),
      ),
    );
  }
}