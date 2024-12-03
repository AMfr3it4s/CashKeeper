import 'package:cashkeeper/utils/chart_column.dart';
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  const BarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ChartColumn()
            ],
          )
        ),
      ),
    );
  }
}