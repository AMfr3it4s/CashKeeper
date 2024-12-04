import 'package:cashkeeper/pages/details/widgets/month.dart';
import 'package:cashkeeper/pages/details/widgets/week.dart';
import 'package:cashkeeper/utils/globals.dart';
import 'package:cashkeeper/utils/libs/constants.dart';
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
          color: AppColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Botão "Mês"
              isMonthSelected
                  ? OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = true;
                          isWeekSelected.value = false;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.tertiaryColor, width: 2),
                      ),
                      child: Text('Mês', style: TextStyle(color: AppColors.tertiaryColor, fontFamily: AppFonts.primaryFont)),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = true;
                          isWeekSelected.value = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                      ),
                      child: Text('Mês', style: TextStyle(color: AppColors.primaryColor, fontFamily: AppFonts.primaryFont)),
                    ),
              // Botão "Semana"
              !isMonthSelected
                  ? OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = false;
                          isWeekSelected.value = true;
                          
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.tertiaryColor, width: 2),
                      ),
                      child: Text('Semana', style: TextStyle(color: AppColors.tertiaryColor, fontFamily: AppFonts.primaryFont)),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isMonthSelected = false;
                          isWeekSelected.value = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                      ),
                      child: Text('Semana', style: TextStyle(color: AppColors.primaryColor, fontFamily: AppFonts.primaryFont)),
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
