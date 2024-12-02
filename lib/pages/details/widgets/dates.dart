import 'package:cashkeeper/pages/details/widgets/month.dart';
import 'package:cashkeeper/pages/details/widgets/week.dart';
import 'package:flutter/material.dart';

class Dates extends StatefulWidget {
  const Dates({super.key});

  @override
  State<Dates> createState() => _DatesState();
}

class _DatesState extends State<Dates> {
  bool isMonthSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 80,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Botão "Mês"
              isMonthSelected
                  ? OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = true;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xff00dda3), width: 2),
                      ),
                      child: Text('Mês', style: TextStyle(color: Color(0xff00dda3))),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff33404f),
                      ),
                      child: Text('Mês', style: TextStyle(color: Colors.white)),
                    ),
              // Botão "Semana"
              !isMonthSelected
                  ? OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = false;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xff00dda3), width: 2),
                      ),
                      child: Text('Semana', style: TextStyle(color: Color(0xff00dda3))),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff33404f),
                      ),
                      child: Text('Semana', style: TextStyle(color: Colors.white)),
                    ),
            ],
          ),
        ),
        // Exibição do conteúdo
        Expanded(
          child: isMonthSelected ? Months() : Weeks(),
        ),
      ],
    );
  }
}
