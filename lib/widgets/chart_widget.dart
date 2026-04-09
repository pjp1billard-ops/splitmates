import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class ChartWidget extends StatelessWidget {
  final List<TransactionModel> transactions;

  const ChartWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> data = {};

    for (final tx in transactions) {
      data[tx.category] = (data[tx.category] ?? 0) + tx.amount;
    }

    final categories = data.keys.toList();

    if (categories.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text("Pas encore de données")),
      );
    }

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  if (i < 0 || i >= categories.length) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    categories[i],
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          barGroups: List.generate(categories.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data[categories[i]]!,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}