import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/transaction_overview.dart';
import 'package:flutter_application_1/model/transaction.dart';
import 'package:provider/provider.dart'; // Pour Provider
import 'package:intl/intl.dart'; // Pour DateFormat

final DateFormat dayFormat = DateFormat('EEEE, d MMMM');
final DateFormat fullFormat = DateFormat('HH:mm');

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Map<DateTime, List<Transaction>> dates = {
    DateTime(2025, 2, 23): [
      Transaction(
          title: "Déjeuner",
          amount: 15.0,
          timestamp: DateTime(2025, 2, 23, 12, 30),
          category: "Alimentation"),
      Transaction(
          title: "Essence",
          amount: 50.0,
          timestamp: DateTime(2025, 2, 23, 14, 0),
          category: "Transport"),
    ],
    DateTime(2025, 2, 24): [
      Transaction(
          title: "Supermarché",
          amount: 80.0,
          timestamp: DateTime(2025, 2, 24, 18, 45),
          category: "Alimentation"),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Dépenses')),
      body: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.3),
                  ),
                  child: CircleAvatar(
                    radius: 84,
                    backgroundImage:
                        user != null ? NetworkImage(user.picture) : null,
                    child: user == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                ),
                TransactionOverview(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: dates.length,
              itemBuilder: (BuildContext context, int index) {
                final day = dates.keys.toList()[index];
                final dayTransactions = dates[day]!;

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                        child: Text(dayFormat.format(day),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dayTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = dayTransactions[index];
                        return ListTile(
                          title: Text(transaction.title),
                          subtitle:
                              Text(fullFormat.format(transaction.timestamp)),
                          trailing: Text(
                            '${transaction.amount}€',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onTap: () {},
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
