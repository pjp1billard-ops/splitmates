import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}
final List<String> categories = [
  "Courses",
  "Restaurant",
  "Transport",
  "Loisirs",
];
class _AddTransactionScreenState
    extends State<AddTransactionScreen> {
      final List<String> categories = [
  "Courses",
  "Restaurant",
  "Transport",
  "Loisirs",
];
  final titleController = TextEditingController();
  final amountController = TextEditingController();
String selectedCategory = "Courses";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Titre",
              ),
            ),
            DropdownButtonFormField<String>(
  value: selectedCategory,
  items: categories.map((cat) {
    return DropdownMenuItem(
      value: cat,
      child: Text(cat),
    );
  }).toList(),
  onChanged: (value) {
    setState(() {
      selectedCategory = value!;
    });
  },
  decoration: const InputDecoration(
    labelText: "Catégorie",
  ),
),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Montant",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
  await FirestoreService().addTransaction(
    title: titleController.text,
    amount: double.parse(amountController.text),
    category: selectedCategory,
    user: "Jean-Pierre",
  );

  Navigator.pop(context);
},
            ),
          ],
        ),
      ),
    );
  }
}