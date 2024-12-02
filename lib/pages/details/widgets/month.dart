import 'package:flutter/material.dart';

class Months extends StatelessWidget {
  const Months({super.key});

   @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.red,
          child: Center(child: Text("Conteúdo Mes")),
        ),
      ],
    );
  }
}