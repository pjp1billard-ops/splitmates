import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {"label": "Courses", "value": 150.0},
      {"label": "Sorties", "value": 80.0},
      {"label": "Logement", "value": 45.0},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Analyse")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: data.map((item) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["label"].toString()),
                Container(
                  height: 20,
                  width: item["value"] as double,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  color: Colors.purple,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}