import 'package:cashkeeper/utils/bar_chart.dart';
import 'package:flutter/material.dart';

class Months extends StatelessWidget {
  const Months({super.key});

   @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BarChart()
      ],
    );
  }
}