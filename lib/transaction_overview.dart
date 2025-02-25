import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_application_1/model/transaction.dart';
import 'package:flutter_application_1/model/categorie.dart';

class TransactionOverview extends StatelessWidget {
  TransactionOverview({super.key});

  final List<Categorie> categories = [
    Categorie(name: "Alimentation", color: Colors.red, limit: 240),
    Categorie(name: "Transport", color: Colors.blue, limit: 100),
  ];

  final List<Transaction> transactions = [
    Transaction(title: "iPad Pro", amount: 1200.0, timestamp: DateTime.now(), category: "Alimentation"),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: categories.map((category) {
        final totalSpent = transactions
            .where((t) => t.category == category.name)
            .fold(0.0, (sum, t) => sum + t.amount);

        final percentage = (totalSpent / category.limit).clamp(0.0, 1.0);

        return CircularPercentIndicator(
          radius: 100.0,
          lineWidth: 10.0,
          percent: percentage,
          center: const SizedBox.shrink(),
          progressColor: category.color.withOpacity(0.6),
          circularStrokeCap: CircularStrokeCap.round,
          animation: true,
        );
      }).toList(),
    );
  }
}
