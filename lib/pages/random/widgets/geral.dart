import 'package:flutter/material.dart';

class Geral extends StatelessWidget {
  const Geral({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Stack(
        children: [       
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0), 
              child: Text(
                "Geral",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff33404f),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Knewave',
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xff00dda3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Parkinsans',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "dia",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Parkinsans',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "€ 300",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Parkinsans',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}