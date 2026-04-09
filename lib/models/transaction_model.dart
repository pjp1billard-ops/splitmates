
class TransactionModel {
  final String title;
  final double amount;
  final String user;
  final String category; // 👈 AJOUT
  bool isReconciled;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.user,
    required this.category, // 👈 AJOUT
    this.isReconciled = false,
  });
}