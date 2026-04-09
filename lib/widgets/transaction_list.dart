import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FirestoreService();

    return StreamBuilder<QuerySnapshot>(
      stream: service.getTransactions(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final transactions = snapshot.data!.docs;

        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final tx = transactions[index];

            return ListTile(
              title: Text(tx['category']),
              subtitle: Text(tx['user']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${tx['amount']} €"),
                  Checkbox(
                    value: tx['isReconciled'],
                    onChanged: (val) {
                      service.toggleReconciled(tx.id, val!);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}