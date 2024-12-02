import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [       
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0), 
              child: Text(
                "Atividades",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff33404f),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Knewave',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
