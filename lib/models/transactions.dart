class TransactionModel {
  final String title;
  final double amount;
  final String user;
  bool isReconciled;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.user,
    this.isReconciled = false,
  });
}