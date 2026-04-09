import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/transaction_model.dart';

class ChartWidget extends StatelessWidget {
  final List<TransactionModel> transactions;

  const ChartWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    Map<String, double> data = {};

    for (var tx in transactions) {
      data[tx.category] =
          (data[tx.category] ?? 0) + tx.amount;
    }

    final categories = data.keys.toList();

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  return Text(
                    categories[value.toInt()],
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(categories.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data[categories[i]]!,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}