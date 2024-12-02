import 'package:cashkeeper/pages/details/widgets/dates.dart';
import 'package:cashkeeper/pages/details/widgets/header.dart';
import 'package:cashkeeper/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(),
          Expanded(child: Dates()),
          BottomNavigation(),
        ],
      ),
    );
  }
}