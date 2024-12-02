import 'package:flutter/material.dart';

class Weeks extends StatelessWidget {
  const Weeks({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.yellow,
          child: Center(child: Text("Conteúdo Semanal")),
        ),
      ],
    );
  }
}
