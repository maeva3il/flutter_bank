class Transaction {
  final String title;
  final double amount;
  final DateTime timestamp;
  final String category;

  Transaction({
    required this.title,
    required this.amount,
    required this.timestamp,
    required this.category,
  });
}
