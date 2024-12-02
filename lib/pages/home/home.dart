import 'package:cashkeeper/pages/home/widgets/activity.dart';
import 'package:cashkeeper/pages/home/widgets/header.dart';
import 'package:cashkeeper/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader(),
          Activity(),
          BottomNavigation(),
      
        ],
      ),
    );
  }
}