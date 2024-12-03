import 'package:cashkeeper/utils/chart_column_week.dart';
import 'package:flutter/material.dart';

class Weeks extends StatelessWidget {
  const Weeks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ChartColumnWeek()
            ],
          )
        ),
      ),
    );
  }
}
