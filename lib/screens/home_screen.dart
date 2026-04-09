import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import 'add_transaction_screen.dart';
import '../widgets/chart_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TransactionModel> transactions = [];

 void addTransaction(
  String title,
  double amount,
  String category,
) {
  setState(() {
    transactions.add(
      TransactionModel(
        title: title,
        amount: amount,
        user: "Jean-Pierre",
        category: category, // 🔥
      ),
    );
  });
}

  void toggleTransaction(int index) {
    setState(() {
      transactions[index].isReconciled =
          !transactions[index].isReconciled;
    });
  }

  double get total {
    return transactions.fold(0, (sum, tx) => sum + tx.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("SplitMates"),
      ),
      body: Column(
        children: [
          // 💜 HEADER
          ChartWidget(transactions: transactions),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Solde total",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  "${total.toStringAsFixed(2)} €",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 🧾 LISTE
 Expanded(
  child: StreamBuilder<QuerySnapshot>(
    stream: FirestoreService().getTransactions(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }

      final docs = snapshot.data!.docs;

      return ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          final tx = docs[index];

          return ListTile(
            title: Text(tx['title']),
            subtitle:
                Text("${tx['user']} • ${tx['category']}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${tx['amount']} €"),
                Checkbox(
                  value: tx['isReconciled'],
                  onChanged: (val) {
                    FirestoreService()
                        .toggle(tx.id, val!);
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  ),
)
        ],
      ),

      // ➕ BOUTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddTransactionScreen(),
            ),
          );

          if (result != null) {
       addTransaction(
  result['title'],
  result['amount'],
  result['category'],
);
          }
        },
      ),
    );
  }
}