class TransactionModel {
  final String title;
  final double amount;
  final String type; // 'income' or 'expense'
  final String category;
  final DateTime date;
  final String? notes;
  final String? imagePath;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.notes,
    this.imagePath,
  });
}
