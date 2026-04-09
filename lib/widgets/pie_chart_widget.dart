import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class PieChartWidget extends StatelessWidget {
  final List<TransactionModel> transactions;

  const PieChartWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> data = {};

    for (final tx in transactions) {
      data[tx.category] = (data[tx.category] ?? 0) + tx.amount;
    }

    if (data.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text("Pas encore de données")),
      );
    }

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: data.entries.map((entry) {
            return PieChartSectionData(
              value: entry.value,
              title: entry.key,
              radius: 50,
            );
          }).toList(),
        ),
      ),
    );
  }
}