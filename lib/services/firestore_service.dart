import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final collection =
      FirebaseFirestore.instance.collection('transactions');

  // ➕ ajouter
  Future<void> addTransaction({
    required String title,
    required double amount,
    required String category,
    required String user,
  }) async {
    await collection.add({
      'title': title,
      'amount': amount,
      'category': category,
      'user': user,
      'isReconciled': false,
      'date': Timestamp.now(),
    });
  }

  // 📥 lire
  Stream<QuerySnapshot> getTransactions() {
    return collection
        .orderBy('date', descending: true)
        .snapshots();
  }

  // ✅ pointage
  Future<void> toggle(String id, bool value) async {
    await collection.doc(id).update({
      'isReconciled': value,
    });
  }
}