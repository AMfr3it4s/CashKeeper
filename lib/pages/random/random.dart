import 'package:cashkeeper/pages/random/widgets/calendar.dart';
import 'package:cashkeeper/pages/random/widgets/geral.dart';
import 'package:cashkeeper/pages/random/widgets/header.dart';
import 'package:cashkeeper/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
           children: [
            Header(),
            Geral(),
            CalendarPage(),
            BottomNavigation()
           ],
      ),
    );
  }
}