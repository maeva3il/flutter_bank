// widgets/transaction_list.dart
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;
  final Function(int) removeTransaction;
  final Function(int) modifyTransaction;

  const TransactionList({super.key, required this.transactions, required this.removeTransaction, required this.modifyTransaction});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          leading: const Icon(Icons.category),
          title: Text(transaction['category']),
          subtitle: Text(transaction['date']),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('\$${transaction['amount']}'),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => modifyTransaction(index),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => removeTransaction(index),
              ),
            ],
          ),
        );
      },
    );
  }
}
